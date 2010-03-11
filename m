From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: compile break on dss2 branch for zoom3
Date: Thu, 11 Mar 2010 13:43:00 +0200
Message-ID: <1268307780.28571.101.camel@tubuntu.research.nokia.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026EFB4FA5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:54404 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757508Ab0CKLnZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 06:43:25 -0500
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94026EFB4FA5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Y, Kishore" <kishore.y@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2010-03-11 at 12:40 +0100, ext Y, Kishore wrote:
> Hi Tomi,
> 	I am unable to compile dss2 tree for zoom3. Commit I am using following commit id
> 
> 893d461b538e889da350061edaadeb8a9289913c
> OMAP: DSS2: quick hack for set mode
> 
> 
> Error I see is related to usb:-
> drivers/usb/core/hcd.c: In function 'usb_hcd_resume_root_hub':
> drivers/usb/core/hcd.c:1892: error: 'pm_wq' undeclared (first use in this function)
> drivers/usb/core/hcd.c:1892: error: (Each undeclared identifier is reported only once
> drivers/usb/core/hcd.c:1892: error: for each function it appears in.)
> make[3]: *** [drivers/usb/core/hcd.o] Error 1
> make[2]: *** [drivers/usb/core] Error 2
> make[1]: *** [drivers/usb] Error 2
> make: *** [drivers] Error 2
> 
> When I disable usb, build goes through but the board does not bootup with this image. It is stuck at uncompressing linux.

Yes, mainstream linux tree seems to be broken. Not much I can do to help
you there. You can try rebasing on top of later mainstrean version,
perhaps it's been fixed there.

 Tomi


