From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v5 0/3] OMAP2/3: DMA: FIFO drain errata fixes
Date: Tue, 5 Oct 2010 15:25:05 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB9FE819@dbde02.ent.ti.com>
References: <1286261141-1039-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44071 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932729Ab0JEJz2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 05:55:28 -0400
In-Reply-To: <1286261141-1039-1-git-send-email-peter.ujfalusi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <rmk+kernel@arm.linux.org.uk>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Peter Ujfalusi
> Sent: Tuesday, October 05, 2010 12:16 PM
> To: Tony Lindgren
> Cc: linux-omap@vger.kernel.org; Jarkko Nikula; 
> linux-arm-kernel@lists.infradead.org; Russell King
> Subject: [PATCH v5 0/3] OMAP2/3: DMA: FIFO drain errata fixes
> 
> Hello,
> 
> This v5 series is based on the v3.
> The first two patch is the actual fix for the original 
> problems without any major change in the code (only handling 
> the corresponding erratas in the legacy way).
> The third patch in the series is optional, and it is 
> implementing (in one patch) the errata handling via flags. 
> This patch converts all errata cases to use the introduced 
> dma_errata variable via macros.
> 
> Tony: the first two patch need to go for 2.6.36, and if it is 
> possible it shall be backported to .33, .34, and .35 as well.
> The final patch in this series is optional, if you feel like 
> you can take it 
NAK
>(or drop it). 
ACK
>AFAIK the upcoming hwmod 
> changes to dma code will also have similar feature to handle 
> the erratas.
> I'm not sure what is the schedule for the hwmod conversion of dma...
v2 version of dma hwmod patches already exists in LOML which is 
already covering errata handling feature. I can rebase 1/3 and 2/3 
patches into dma hwmod errata handling.

v3 dma hwmod version will be posted soon once these fixes are rebased
and tested on all applicable omap's.

IOW, the errata handling feature comes along with all applicable erratas
ported with dma v3 hwmod series instead of having your patch 3/3 which is 
partially implemented.

-Manjunath




