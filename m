From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [Help 2/2] MUSB: some USB card readers, USB-IDE cable, 30G old iPod
 will be reset several times in usb-storage transcation
Date: Mon, 7 Apr 2008 05:49:48 -0500
Message-ID: <3a8523948b12e55c004a5422c4d60944@felipebalbi.com>
References: <386072610804070344n7533b618n3abaf360ed1c7919@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51390 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbYDGKty (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 06:49:54 -0400
In-Reply-To: <386072610804070344n7533b618n3abaf360ed1c7919@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: David Brownell <david-b@pacbell.net>, tony@atomide.com, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com



On Mon, 7 Apr 2008 03:44:12 -0700, "Bryan Wu" <cooloney@kernel.org> wrote:
> On Mon, Apr 7, 2008 at 3:21 AM, Felipe Balbi <me@felipebalbi.com> wrote:
>>
>>
>>
>>  On Mon, 7 Apr 2008 03:16:31 -0700, "Bryan Wu" <cooloney@kernel.org>
> wrote:
>>  > Hi folks,
>>  >
>>  > Here are our trackers, I think following bugs are the same issue:
>>  > USB-IDE cable:
>>  >
>> 
>
https://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_id=141&tracker_item_id=3789
>>  > MicroSD card reader:
>>  >
>> 
>
https://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_id=141&tracker_item_id=3790
>>  > 30G iPod:
>>  >
>> 
>
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.25-rc8/2.6.25-rc8-mm1/2.6.25-rc8-mm1.bz2
>>  > SD card reader:
>>  >
>> 
>
https://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_id=141&tracker_item_id=3807
>>  >
>>  > a) For the MODE_SENSE(6) SCSI command, these bug usb devices will
>>  > reply stall when host wait for 1st CSW
>>  > b) Linux host will clear halt of the endpoint.
>>  > c) Linux host will wait for the 2nd CSW, but no RX IRQ at all. Then
>>  > USB reset operation will be triggered by Linux host stack
>>  >     when time out
>>  > d) The same bug usb devices is OK on Linux host PC, because they will
>>  > reply to 2nd CSW in the right way.
>>  > e) So I hacked the usb-storage driver code, the Linux host on
> Blackfin
>>  > will not wait for the 2nc CSW. Then this bug is gone.
>>  >
>>  > This is just a workaround for that, it should not be the right way.
>>  > Does anyone here meet this issue before, on Davinci or OMAP?
>>  > We always need a real fix, thanks a lot
>>
>>  I've seen this already with n800/n810.
> 
> Oh, thanks god. I'm not the only one struggling in this bug.
> 
>>  It came up after a merge with
>>  mainline
>>  that changed usb subsystem a bit. Tony made musb driver work again
> after
>>  the merge
>>  but still some issues that should be addressed.
>>
> 
> So is that fixed in linux-omap git repo? Maybe I should update my
> local copy with it.

nope... that's what I'm telling you :-)
it only builds, but still some issues to be addressed ;-)

> 
>>  If you wanna dig more on this... patches are welcome :-)
>>
> 
> My patch is simply skip to start 2cn CSW operation as below:
> --
> Index: drivers/usb/storage/transport.c
> ===================================================================
> --- drivers/usb/storage/transport.c	(revision 4075)
> +++ drivers/usb/storage/transport.c	(working copy)
> @@ -1034,9 +1034,11 @@ int usb_stor_Bulk_transport(struct scsi_
> 
>  		/* get the status again */
>  		US_DEBUGP("Attempting to get CSW (2nd try)...\n");
> -		result = usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe,
> +		bcs->Status = US_BULK_STAT_OK;
> +		goto bcs_status;
> +/*		result = usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe,
>  				bcs, US_BULK_CS_WRAP_LEN, NULL);
> -	}
> +*/	}
> 
>  	/* if we still have a failure at this point, we're in trouble */
>  	US_DEBUGP("Bulk status result = %d\n", result);
> @@ -1078,6 +1080,7 @@ int usb_stor_Bulk_transport(struct scsi_
>  		}
>  	}
> 
> +bcs_status:
>  	/* based on the status code, we report good or bad */
>  	switch (bcs->Status) {
>  		case US_BULK_STAT_OK:
> --
> 
> I just don't understand why they are OK on Linux host PC and failed on
> Linux Host embedded MUSB OTG.

PCs have to source up to 500mA load on usb bus, embedded otg/hosts only up
to 100mA.

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

