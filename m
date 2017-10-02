From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap1: add const and initconst to omap_lcd_config
Date: Mon, 2 Oct 2017 12:39:26 -0700
Message-ID: <20171002193926.GO4394@atomide.com>
References: <1503383150-2363-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503383150-2363-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, aaro.koskinen@iki.fi, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Bhumika Goyal <bhumirks@gmail.com> [170821 23:26]:
> Make these const as they are only passed to a const argument of the function
> omapfb_set_lcd_config.
> Also, replace __initdata with __initconst to avoid section conflict error.
> Done using Coccinelle.

Applying into omap-for-v4.15/omap1 thanks.

Tony
