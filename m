From: Tomas Novotny <tomas@novotny.cz>
Subject: Re: [PATCH] mfd: twl-core: Fix accessibility of some twl4030 audio
 registers
Date: Tue, 11 Mar 2014 13:16:15 +0100
Message-ID: <20140311131615.45aa4a96@tomas.local.tbs-biometrics.cz>
References: <20140310191250.34f1410e@tomas.local.tbs-biometrics.cz>
	<20140311065217.GE2839@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kazi.fit.vutbr.cz ([147.229.8.12]:26491 "EHLO kazi.fit.vutbr.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754892AbaCKMQ1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Mar 2014 08:16:27 -0400
In-Reply-To: <20140311065217.GE2839@lee--X1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-omap@vger.kernel.org, peter.ujfalusi@ti.com

On Tue, 11 Mar 2014 06:52:17 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> > There are some unused registers in twl4030 at I2C address 0x49 and function
> > twl4030_49_nop_reg() is used to check accessibility of that registers. These
> > registers are written in decimal format but the values are correct in
> > hexadecimal format. (It can be checked few lines above the patched code -
> > these registers are marked as unused there.)
> > 
> > As a consequence three registers of audio submodule are treated as
> > inaccessible (preamplifier carkit right and both handsfree registers).
> > 
> > CC: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Signed-off-by: Tomas Novotny <tomas@novotny.cz>
> > ---
> >  drivers/mfd/twl-core.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> In future, please don't forget to CC LKML.
> 

Ok and thanks for applying.

Tomas
