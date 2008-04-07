From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [Help 2/2] MUSB: some USB card readers, USB-IDE cable, 30G old iPod
 will be reset several times in usb-storage transcation
Date: Mon, 7 Apr 2008 05:21:49 -0500
Message-ID: <5bd10b9010c8281ff117f7ebb02f7d39@felipebalbi.com>
References: <386072610804070316i15ee172cue9c0cc5803f9a934@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:38645 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757278AbYDGKVw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 06:21:52 -0400
In-Reply-To: <386072610804070316i15ee172cue9c0cc5803f9a934@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: David Brownell <david-b@pacbell.net>, tony@atomide.com, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com



On Mon, 7 Apr 2008 03:16:31 -0700, "Bryan Wu" <cooloney@kernel.org> wrote:
> Hi folks,
> 
> Here are our trackers, I think following bugs are the same issue:
> USB-IDE cable:
>
https://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_id=141&tracker_item_id=3789
> MicroSD card reader:
>
https://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_id=141&tracker_item_id=3790
> 30G iPod:
>
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.25-rc8/2.6.25-rc8-mm1/2.6.25-rc8-mm1.bz2
> SD card reader:
>
https://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_id=141&tracker_item_id=3807
> 
> a) For the MODE_SENSE(6) SCSI command, these bug usb devices will
> reply stall when host wait for 1st CSW
> b) Linux host will clear halt of the endpoint.
> c) Linux host will wait for the 2nd CSW, but no RX IRQ at all. Then
> USB reset operation will be triggered by Linux host stack
>     when time out
> d) The same bug usb devices is OK on Linux host PC, because they will
> reply to 2nd CSW in the right way.
> e) So I hacked the usb-storage driver code, the Linux host on Blackfin
> will not wait for the 2nc CSW. Then this bug is gone.
> 
> This is just a workaround for that, it should not be the right way.
> Does anyone here meet this issue before, on Davinci or OMAP?
> We always need a real fix, thanks a lot

I've seen this already with n800/n810. It came up after a merge with
mainline
that changed usb subsystem a bit. Tony made musb driver work again after
the merge
but still some issues that should be addressed.

If you wanna dig more on this... patches are welcome :-)

> 
> -Bryan Wu
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

