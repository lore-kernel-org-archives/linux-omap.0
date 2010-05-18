From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] Initial attempt to make ARM use LMB
Date: Tue, 18 May 2010 09:40:13 +0100
Message-ID: <20100518084013.GA13832@n2100.arm.linux.org.uk>
References: <20100513220139.GO3428@atomide.com> <20100513221229.GD13001@n2100.arm.linux.org.uk> <EAF47CD23C76F840A9E7FCE10091EFAB02C54F0247@dbde02.ent.ti.com> <AANLkTikZvfvjY9e2QNWRwVcJcTvn58Ly_DgzrcXKu2iJ@mail.gmail.com> <20100514101615.GF10339@n2100.arm.linux.org.uk> <AANLkTinY9M2cHKw86hTLaMUCvBX57o8AioBtrENB-JhK@mail.gmail.com> <20100517094421.GG23118@n2100.arm.linux.org.uk> <1274091978.2307.49.camel@tubuntu.research.nokia.com> <20100517173715.GA5818@atomide.com> <1274168877.2307.70.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46739 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756989Ab0ERIkn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 04:40:43 -0400
Content-Disposition: inline
In-Reply-To: <1274168877.2307.70.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, May 18, 2010 at 10:47:57AM +0300, Tomi Valkeinen wrote:
> Allocating without ioremapping... dma_alloc_* always ioremaps the
> allocated area, even though it's never used (in some cases).

What do you mean by that?  Are you suggesting that something does
phys_to_virt() on the returned DMA pointer?

Why is it that OMAP seems to do all these _wrong_ things?
