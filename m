From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 1/3] ARM: OMAP2: hwmod: AM43XX: Add hwmod support for
 HDQ-1W
Date: Tue, 3 Mar 2015 04:39:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1503030439090.29683@utopia.booyaka.com>
References: <1425293374-30878-1-git-send-email-vigneshr@ti.com> <1425293374-30878-2-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425293374-30878-2-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Evgeniy Polyakov <zbr@ioremap.net>, Jonathan Corbet <corbet@lwn.net>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, NeilBrown <neilb@suse.de>, Benoit Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, 2 Mar 2015, Vignesh R wrote:

> From: "Poddar, Sourav" <sourav.poddar@ti.com>
> 
> These adds hwmod data for hdq/1w driver on AM43xx.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> Change log:
> v2:
>  * Add SYSC_HAS_AUTOIDLE flag.
> 
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 36 ++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/prcm43xx.h             |  1 +
>  2 files changed, 37 insertions(+)
> 

Thanks, queued for v4.1.


- Paul
