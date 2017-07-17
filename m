From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] mmc: omap: Remove Unused Code
Date: Sun, 16 Jul 2017 23:01:02 -0700
Message-ID: <20170717060101.GB10026@atomide.com>
References: <1500036404-5556-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500036404-5556-1-git-send-email-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: ulf.hansson@linaro.org, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, rk@ti.com, nsekhar@ti.com, linus.walleij@linaro.org, hkallweit1@gmail.com, peter.ujfalusi@ti.com
List-Id: linux-omap@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [170714 05:48]:
> This patch series removes some code in omap_hsmmc.c
> and hsmmc.c and members from hsmmc.h and 
> hsmmc-omap.h which are not used anymore post 
> conversion to device-tree.

Hey that's nice! That gets us a bit closer removing the
old platform data for that driver.

Regards,

Tony
