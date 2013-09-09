From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] ARM: omap2: throw the die id into the entropy pool
Date: Mon, 9 Sep 2013 20:15:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1309092012000.28435@utopia.booyaka.com>
References: <1378366158-31183-1-git-send-email-linus.walleij@linaro.org> <alpine.DEB.2.02.1309091908270.28435@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37747 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224Ab3IIUPQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Sep 2013 16:15:16 -0400
In-Reply-To: <alpine.DEB.2.02.1309091908270.28435@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>


By the way, if anyone wants to expand on Linus' patch for OMAP, there are 
several other register fields that could be mixed in, which, based on 
their names, might vary on a per-chip basis.  For example, on OMAP4, the 
CONTROL_STD_FUSE_OPP* and CONTROL_DPLL_NWELL_TRIM* registers.



- Paul
