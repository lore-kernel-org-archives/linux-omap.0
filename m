From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4: Clock: Correct OTG clock to use otg_60m_gfclk.
Date: Wed, 4 Jul 2012 03:10:57 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207040307530.6760@utopia.booyaka.com>
References: <1340970782-30802-1-git-send-email-ruslan.bilovol@ti.com> <alpine.DEB.2.00.1206291434190.2338@utopia.booyaka.com> <4FF1977B.1080002@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44704 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033Ab2GDJK6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 05:10:58 -0400
In-Reply-To: <4FF1977B.1080002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Ruslan Bilovol <ruslan.bilovol@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Mon, 2 Jul 2012, Benoit Cousson wrote:

> Unfortunately the clock fmwk cannot handle module as a clock node.

Hmm.  We have to have similar support in the clockfw for the CLKDIV32K 
clock for AM33xx.  That uses the modulemode bits to enable and disable the 
clock.  Or does this require something more complicated?


- Paul
