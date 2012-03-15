From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: powerdomain: Wait for powerdomain transition
 in pwrdm_state_switch()
Date: Thu, 15 Mar 2012 11:32:30 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1203151129160.26218@utopia.booyaka.com>
References: <1331562873-29535-1-git-send-email-santosh.shilimkar@ti.com> <1331562873-29535-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35417 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032008Ab2CORcc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 13:32:32 -0400
In-Reply-To: <1331562873-29535-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, tony@atomide.com

On Mon, 12 Mar 2012, Santosh Shilimkar wrote:

> Commit b1cbdb00d{OMAP: clockdomain: Wait for powerdomain to be ON
> when using clockdomain force wakeup} was assuming that pwrdm_state_switch()
> does wait for the powerdomain transition which is not the case.
> 
> Fix this API by adding the pwrdm_wait_transition().
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: Rajendra Nayak <rnayak@ti.com>
> CC: Paul Walmsley <paul@pwsan.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

Sounds like this fixes a major kernel oops bug for Tony so this should go 
in ASAP to v3.3-rc series.


- Paul
