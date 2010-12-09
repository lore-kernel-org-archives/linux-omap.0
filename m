From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 1/2] I2C: i2c-omap: Change device name: i2c_omap -> omap_i2c
Date: Thu, 09 Dec 2010 12:46:35 -0800
Message-ID: <87wrni7jys.fsf@deeprootsystems.com>
References: <1291904657-32729-1-git-send-email-b-cousson@ti.com>
	<1291904657-32729-2-git-send-email-b-cousson@ti.com>
	<878vzydgxr.fsf@deeprootsystems.com>
	<20101209190110.GR20097@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f180.google.com ([209.85.161.180]:42517 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756655Ab0LIUql (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 15:46:41 -0500
Received: by gxk19 with SMTP id 19so1752542gxk.11
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 12:46:40 -0800 (PST)
In-Reply-To: <20101209190110.GR20097@trinity.fluff.org> (Ben Dooks's message
	of "Thu, 9 Dec 2010 19:01:10 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-i2c@fluff.org>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

Ben Dooks <ben-i2c@fluff.org> writes:

> On Thu, Dec 09, 2010 at 08:55:28AM -0800, Kevin Hilman wrote:
>> Ben,
>> 
>> > The convention for omap device naming is omap_XXX.
>> >
>> > Rename the device and driver name in order to stick
>> > to this naming convention.
>
> Renaming stuff like this is going to have an impact on the userspace
> as anyone looking through /sys's driver heirarchy is going to miss the
> old name... 
>
> It all depends if you really want to go ahead with this...
>

Yes, we are aware of the userspace impact, but this name change makes
all devices on OMAP have consistent names and actually improves the
ability to have userspace tools have consistent naming as well.

Kevin

>> > Change device name in clock nodes as well.
>> >
>> > Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> > c: Paul Walmsley <paul@pwsan.com>
>> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> > Cc: Rajendra Nayak <rnayak@ti.com>
>> > Cc: Ben Dooks <ben-i2c@fluff.org>
>> > ---
>> >  arch/arm/mach-omap1/clock_data.c     |    6 +++---
>> >  arch/arm/mach-omap2/clock2420_data.c |    8 ++++----
>> >  arch/arm/mach-omap2/clock2430_data.c |    8 ++++----
>> >  arch/arm/mach-omap2/clock3xxx_data.c |   12 ++++++------
>> >  arch/arm/mach-omap2/clock44xx_data.c |   16 ++++++++--------
>> >  arch/arm/plat-omap/i2c.c             |    2 +-
>> >  drivers/i2c/busses/i2c-omap.c        |    4 ++--
>> >  7 files changed, 28 insertions(+), 28 deletions(-)
>> 
>> [...]
>> 
>> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> > index 760b8be..9d09083 100644
>> > --- a/drivers/i2c/busses/i2c-omap.c
>> > +++ b/drivers/i2c/busses/i2c-omap.c
>> > @@ -1139,7 +1139,7 @@ static struct platform_driver omap_i2c_driver = {
>> >  	.probe		= omap_i2c_probe,
>> >  	.remove		= omap_i2c_remove,
>> >  	.driver		= {
>> > -		.name	= "i2c_omap",
>> > +		.name	= "omap_i2c",
>> >  		.owner	= THIS_MODULE,
>> >  	},
>> >  };
>> > @@ -1161,4 +1161,4 @@ module_exit(omap_i2c_exit_driver);
>> >  MODULE_AUTHOR("MontaVista Software, Inc. (and others)");
>> >  MODULE_DESCRIPTION("TI OMAP I2C bus adapter");
>> >  MODULE_LICENSE("GPL");
>> > -MODULE_ALIAS("platform:i2c_omap");
>> > +MODULE_ALIAS("platform:omap_i2c");
>> 
>> With your ack for the name change in the driver, we can merge this
>> through the OMAP tree with the other core changes.
>> 
>> Thanks,
>> 
>> Kevin
>> 
>
> -- 
