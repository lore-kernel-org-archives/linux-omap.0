From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMP35xx booting issue
Date: Sat, 20 Oct 2012 07:10:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210200709530.11523@utopia.booyaka.com>
References: <CAPjKCR8wzfPxuts4_i-P-X+fru2C-QwZcp_g=w_eHi0SJ_PgiA@mail.gmail.com> <alpine.DEB.2.00.1210200627180.9865@utopia.booyaka.com> <alpine.DEB.2.00.1210200629010.9865@utopia.booyaka.com>
 <CAPjKCR9ymWpkUPvXePu5NkGTxVaE2HFv5wp24aGBocdZ6nJFzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53212 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000Ab2JTHKO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Oct 2012 03:10:14 -0400
In-Reply-To: <CAPjKCR9ymWpkUPvXePu5NkGTxVaE2HFv5wp24aGBocdZ6nJFzg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anil Kumar <anilkumar880@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, balbi@ti.com, linux-arm-kernel@lists.infradead.org

On Sat, 20 Oct 2012, Anil Kumar wrote:

> devkit8000 is booting with kernel 3.5 and no much diff
> in kernel 3.6/3.5 board files
> 
> i am suspecting here
> 
> omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62

Have you tried using omap2plus_defconfig?


- Paul
