From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [Help 2/2] MUSB: some USB card readers, USB-IDE cable, 30G old iPod
 will be reset several times in usb-storage transcation
Date: Mon, 7 Apr 2008 07:39:40 -0500
Message-ID: <d0a85e5be1f3a2c7831e16c36f83de92@felipebalbi.com>
References: <386072610804070412m43f7e15cwc647172e55e7400c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46758 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbYDGMjp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 08:39:45 -0400
In-Reply-To: <386072610804070412m43f7e15cwc647172e55e7400c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: David Brownell <david-b@pacbell.net>, tony@atomide.com, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com



On Mon, 7 Apr 2008 04:12:58 -0700, "Bryan Wu" <cooloney@kernel.org> wrote:
>>  > My patch is simply skip to start 2cn CSW operation as below:
>>  > --
>>  > Index: drivers/usb/storage/transport.c
>>  > ===================================================================
>>  > --- drivers/usb/storage/transport.c   (revision 4075)
>>  > +++ drivers/usb/storage/transport.c   (working copy)
>>  > @@ -1034,9 +1034,11 @@ int usb_stor_Bulk_transport(struct scsi_
>>  >
>>  >               /* get the status again */
>>  >               US_DEBUGP("Attempting to get CSW (2nd try)...\n");
>>  > -             result = usb_stor_bulk_transfer_buf(us,
> us->recv_bulk_pipe,
>>  > +             bcs->Status = US_BULK_STAT_OK;
>>  > +             goto bcs_status;
>>  > +/*           result = usb_stor_bulk_transfer_buf(us,
> us->recv_bulk_pipe,
>>  >                               bcs, US_BULK_CS_WRAP_LEN, NULL);
>>  > -     }
>>  > +*/   }
>>
>>  maybe this command triggers a current spike on the zio reader which is
>>  causing the
>>  vbus drop ? could be...
>>
> 
> Oh, no. this issue was found in some USB-IDE cable, USB SD card reader
> and 30G iPod, not in ZiO reader.
> 
> The code of the packet which triggered the ZiO issue was included in
> the ZiO email.

Ugh, my bad :-p

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

