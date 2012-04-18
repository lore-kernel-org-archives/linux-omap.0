From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: omap: hwmod: warn only when clkdm is missing from
 both clk and hwmod
Date: Wed, 18 Apr 2012 03:08:33 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204180307530.29048@utopia.booyaka.com>
References: <1334238098-29859-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1204121106010.29473@utopia.booyaka.com> <4F8E76C3.7080803@ti.com> <alpine.DEB.2.00.1204180217380.29048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55759 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab2DRJIe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 05:08:34 -0400
In-Reply-To: <alpine.DEB.2.00.1204180217380.29048@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 18 Apr 2012, Paul Walmsley wrote:

> Sounds to me like the right time to make this change for OMAP4 is when the 
> call to omap2_clk_disable_clkdm_control() is removed from 
> clock44xx_data.c.

Sorry, this should have read "when the call to 
omap2_clk_disable_clkdm_control() is _uncommented_"


- Paul
