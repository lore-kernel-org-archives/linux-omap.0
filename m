From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: omap2: mark unused functions as __maybe_unused
Date: Tue, 23 Feb 2016 08:07:12 -0800
Message-ID: <20160223160711.GX13417@atomide.com>
References: <1456235876-4088840-1-git-send-email-arnd@arndb.de>
 <1456235876-4088840-2-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456235876-4088840-2-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [160223 05:58]:
> The omap_generic_init() and omap_hwmod_init_postsetup() functions are
> used in the initialization for all OMAP2+ SoC types, but in the
> extreme case that those are all disabled, we get a warning about
> unused code:
> 
> arch/arm/mach-omap2/io.c:412:123: error: 'omap_hwmod_init_postsetup' defined but not used [-Werror=unused-function]
> arch/arm/mach-omap2/board-generic.c:30:123: error: 'omap_generic_init' defined but not used [-Werror=unused-function]
> 
> This annotates both as __maybe_unused to shut up that warning.

Looks OK to me:

Acked-by: Tony Lindgren <tony@atomide.com>
