From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3+: DPLL: stop reparenting to same parent if
 already done
Date: Thu, 20 Feb 2014 03:04:55 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1402200304150.25798@utopia.booyaka.com>
References: <1391591048-19433-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391591048-19433-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 5 Feb 2014, Nishanth Menon wrote:

> omap3_noncore_dpll_set_rate forces a reparent to the same clk_ref
> for every call that takes place. This is an can be done only if a change
> is detected.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Queued for v3.15 with Tero's ack unless the patch is updated to indicate 
that it's more than an optimization.


- Paul
