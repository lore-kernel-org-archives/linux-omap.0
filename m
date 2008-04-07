From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [Help 2/2] MUSB: some USB card readers, USB-IDE cable, 30G old iPod will be reset several times in usb-storage transcation
Date: Mon, 7 Apr 2008 04:12:58 -0700
Message-ID: <386072610804070412m43f7e15cwc647172e55e7400c@mail.gmail.com>
References: <386072610804070344n7533b618n3abaf360ed1c7919@mail.gmail.com>
	 <703e8e30c3ab23c731409c7d7b3e2906@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:51233 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbYDGLNC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 07:13:02 -0400
Received: by ug-out-1314.google.com with SMTP id z38so446415ugc.16
        for <linux-omap@vger.kernel.org>; Mon, 07 Apr 2008 04:12:58 -0700 (PDT)
In-Reply-To: <703e8e30c3ab23c731409c7d7b3e2906@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, tony@atomide.com, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com

>  > My patch is simply skip to start 2cn CSW operation as below:
>  > --
>  > Index: drivers/usb/storage/transport.c
>  > ===================================================================
>  > --- drivers/usb/storage/transport.c   (revision 4075)
>  > +++ drivers/usb/storage/transport.c   (working copy)
>  > @@ -1034,9 +1034,11 @@ int usb_stor_Bulk_transport(struct scsi_
>  >
>  >               /* get the status again */
>  >               US_DEBUGP("Attempting to get CSW (2nd try)...\n");
>  > -             result = usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe,
>  > +             bcs->Status = US_BULK_STAT_OK;
>  > +             goto bcs_status;
>  > +/*           result = usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe,
>  >                               bcs, US_BULK_CS_WRAP_LEN, NULL);
>  > -     }
>  > +*/   }
>
>  maybe this command triggers a current spike on the zio reader which is
>  causing the
>  vbus drop ? could be...
>

Oh, no. this issue was found in some USB-IDE cable, USB SD card reader
and 30G iPod, not in ZiO reader.

The code of the packet which triggered the ZiO issue was included in
the ZiO email.

-Bryan
