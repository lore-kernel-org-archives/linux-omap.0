From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: Re: [PATCH 2/2 v2] USB: musb: disable double buffering for older
Date: Tue, 4 May 2010 10:57:49 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E3514B7@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E7394044E3514AB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46931 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979Ab0EDF14 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 01:27:56 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E3514AB@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

Hi,
> >> Kroah-Hartman; Subbrathnam, Swaminathan
> >> Subject: Re: [PATCH 2/2 v2] USB: musb: disable double buffering for
> older
> >> RTL versions
> >>
> >> On Tue, Apr 06, 2010 at 01:46:29PM +0200, ext Gadiyar, Anand wrote:
> >> >With g_zero, do you see a hang or do you have data corruption?
> >>
> >> data corruption. But with our internal mode1 changes, we can use double
> >> buffering with rtl1.8 on omap36xx, so at least rtl1.8 can work.
> >
> >Felipe,
> >
> >Have you ensured using either first 8K or second 8K of FIFO space
> >in your double buffering tests for OMAP35x?
> 
> don't remember right now. But I can only remember seeing that errata on
> 36xx not 34xx/35xx. Can you confirm that.

Yes, this issue is valid for OMAP34x/35x also. I have verified double
Buffering on OMAP3EVM with FIFO space of first 8K and didn't see any issue.

Can you test this on your end and confirm ? We would require reverting this
Patch which is already merged in mainline. 

> 
> >I think you are aware of a known issue on OMAP35x where two active
> >endpoints have to use FIFO either in first 8K or next 8K range. I think
> >double
> >buffering data corruption issue is linked to this known issue and can
> >be
> >avoided if we use FIFO space of first 8K or next 8K.
> 
> problem with this is the endpoint limitation. We would have to cope with
> that if we want mode1 + dbuf to work.
We don't have any option due to the known errata on OMAP34x.

Thanks,
Ajay
> 
> --
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
