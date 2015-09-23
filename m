From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP: Remove duplicated operand in OR operation
Date: Wed, 23 Sep 2015 20:08:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1509232007450.30855@utopia.booyaka.com>
References: <1442496171-28741-1-git-send-email-javier@osg.samsung.com> <55FFB1A4.4090107@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55FFB1A4.4090107@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, Roger Quadros <rogerq@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 21 Sep 2015, Roger Quadros wrote:

> On 17/09/15 16:22, Javier Martinez Canillas wrote:
> > Commit b483a4a5a711 ("ARM: OMAP4+: hwmod data: Don't prevent RESET of
> > USB Host module") added the SYSC_HAS_RESET_STATUS flag to both OMAP4
> > and OMAP5 USB host module hwmon sysconfig but that flag was already
> > set for OMAP5. So now the flag appears twice in the expression.
> > 
> > make coccicheck complains with the following message:
> > 
> > omap_hwmod_54xx_data.c:1846:37-58: duplicated argument to & or |
> > 
> > Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> Acked-by: Roger Quadros <rogerq@ti.com>

Thanks, queued for v4.4.

- Paul
