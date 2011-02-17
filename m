From: Felipe Balbi <balbi@ti.com>
Subject: Re: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
Date: Thu, 17 Feb 2011 19:17:47 +0200
Message-ID: <20110217171747.GC14574@legolas.emea.dhcp.ti.com>
References: <4D5D25F9.8030907@ti.com>
 <20110217151527.GL22356@legolas.emea.dhcp.ti.com>
 <20110217151804.GM22356@legolas.emea.dhcp.ti.com>
 <4D5D3D0B.8090106@ti.com>
 <20110217152648.GO22356@legolas.emea.dhcp.ti.com>
 <4D5D44AF.5050805@ti.com>
 <20110217162000.GP20795@atomide.com>
 <20110217162209.GA13425@legolas.emea.dhcp.ti.com>
 <20110217165953.GR20795@atomide.com>
 <4D5D5770.9020501@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:45119 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757111Ab1BQRRx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 12:17:53 -0500
Received: by mail-bw0-f41.google.com with SMTP id 16so2713841bwz.28
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 09:17:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D5D5770.9020501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Balbi, Felipe" <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kalliguddi, Hema" <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

On Thu, Feb 17, 2011 at 06:14:24PM +0100, Cousson, Benoit wrote:
> On 2/17/2011 5:59 PM, Tony Lindgren wrote:
> >* Felipe Balbi<balbi@ti.com>  [110217 08:20]:
> >>On Thu, Feb 17, 2011 at 08:20:01AM -0800, Tony Lindgren wrote:
> >>>
> >>>Maybe no need to rebase, I'll apply Benoit's series first into
> >>>omap-for-linus, then let's applying the other hwmod related patches
> >>>should be trivial.
> >>
> >>So I can drop the omap4 HWMOD part from my branch ?
> >
> >Yeh assuming Benoit's data is correct.
> 
> Of course, it is :-)
> 
> Then I will add USB in my series.

BTW, which branch should I use from your tree to test ?

-- 
balbi
