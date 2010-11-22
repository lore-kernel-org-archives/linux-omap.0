From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: No more software ECC in omap2.c NAND driver. Why?
Date: Mon, 22 Nov 2010 11:57:01 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0369C42A32@dbde02.ent.ti.com>
References: <201011221001.22909.manningc2@actrix.gen.nz>
 <C90F48F4.2031A%marathon96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57007 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab0KVG1K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 01:27:10 -0500
In-Reply-To: <C90F48F4.2031A%marathon96@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Erickson <marathon96@gmail.com>, Charles Manning <manningc2@actrix.gen.nz>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Grazvydas Ignotas <notasas@gmail.com>



> -----Original Message-----
> From: Grant Erickson [mailto:marathon96@gmail.com]
> Sent: Monday, November 22, 2010 11:39 AM
> To: Charles Manning
> Cc: linux-omap@vger.kernel.org; Grazvydas Ignotas; Ghorai, Sukumar
> Subject: Re: No more software ECC in omap2.c NAND driver. Why?
> 
> On 11/21/10 1:01 PM, Charles Manning wrote:
> > Just recompiling with the CONFIG_MTD_NAND_OMAP_HWECC define commented
> out did
> > not result in a working system. I suspect there is more tto the problem
> than
> > this.
> 
> FWIW, I had the exact same issues with my Mistral AM37x EVM board. I not
> only had to remove/deassert CONFIG_MTD_NAND_OMAP_HWECC, but also had to
> roll
> back nand_base.c and nand_bbt.c back to their 2.6.32 versions (later ones
> between .32 and .35 might have worked but I didn't bother trying) to be
> able
> to read, error-free and correctly, NAND that was erased and written with a
> .32-era kernel.
[Ghorai] are you trying again?
How do you flush the FS (form u-boot or from kernel, nandwrite)? And let me know the test you are doing, to know the steps to reproduce in my platform - zoom/sdp.
 
> 
> Best,
> 
> Grant Erickson
> 

