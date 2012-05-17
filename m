From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Thu, 17 May 2012 13:32:18 -0600
Message-ID: <4FB55242.2080501@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <4FB3D294.4020505@wwwdotorg.org> <CAJe_Zhe6uT7u-+0VEx2XCieuynmK5nOO=4DSpDDS_Q=N8-QtPA@mail.gmail.com> <201205161942.20296.arnd@arndb.de> <CAJe_ZhebPfmLS8ur8FAnmdj37ye25HrE2QF-Qk5PVDnzmpAniQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:33526 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab2EQTcW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 May 2012 15:32:22 -0400
In-Reply-To: <CAJe_ZhebPfmLS8ur8FAnmdj37ye25HrE2QF-Qk5PVDnzmpAniQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 05/16/2012 03:16 PM, Jassi Brar wrote:
> On 17 May 2012 01:12, Arnd Bergmann <arnd@arndb.de> wrote:
...
>> More importantly, you make it very hard to add devices in a board file
>> to a dma controller that already has descriptions for some channels,
>> because you cannot easily extend the chan-map unless you rewrite all of it.
>>
> I am not sure I understand the point.

Ah yes, Arnd has a good point.

If the DMA request routing information is in each client node, then it's
trivial to add DMA clients to board files; you just put the
board-specific nodes and properties in the board file, and there's no
possibility of conflicts; you aren't having to add to or override any
existing property in the base SoC file.

(As background, most ARM device trees are separated out into 1 file
defining all the SoC devices e.g. soc.dtsi, and a separate file for each
board e.g. board.dts, which includes the SoC file.)

Now, the DMA node for an on-SoC DMAC would be in soc.dtsi. Typically,
the DMAC is connected to many on-SoC devices, and hence soc.dtsi would
need to specify the routing information for all those devices to avoid
duplicating it in every board.dts. Now, if you have some DMA requests
that go off-SoC, the board.dts file might want to add to the routing
table to indicate what clients connect to those DMA requests. However,
there's no way in the device tree compiler right now to add to a
property; you can only completely replace it. That would entail
duplicating the entire routing information from soc.dtsi into each
board.dts that wanted to add to it - a bad situation. Splitting the
routing information into chunks in the client nodes avoids this issue
entirely.
