From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/3] iio: adc: cpcap: Fix die temperature
Date: Sat, 20 May 2017 09:35:25 -0700
Message-ID: <20170520163525.GM10472@atomide.com>
References: <20170519034035.16795-1-tony@atomide.com>
 <20170519034035.16795-3-tony@atomide.com>
 <6b8ea7a4-5f5e-2d48-0893-94aa320433c6@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6b8ea7a4-5f5e-2d48-0893-94aa320433c6-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170520 08:58]:
> On 19/05/17 04:40, Tony Lindgren wrote:
> > It seems that "MC13783 Power Management and Audio Ciruit User's Guide"
> > MC1378UG.pdf documents several similar components as in the CPCAP PMIC.
> > 
> > Chapter "9.5.5 Die Temperature and UID" says that the die temperature
> > value is 282 at 25C with LSB of -1.14C. Converting CPCAP PMIC channel3
> > values with following seems to produce values that make sense for a
> > PMIC die:
> > 
> > temperature = 25000 + ((regval - 282) * 114)
> > 
> > As we don't have any other documentation, let's assume the die
> > temperature is unconfigured in the Motorola mapphone Linux kernel
> > and the current temperature conversion table should be only used
> > for the battery thermistor and not for the die temperature.
> Is there any route we have available to confirm this?  I.e. doe anyone
> have one where we can check plausibility?

Well there is also a tmp105 sensor for SoC temperature on board
that I used for some sanity checks :) For the Motorola kernel, it
seems it's doing all the interesting ADC stuff in user space for
battery estimates. So if ch3 is used, it must be using the raw
values. My guess is that ch3 is only used by the PMIC firmware to
automatically cut off power if it gets too hot.

The temperature values seem to make sense now when compared against
the tmp105 values.. The following output is from an idle device with
charger connected with reasonably full battery:

$ ./test-d4-temperature
tmp105: 37187 bat ch0: 33675 die ch3: 46888
tmp105: 37187 bat ch0: 33820 die ch3: 41074
tmp105: 37187 bat ch0: 33525 die ch3: 40390
tmp105: 37125 bat ch0: 33675 die ch3: 40162
tmp105: 37125 bat ch0: 34410 die ch3: 40048
tmp105: 37125 bat ch0: 34555 die ch3: 40162
tmp105: 37125 bat ch0: 33525 die ch3: 40390
...

Add some load with two instances of dd if=/dev/urandom of=/dev/null:

$ ./test-d4-temperature
tmp105: 44250 bat ch0: 37240 die ch3: 51790
tmp105: 44250 bat ch0: 34705 die ch3: 48940
tmp105: 44250 bat ch0: 34705 die ch3: 48484
tmp105: 44250 bat ch0: 34850 die ch3: 48370
tmp105: 44312 bat ch0: 37585 die ch3: 48142
tmp105: 44312 bat ch0: 36895 die ch3: 48484
tmp105: 44375 bat ch0: 34705 die ch3: 48484
tmp105: 44375 bat ch0: 36895 die ch3: 48484
...

So ch3 for the PMIC die temperature seems to follow the load
numbers and makes sense as it provides power to all the devices.
The first value of ch3 often is all over the map though, probably
no way around that..

The script I'm using is:

#!/bin/sh

while [ 1 ]; do
	echo -n "tmp105: $(cat /sys/class/hwmon/hwmon0/temp1_input) "
	echo -n "bat ch0: $(cat /sys/bus/iio/devices/iio:device0/in_temp0_input) "
	echo "die ch3: $(cat /sys/bus/iio/devices/iio:device0/in_temp3_input)"
	sleep 1
done

Regards,

Tony
