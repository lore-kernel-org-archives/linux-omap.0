From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Odd behavior with dpll4_m4x2_ck on omap3 + DT
Date: Sun, 13 Oct 2013 20:17:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310132012280.27397@utopia.booyaka.com>
References: <521DC143.2010506@ti.com> <521DCD80.1060600@ti.com> <521DE1A6.6030005@ti.com> <522F0390.9050802@gmail.com> <522F0CC7.50501@ti.com> <522F0E3E.1080001@ti.com> <522F0F9B.9050705@ti.com> <522F1346.3020206@ti.com> <522F1BF9.5050006@ti.com>
 <alpine.DEB.2.02.1310070807320.20589@utopia.booyaka.com> <20131008013537.7445.35847@quantum>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37911 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159Ab3JMURw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Oct 2013 16:17:52 -0400
In-Reply-To: <20131008013537.7445.35847@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Stefan Roese <stefan.roese@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

On Mon, 7 Oct 2013, Mike Turquette wrote:

> Well it used to be that calling clk_set_rate(dpll, bypass_rate) would
> put it in bypass, I don't know if that is still the case. But you are
> right that having the implicit assumption that 'bypass rate' == 'DPLL in
> bypass' is not safe since a bootloader could lock this PLL to the same
> rate as it's bypass rate.
> 
> I hope that the bypass rate stuff does not get swept away in the changes
> since it is an interesting way to save a little power.

Yeah, I don't think anyone's proposing to remove it, as far as I know.

Am more concerned about any similar lurking problems in low-level clock 
code that use the current state of the clock hardware to determine a 
possible future rate.  Am hoping that this particular issue is simply due 
to the state dependency between the CLKOUTX2 node and the PLL node.  
Considering this issue, in retrospect, it probably would have been better 
to merge the CLKOUTX2 node with the PLL.


- Paul
