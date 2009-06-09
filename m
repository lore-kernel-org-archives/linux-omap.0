From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/3] OMAP3:WDT:Enable support for IVA and SECURE
Date: Tue, 09 Jun 2009 14:10:08 -0700
Message-ID: <87ljo1w1u7.fsf@deeprootsystems.com>
References: <1244495293-17244-1-git-send-email-ubh@ti.com>
	<1244495293-17244-2-git-send-email-ubh@ti.com>
	<1244495293-17244-3-git-send-email-ubh@ti.com>
	<87prddzcp5.fsf@deeprootsystems.com>
	<00695C9C8F8B4448856F48142B4AA201BD76FE9E@dnce02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:53993 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755626AbZFIVKK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2009 17:10:10 -0400
Received: by pzk1 with SMTP id 1so295582pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 09 Jun 2009 14:10:11 -0700 (PDT)
In-Reply-To: <00695C9C8F8B4448856F48142B4AA201BD76FE9E@dnce02.ent.ti.com> (Ulrik Bech Hald's message of "Tue\, 9 Jun 2009 21\:28\:06 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hald, Ulrik Bech" <ubh@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Hald, Ulrik Bech" <ubh@ti.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> Sent: Tuesday, June 09, 2009 9:47 AM
>> To: Hald, Ulrik Bech
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH 2/3] OMAP3:WDT:Enable support for IVA and SECURE
>> 
>> Ulrik Bech Hald <ubh@ti.com> writes:
>> 
>> > This patch enables the IVA and SECURE WDTs in the omap_wdt
>> > driver for omap34xx family. SECURE will be available as /dev/watchdog1
>> > HS/EMU devices and IVA will be available as /dev/watchdog3.
>> > MPU will be available as /dev/watchdog2
>> > For omap versions earlier than 34xx only MPU watchdog is present and
>> > will be available as /dev/watchdog for backwards compatibility.
>> >
>> > Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
>> > ---
>> >  drivers/watchdog/omap_wdt.c |   42 +++++++++++++++++++++++++++++++++++-
>> ------
>> >  1 files changed, 35 insertions(+), 7 deletions(-)
>> >  mode change 100644 => 100755 drivers/watchdog/omap_wdt.c
>> >
>> > diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
>> 
>> [...]
>> 
>> >  static int omap_wdt_open(struct inode *inode, struct file *file)
>> >  {
>> > -	struct omap_wdt_dev *wdev = platform_get_drvdata(omap_wdt_dev);
>> > -	void __iomem *base = wdev->base;
>> > +	struct omap_wdt_dev *wdev;
>> > +	void __iomem *base;
>> > +
>> > +	/* by default MPU wdt is present across omap family */
>> > +	wdev = platform_get_drvdata(omap_wdt_dev[1]);
>> > +
>> > +	/* if multiple wdts, find match between device node and wdt device
>> */
>> > +	if (cpu_is_omap34xx()) {
>> > +		int i;
>> > +		for (i = 0; i < NUM_WDTS; i++) {
>> > +			if (omap_wdt_dev[i]) {
>> > +				wdev = platform_get_drvdata(omap_wdt_dev[i]);
>> > +				if (iminor(inode)
>> > +					== wdev->omap_wdt_miscdev.minor)
>> > +					break;
>> > +			}
>> > +		}
>> > +	}
>> > +
>> > +	base = wdev->base;
>> 
>> Hmm, this does not look right to me.  Any use of cpu_is_* in driver
>> code usually indicates that something is not quite right.  This same
>> watchdog IP is used in some DaVinci family processors and needs to be
>> reused there.
>> 
>> I didn't do the miscdev research, but can't you get the pdev from the
>> miscdev.parent, and from there get the right wdev pointer from the
>> pdev.drvdata.
>> 
>> Otherwise, drop the cpu_is_* and just do inode checking all the time.
>> The way you've done it looks error prone to me.
>
> I can't really see a to way pair the driver and device other than
> doing inode/minor number checking , so I'll just go for the inode
> checking without any dependency on cpu_is_xxx().

OK.

>> 
>> >  	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
>> >  		return -EBUSY;
>> > @@ -263,6 +283,7 @@ static int __devinit omap_wdt_probe(struct
>> platform_device *pdev)
>> >  	struct resource *res, *mem;
>> >  	struct omap_wdt_dev *wdev;
>> >  	int ret;
>> > +	static char wdt_name[32];
>> >
>> >  	/* reserve static register mappings */
>> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> > @@ -271,7 +292,7 @@ static int __devinit omap_wdt_probe(struct
>> platform_device *pdev)
>> >  		goto err_get_resource;
>> >  	}
>> >
>> > -	if (omap_wdt_dev) {
>> > +	if (omap_wdt_dev[pdev->id-1]) {
>> >  		ret = -EBUSY;
>> >  		goto err_busy;
>> >  	}
>> > @@ -318,8 +339,14 @@ static int __devinit omap_wdt_probe(struct
>> platform_device *pdev)
>> >
>> >  	wdev->omap_wdt_miscdev.parent = &pdev->dev;
>> >  	wdev->omap_wdt_miscdev.minor = WATCHDOG_MINOR;
>> > -	wdev->omap_wdt_miscdev.name = "watchdog";
>> >  	wdev->omap_wdt_miscdev.fops = &omap_wdt_fops;
>> > +	wdev->omap_wdt_miscdev.name = "watchdog";
>> > +	if (cpu_is_omap34xx()) {
>> > +		snprintf(wdt_name, sizeof(wdt_name), "watchdog%d", pdev->id);
>> > +		wdev->omap_wdt_miscdev.name = wdt_name;
>> > +		if (pdev->id != 2)
>> > +			wdev->omap_wdt_miscdev.minor = MISC_DYNAMIC_MINOR;
>> > +	}
>> 
>> Again, red flag: cpu_is_*
>> 
>> It might be more consistent to use pdev->dev->name which is already of
>> the form "watchdog.%d".
>
> Not sure I follow. I don't see a "name" field in struct device, only init_name.

Sorry, I meant dev->bus_id.  Look at dev_set_name() which creates
a bus_id of the form ("%s.%d", pdev->name, pdev->id)

> Do you mean just using:
> snprintf(wdt_name, sizeof(wdt_name), "watchdog%d", pdev->id);
> wdev->omap_wdt_miscdev.name = wdt_name;

Using pdev->id is ok, but that's what dev_set_name() does.

Note that if you decide to go this route, note that wdt_name doesn't
need to be static.  The driver core will copy the name field the
misc_device.  If it wasn't copying, you'd have all of the miscdev.name
fields ending up being the same thing since they are all assigned the
same pointer.

Kevin

> ...for all the WDT devices, despite how many are present?
>
>> 
>> Any reason not to use MISC_DYNAMIC_MINOR for all of them?
>
> No particular reason other than I thought that retaining the use of WATCHDOG_MINOR for the MPU WDT case would be appropriate. But it does make the code cleaner to use only MISC_DYNAMIC_MINOR. I'll change it.
>
> Thanks for reviewing!
>
>> 
>> Kevin
