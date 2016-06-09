From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: Enable Errata 430973 for OMAP3
Date: Thu, 9 Jun 2016 00:15:13 -0700
Message-ID: <20160609071512.GK22406@atomide.com>
References: <1463700017-18527-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463700017-18527-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [160519 16:23]:
> Enable Erratum 430973 similar to commit 5c86c5339c56 ("ARM:
> omap2plus_defconfig: Enable ARM erratum 430973 for omap3") - Since
> multiple defconfigs can exist from various points of view (multi_v7,
> omap2plus etc.. it is always better to enable the erratum from the
> Kconfig selection point of view so that downstream kernels dont have
> to rediscover this all over again.

This should safe to select now. Note that proc-v7.S still does not
do anything with multiarch to configure it. So the bootloader still
needs to enable it, or it needs to be done in the machine init like
n900 does.

So applying into omap-for-v4.7/fixes as it can solve some mysterious
app crashers with armhf at least.

Regards,

Tony
