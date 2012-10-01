From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.6-rc7
Date: Mon, 1 Oct 2012 23:28:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210012318460.26402@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209241919130.25811@utopia.booyaka.com> <50645A1D.5040108@compulab.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55050 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab2JAX2K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Oct 2012 19:28:10 -0400
In-Reply-To: <50645A1D.5040108@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 27 Sep 2012, Igor Grinberg wrote:

> Have you tried the nohlt boot parameter?
> It looks like the wfi is killing those SoCs once you use EMAC.

Just tried with nohlt.  Didn't help on CM-T3517 with either NFS or MMC 
root, nor with the 3517EVM with NFS root.  But I was able to get the 
3517EVM booting to userspace with MMC root.  Looks like the CM-T3517 board 
file is missing the MMC setup code, so would guess that adding that back 
in would help.


 - Paul
