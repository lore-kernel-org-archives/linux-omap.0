From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: RE: [PATCH 5/6] usb: ohci: don't hard-code TLL channel count
Date: Thu, 19 Aug 2010 12:56:20 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B39A3416@dbde02.ent.ti.com>
References: <1282100145-27485-1-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-2-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-3-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-4-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-5-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-6-git-send-email-keshava_mgowda@ti.com>
 <20100819060308.GT4385@nokia.com>
 <0680EC522D0CC943BC586913CF3768C003B39A33E9@dbde02.ent.ti.com>
 <20100819072312.GV4385@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37164 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526Ab0HSH01 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 03:26:27 -0400
In-Reply-To: <20100819072312.GV4385@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>

> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
> Sent: Thursday, August 19, 2010 12:53 PM
> To: Munegowda, Keshava
> Cc: Balbi Felipe (Nokia-MS/Helsinki); linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; Gadiyar,
> Anand
> Subject: Re: [PATCH 5/6] usb: ohci: don't hard-code TLL channel count
> 
> Hi,
> 
> please teach your mailer to break the lines at 80 characters.
> 
> On Thu, Aug 19, 2010 at 08:26:06AM +0200, ext Munegowda, Keshava wrote:
> >The function ohci_omap3_tll_config will be used with different tll
> >channel count in case of OMAP4 support soon, hence this change is
> >required.  We have removed only the hardcoded values used by this
> >function.
> 
> ok then. That's what I expected to hear.
> 
> --
> balbi
> 
> DefectiveByDesign.org

Thanks balbi, sure I take care this in future.

Keshava Munegowda

