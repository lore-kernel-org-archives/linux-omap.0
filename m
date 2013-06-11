From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/3] ARM: dts: OMAP3: Use MTD constants for OMAP3 boards
Date: Tue, 11 Jun 2013 10:27:26 -0600
Message-ID: <51B74FEE.1010301@wwwdotorg.org>
References: <1370962138-9631-1-git-send-email-florian.vaussard@epfl.ch> <1370962138-9631-4-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:38886 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755195Ab3FKQ13 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jun 2013 12:27:29 -0400
In-Reply-To: <1370962138-9631-4-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Anil Kumar <anilk4.v@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On 06/11/2013 08:48 AM, Florian Vaussard wrote:
> Use the MTD constants for NAND and OneNAND nodes used in OMAP3
> DTS.

I don't quite understand the split between patches 2/3 and 3/3; isn't
the edit to omap3-overo.dtsi (part of) a board file, and hence logically
part of this patch? I'd be tempted just to squash the two together.

But, this is a nit; not a big deal.
