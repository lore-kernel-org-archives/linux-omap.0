From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 01/04] ARM: OMAP: Rename twl4030* driver files to
 enable re-use
Date: Thu, 1 Oct 2009 13:38:20 +0100
Message-ID: <20091001123819.GA21973@rakim.wolfsonmicro.main>
References: <1254399409-3473-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:33042 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755524AbZJAMiR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 08:38:17 -0400
Content-Disposition: inline
In-Reply-To: <1254399409-3473-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balajitk@ti.com
Cc: linux-omap@vger.kernel.org, sameo@linux.intel.com, wim@iguana.be, timo.t.kokkonen@nokia.com, ben-linux@fluff.org, lrg@slimlogic.co.uk, p_gortmaker@yahoo.com, a.zummo@towertech.it, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, x0052729@ti.com

On Thu, Oct 01, 2009 at 05:46:49PM +0530, balajitk@ti.com wrote:

> The upcoming TWL6030 is companion chip for OMAP4 like the current TWL4030
> for OMAP3. The common modules like RTC, Regulator creates opportunity
> to re-use the most of the code from twl4030.

> This patch renames few common drivers twl4030* files to twl* to enable
> the code re-use.

>  sound/soc/codecs/twl4030.c                         |    2 +-

Nack on this part of the change.

The TWL6030 audio architecture is noticably different to the TWL4030
audio architecture, most of the digital functionality has been moved
into the OMAP and the I2S/DSP DAIs replaced by PDM links.  Merging the
two drivers was previously suggested in response to the TWL6030 CODEC
driver postings but Misael Lopez Cruz (who is doing the driver) wasn't
happy with the idea.
