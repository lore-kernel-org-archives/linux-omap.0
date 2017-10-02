From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: make omap_dma_dev_info __initdata
Date: Mon, 2 Oct 2017 12:49:09 -0700
Message-ID: <20171002194909.GR4394@atomide.com>
References: <1505753230-14014-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1505753230-14014-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Bhumika Goyal <bhumirks@gmail.com> [170918 09:48]:
> Make this __initdata as it is only modified only during the initialisation
> phase in the function omap2_system_dma_init_dev and after this it is not
> referenced anywhere in the kernel.

Applying into omap-for-v4.15/soc thanks.

Tony
