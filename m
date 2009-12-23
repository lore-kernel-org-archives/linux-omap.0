From: "Pagare, Abhijit" <abhijitpagare@ti.com>
Subject: RE: [PATCH 1/1] ARM: OMAP4: PM: Remove the checks preventing OMAP4
 clockdomain validation
Date: Wed, 23 Dec 2009 16:57:53 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C017980E@dbde02.ent.ti.com>
References: <1261391747-24066-1-git-send-email-abhijitpagare@ti.com>
 <alpine.DEB.2.00.0912220911160.5563@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43518 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224AbZLWL2G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Dec 2009 06:28:06 -0500
In-Reply-To: <alpine.DEB.2.00.0912220911160.5563@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

Paul,
	While testing after the below change I found out that some sleep/wakeup dependency related checks have to be avoided for OMAP4 to boot up properly as the dependencies have not been populated currently for OMAP4. 	Also I was validating the clock->clockdomain registering and noticed that one of the clock-domains is missing in the auto-generated file.
	So along with the current patch in discussion I am sending two separate patches for fixing the above things as well.

Best Regards,
Abhijit Pagare

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, December 22, 2009 9:43 PM
> To: Pagare, Abhijit
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Cousson, Benoit; Nayak, Rajendra
> Subject: Re: [PATCH 1/1] ARM: OMAP4: PM: Remove the checks preventing
> OMAP4 clockdomain validation
> 
> Hello Abhijit,
> 
> On Mon, 21 Dec 2009, Abhijit Pagare wrote:
> 
> > The clockdomain related code beng in place it is now not necessary to
> have
> > some of the clock code commented out. This would help the validation of
> the
> > clockdomain functions using the clock level interfaces.
> >
> > Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Rajendra Nayak <rnayak@ti.com>
> 
> Could you also deal with the TODO in mach-omap2/clock44xx_data.c ?
> 
> Also, has this patch been tested?  If so, please list the platform it was
> tested on in the commit message.
> 
> thanks,
> 
> - Paul
