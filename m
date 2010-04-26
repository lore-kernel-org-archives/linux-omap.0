From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: fix gpmc nand setup when no timings supplied
Date: Mon, 26 Apr 2010 11:14:49 -0700
Message-ID: <20100426181448.GG7225@atomide.com>
References: <1271670618-5671-1-git-send-email-mike@compulab.co.il>
 <4BCFDC6F.6010801@compulab.co.il>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030D5D7ADD@dbde02.ent.ti.com>
 <4BCFF3C1.5070005@compulab.co.il>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030D5D7B5A@dbde02.ent.ti.com>
 <4BD00C9A.8050601@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50094 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab0DZSOv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 14:14:51 -0400
Content-Disposition: inline
In-Reply-To: <4BD00C9A.8050601@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Mike Rapoport <mike@compulab.co.il> [100422 01:41]:
> Ghorai, Sukumar wrote:
> 
> CM-T35, for instance can be assembled with different NAND flash
> chips. Besides, boards that use NAND as primary boot device, we
> anyway depend on proper GPMC configuration in the bootloader chain.
> Having ability to define GPMC timings in the kernel and keep the
> settings made by the bootloader adds flexibility level for board
> designers.

Not implementing the retime function for GPMC will cause issues
with PM as you cannot scale the L3 frequency without breaking
your GPMC timings.

Tony
