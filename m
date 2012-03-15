From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: powerdomain: Wait for powerdomain transition
 in pwrdm_state_switch()
Date: Thu, 15 Mar 2012 17:34:04 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1203151733360.5007@utopia.booyaka.com>
References: <1331562873-29535-1-git-send-email-santosh.shilimkar@ti.com> <1331562873-29535-2-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1203151129160.26218@utopia.booyaka.com> <20120315175122.GB7276@atomide.com> <alpine.DEB.2.00.1203151701290.2133@utopia.booyaka.com>
 <20120315232256.GC7276@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55286 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031170Ab2COXeF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 19:34:05 -0400
In-Reply-To: <20120315232256.GC7276@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

On Thu, 15 Mar 2012, Tony Lindgren wrote:

> It seems that I need this patch plus need to undo the wrong
> serial muxing in commit 7496ba30 (ARM: OMAP2+: UART: Add default mux
> for all uarts) to make my zoom3 boot reliably.

Okay.  Well want to take the powerdomain patch for the v3.3-rc series 
then?

- Paul
