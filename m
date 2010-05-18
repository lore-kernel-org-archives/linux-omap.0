From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Tue, 18 May 2010 11:58:10 +0300
Message-ID: <1274173090.2307.100.camel@tubuntu.research.nokia.com>
References: <20100513220139.GO3428@atomide.com>
	 <20100513221229.GD13001@n2100.arm.linux.org.uk>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C54F0247@dbde02.ent.ti.com>
	 <AANLkTikZvfvjY9e2QNWRwVcJcTvn58Ly_DgzrcXKu2iJ@mail.gmail.com>
	 <20100514101615.GF10339@n2100.arm.linux.org.uk>
	 <AANLkTinY9M2cHKw86hTLaMUCvBX57o8AioBtrENB-JhK@mail.gmail.com>
	 <20100517094421.GG23118@n2100.arm.linux.org.uk>
	 <1274091978.2307.49.camel@tubuntu.research.nokia.com>
	 <20100517173715.GA5818@atomide.com>
	 <1274168877.2307.70.camel@tubuntu.research.nokia.com>
	 <20100518084013.GA13832@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37090 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab0ERI6c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 04:58:32 -0400
In-Reply-To: <20100518084013.GA13832@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: ext Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2010-05-18 at 10:40 +0200, ext Russell King - ARM Linux wrote:
> On Tue, May 18, 2010 at 10:47:57AM +0300, Tomi Valkeinen wrote:
> > Allocating without ioremapping... dma_alloc_* always ioremaps the
> > allocated area, even though it's never used (in some cases).
> 
> What do you mean by that?  Are you suggesting that something does
> phys_to_virt() on the returned DMA pointer?

No.

VRFB rotation HW uses the real memory as a backend storage, and exposes
0/90/180/270 degree views of that memory area via its own memory areas.
So we need to reserve the real memory, program it to VRFB HW, and then
map VRFB's memory areas, which are used as framebuffers. The real memory
is never used directly in this case.

And even when not using VRFB, I think it's not really required to map
the framebuffer into kernel virtual memory. The kernel doesn't
read/write from/to the framebuffer (except when using FB console), it's
the user space, SGX or DSP that does the writing, and DSS which does the
reading. However, currently the framebuffer is always mapped.

 Tomi


