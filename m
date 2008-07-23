From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [Resending - PATCH 1/3] Triton BCI driver board/device setup for OMAP3430
Date: Wed, 23 Jul 2008 10:16:27 +0530
Message-ID: <002301c8ec7f$1405df30$37f6180a@ent.ti.com>
References: <38309.192.168.10.89.1216727733.squirrel@dbdmail.itg.ti.com> <1473aac0380c8c62329714e83f6ca795@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45747 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463AbYGWEqt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jul 2008 00:46:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Mikko.K.Ylinen@nokia.com

Hi Felipe,

> Tony, weird that we still have these prototypes in these headers.
> Could be some merging conflict ?
Yes. I see that these prototypes are still present in the board3430 and board2430 header files in the omap tree.

> Anyways, please apply the attached patch. We're using
> usb_musb_init() and usb_ehci_init() now.
You mean I should apply the attached patch you sent for local use, right? And I guess I dont need to resend this perticular BCI patch, am I correct?

Regards,
Madhu

----- Original Message ----- 
From: "Felipe Balbi" <me@felipebalbi.com>
To: "Tony Lindgren" <tony@atomide.com>
Cc: "Madhusudhan Chikkature" <madhu.cr@ti.com>; <linux-omap@vger.kernel.org>; <Mikko.K.Ylinen@nokia.com>
Sent: Tuesday, July 22, 2008 6:03 PM
Subject: Re: [Resending - PATCH 1/3] Triton BCI driver board/device setup for OMAP3430


> Hi,
> 
> 
> On Tue, 22 Jul 2008 17:25:33 +0530 (IST), "Madhusudhan Chikkature"
> <madhu.cr@ti.com> wrote:
>>  extern void sdp3430_usb_init(void);
> 
> Tony, weird that we still have these prototypes in these headers.
> Could be some merging conflict ?
> 
> Anyways, please apply the attached patch. We're using
> usb_musb_init() and usb_ehci_init() now.
> 
> 
> 
> -- 
> Best Regards,
> 
> Felipe Balbi
> http://blog.felipebalbi.com
> me@felipebalbi.com
