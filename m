From: Tony Lindgren <tony@atomide.com>
Subject: Re: Charge counter on droid 4
Date: Thu, 5 Jul 2018 01:26:52 -0700
Message-ID: <20180705082652.GW112168@atomide.com>
References: <20180615080014.GA29192@amd>
 <20180615083156.GA32102@amd>
 <20180618065827.GN112168@atomide.com>
 <20180618074023.GA16955@amd>
 <20180618082858.GO112168@atomide.com>
 <20180618093459.GA21391@amd>
 <20180618114832.GR112168@atomide.com>
 <20180704195655.GB13932@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180704195655.GB13932@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180704 19:59]:
> On Mon 2018-06-18 04:48:32, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [180618 09:37]:
> > > On Mon 2018-06-18 01:28:58, Tony Lindgren wrote:
> > > > * Pavel Machek <pavel@ucw.cz> [180618 07:43]:
> > > > > 
> > > > > So... there are mA, mAh values. Those come from hardware, and I
> > > > > believe we should keep them.
> > > > > 
> > > > > But there are also mW, mWh values, which are synthetic. Userland can
> > > > > compute them from mV, mA values... and it is confusing that kernel
> > > > > provides them. (My tendency was to start computing these synthetic
> > > > > values in userland, to compare them with "real hardware" values from
> > > > > kernel. But then I looked at kernel implementation, and realized they
> > > > > are synthetic, tooo...)
> > > > 
> > > > Hmm mWh value is based on the hardware sampled shunt
> > > > values and number of samples gathered between the
> > > > two readings. I'd rather call the calculated values
> > > > based on userland reading mV and mA values "synthetic" :)
> > > 
> > > As far as I know, shunt resistors provide you with current (mA) not
> > > power (mW) measurement... and cpcap-battery computes power_now as
> > > voltage * current. I'd rather have kernel tell me "hardware can't
> > > measure power" and do "voltage*current" computation in userspace.
> > 
> > Yup you are correct the hardware samples mA and we still need
> > to calculate mW based on the voltage.
> > 
> > But considering it works and seems to match the power supply
> > provided average power consumption numbers pretty well and at
> > least I'm using it.. What is your reasoning for removing such
> > a usable interface?
> 
> Well, it is confusing for the userland, because it has no way of
> knowing data is synthetic.

Also the average current is as synthetic. And we don't
want to rely on user space polling the voltage as that
will mess up measurements for low-power idle states.

If there is a problem let's fix it by adding a timer
to refresh average current and power once a minute or
something like that.

I'd rather not have to rely on user space apps for
any knowledge about how to use it.

Regards,

Tony
