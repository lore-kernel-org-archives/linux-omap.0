From: Jonathan Cameron <kernel@jic23.retrosnub.co.uk>
Subject: Re: [PATCH V2] misc : ROHM BH1780GLI Ambient light sensor Driver
Date: Tue, 01 Jun 2010 21:39:10 +0100
Message-ID: <4C056FEE.3040107@jic23.retrosnub.co.uk>
References: <39216.10.24.255.17.1274699065.squirrel@dbdmail.itg.ti.com> <20100601131244.7164b43c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100601131244.7164b43c.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hemanth V <hemanthv@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Jonathan Cameron <jic23@cam.ac.uk>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

On 06/01/10 21:12, Andrew Morton wrote:
> 
> I re-added your reviewers to the cc...
> 
> On Mon, 24 May 2010 16:34:25 +0530 (IST)
> "Hemanth V" <hemanthv@ti.com> wrote:
> 
>> This patch adds support for ROHM BH1780GLI Ambient light sensor.
>>
>> BH1780 supports I2C interface. Driver supports read/update of power state and
>> read of lux value (through SYSFS). Writing value 3 to power_state enables the
>> sensor and current lux value could be read.
> 
> There are at least two other ambient light sensor drivers:
> drivers/misc/isl29003.c and drivers/misc/tsl2550.c.
for ref there is also drivers/staging/iio/light/tsl2563.c
and intent to pick up the other two soon (probably when, hopefully
IIO leaves staging, we could do it now if people prefer. Having two
drivers in the short term is also an option).

As for abi cleanup.  We had all authors and contributors to all the
above agreeing to standardization changes for ALS (and probably
all the users ;) so we are probably in a position to change things
now before there are too many users!
> 
> Is there any standardisation of the ABIs whcih these drivers offer?  If
> so, does this new driver comply with that?
Sadly that was one of the things ALS was meant to clean up.  I've proposed
one under IIO that is effectively the equivalent of hwmon (we have a lot
of overlap in supported device types with hwmon, so as Greg KH suggested
have matched their interface where it exists).

illuminance0_input (measured in lux)

The other exports of light sensors are remarkably inconsistent across different
devices. At the moment all the in kernel drivers only support polled reading
via sysfs.  There are tsl2563 interrupt patches on linux-iio list (not that
it is particularly relevant here).  I've also proposed some other naming
for the weird bits of tsl2563 in that patch series.
(http://marc.info/?l=linux-iio&m=127473503113241&w=2)

> 
> It would be most useful if the changelog were to fully describe the
> proposed kernel<->userspace interface.  That's the most important part
> of the driver, because it's the only part we can never change.
> 
> There is a desultory effort to maintain sysfs API descriptions under
> Documentation/ABI/.  I'd have thought that it would be appropriate to
> document this driver's ABI in there.
Agreed, but we get back to the debate of what we should standardise on.
The main point of ALS before it died was exactly putting this standardization
in place (admittedly the interface was slightly different from what we
are proposing in IIO, but that was before Greg pointed out that sharing
with hwmon would be a good idea!)

I have to admit I'm a little loath to spend too much time on this given
the amount of time wasted previously (ALS).

Jonathan
