From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: [PATCH 2/2] PLAT-OMAP: MCBSP: Move code mach specific from plat-omap to mach-omap
Date: Tue, 22 Apr 2008 14:54:21 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A001922611@dbde01.ent.ti.com>
References: <20080414181827.GE4463@kedavra.cpe.vivax.com.br> <1208203891-11225-1-git-send-email-edubezval@gmail.com> <1208203891-11225-2-git-send-email-edubezval@gmail.com> <20080421183305.GB12099@atomide.com> <a0580c510804212329p141712d7g97bf9f07dbd59621@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:56551 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755434AbYDVJZQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2008 05:25:16 -0400
Content-class: urn:content-classes:message
In-Reply-To: <a0580c510804212329p141712d7g97bf9f07dbd59621@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

Hi Eduardo,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Eduardo Valentin
> Sent: Tuesday, April 22, 2008 12:00 PM
> To: Tony Lindgren
> Cc: linux-omap@vger.kernel.org; Eduardo Valentin
> Subject: Re: [PATCH 2/2] PLAT-OMAP: MCBSP: Move code mach specific from
> plat-omap to mach-omap
> 
> Hi Tony,
> 
> I'll apply your comments and re-write mcbsp driver as a platform driver.
>

Good to know you are volunteering for upgrading McBSP driver.

Can you also make sure that McBSP driver uses DMA chaining APIs? With out chaining support McBSP Driver will be unusable for a real time audio playback.

Thanks

Regards,
Khasim
