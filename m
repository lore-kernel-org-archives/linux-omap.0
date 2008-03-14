From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: omapfb driver support of DSS rotation and mirroring
Date: Fri, 14 Mar 2008 12:07:28 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A0017B1CFC@dbde01.ent.ti.com>
References: <c656a4d20803132303o9eed571ma33963219e4f9ddb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39262 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807AbYCNGi7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Mar 2008 02:38:59 -0400
Content-class: urn:content-classes:message
In-Reply-To: <c656a4d20803132303o9eed571ma33963219e4f9ddb@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arun.edarath@gmail.com>, linux-omap@vger.kernel.org


Hi Arun,

> I am working on 2430 SDP and using the latest git kernel.
> 
> I tried to rotate the framebuffer by setting the following in the bootargs
> video=omapfb:rotate:90
> video=omapfb:rotate:180
> video=omapfb:rotate:270
> 

I think it is video=omapfb:rotate=270

> But it seemed to fail, the penguin is always appearing at the
> top left corner.
> 
> Similar way i tried mirroring also, i got the same result.
> 

But I don't see VRFB support for rotation in GIT version of FB driver. With DMA based rotation you will end in FIFO underflow as it will not be able to meet the bandwidth requirement, you can try to port VRFB support to GIT, it might look bit complex, I can help you out in understanding (if required).

Regards,
Khasim
