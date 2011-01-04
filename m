From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v3 1/4] TI816X: Update common omap platform files
Date: Tue, 4 Jan 2011 10:49:09 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101041046540.9203@utopia.booyaka.com>
References: <1294075737-22320-1-git-send-email-hemantp@ti.com> <alpine.DEB.2.00.1101031603070.10403@utopia.booyaka.com> <20110104015008.GX7771@atomide.com> <2A3DCF3DA181AD40BDE86A3150B27B6B036A57AF93@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52015 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab1ADRtK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 12:49:10 -0500
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B036A57AF93@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pedanekar, Hemant" <hemantp@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

On Tue, 4 Jan 2011, Pedanekar, Hemant wrote:

> Looking at above, it seems another config option like 
> CONFIG_SOC_OMAP3XXX is also needed in addition to CONFIG_SOC_OMAPTI816X.

We already have CONFIG_ARCH_OMAP3430, CONFIG_ARCH_OMAP2430, and 
CONFIG_ARCH_OMAP2420.  I guess at some point those need to be renamed to 
CONFIG_SOC_*.

- Paul
