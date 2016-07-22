From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: hwmod data: Add sysc information for DSI
Date: Fri, 22 Jul 2016 00:14:42 -0700
Message-ID: <20160722071442.GY28140@atomide.com>
References: <1466733573-19177-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466733573-19177-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [160623 19:02]:
> Add missing sysconfig/sysstatus information
> to OMAP3 hwmod. The information has been
> checked against OMAP34xx and OMAP36xx TRM.
> 
> Without this change DSI block is not reset
> during boot, which is required for working
> Nokia N950 display.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
> Hi,
> 
> This is an updated version of this patch [0]. Instead
> of the workaround implemented in [0], this patch fixes
> the root problem - missing hwmod data. I think it should
> be added to -rc.
> 
> [0] http://article.gmane.org/gmane.comp.video.dri.devel/153665

Sorry for the delay in replying, I was offline for few weeks.
I'll add this into fixes for v4.8 with cc stable as it's not
a regression or a oops.

Regards,

Tony
