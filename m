From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] watchdog:OMAP3:Enable support for IVA2 and SECURE
Date: Wed, 17 Jun 2009 07:33:43 -0700
Message-ID: <87y6rrylo8.fsf@deeprootsystems.com>
References: <1245100312-2312-1-git-send-email-ubh@ti.com>
	<1245100312-2312-2-git-send-email-ubh@ti.com>
	<1245100312-2312-3-git-send-email-ubh@ti.com>
	<87fxe042sg.fsf@deeprootsystems.com>
	<00695C9C8F8B4448856F48142B4AA201BD8D89BE@dnce02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f187.google.com ([209.85.222.187]:49083 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbZFQOdn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 10:33:43 -0400
Received: by pzk17 with SMTP id 17so432807pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 17 Jun 2009 07:33:46 -0700 (PDT)
In-Reply-To: <00695C9C8F8B4448856F48142B4AA201BD8D89BE@dnce02.ent.ti.com> (Ulrik Bech Hald's message of "Wed\, 17 Jun 2009 16\:17\:02 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hald, Ulrik Bech" <ubh@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Hald, Ulrik Bech" <ubh@ti.com> writes:

[...]

>> 
>> Drop this and just use the inode match.
>> 
> Was considering that, but ended up defaulting value instead of error checking later. I'll change the above.
>
>> > +	/* Find match between device node and wdt device */
>> > +	int i;
>> > +	for (i = 0; i < NUM_WDTS; i++) {
>> > +		if (omap_wdt_dev[i]) {
>> > +			wdev = platform_get_drvdata(omap_wdt_dev[i]);
>> > +			if (iminor(inode) == wdev->omap_wdt_miscdev.minor)
>> > +				break;
>> > +		}
>> > +	}
>> 
>> You should check for a valid match here.
>> 
> The sanity check I would choose here is
>
> struct omap_wdt_dev *wdev = NULL;
> ...
> <inode matching>
> ...
> if(!wdev)
> 	return -ENODEV; 
>

Looks fine.

[...]

>> 
>> The more think about this, the more I don't like this pdev->id
>> switching in the driver.  The only thing it is needed for
>> is to set the name of the node.
>> 
>> Instead, why not set the name in devices.c and pass it in
>> using platform_data.
>> 
>> Then you can drop the enum and the pdev->id switching.
>> 
>
> That does simplify things a bit. Had overlooked that way of sharing info between device and driver.
> So, devices.c would have something like:
>
> static struct platform_device omap_secure_wdt_device = {
> 	.name = "omap_wdt",
> 	.id = 1,
> 	.num_resources = ARRAY_SIZE(secure_wdt_resources),
> 	.resource = secure_wdt_resources,
> 	.dev = {
> 		.platform_data = "watchdog_secure",
> 	},
> };
>
> And omap_wdt.c would have in probe():
>
> wdev->omap_wdt_miscdev.name = (char *) pdev->dev.platform_data;
>
> Is that more like what you had in mind?
>

Exactly.

This is typically done with a platform_data struct, and a pointer to
the struct is passed as the platform_data, but in this case since the
struct would only have one field for the name pointer, this should be
fine.

Kevin

