From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: hwmod: fix section mismatch warnings
Date: Mon, 18 Sep 2017 09:52:04 -0700
Message-ID: <20170918165204.GX5024@atomide.com>
References: <20170915194527.1171677-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170915194527.1171677-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [170915 12:46]:
> Older compilers choose not to inline _setup_clkctrl_provider(),
> leading to a harmless warning:
> 
> WARNING: vmlinux.o(.text+0x27b34): Section mismatch in reference from the function _setup_clkctrl_provider() to the function .init.text:memblock_virt_alloc_try_nid()
> The function _setup_clkctrl_provider() references
> the function __init memblock_virt_alloc_try_nid().
> This is often because _setup_clkctrl_provider lacks a __init
> annotation or the annotation of memblock_virt_alloc_try_nid is wrong.
> 
> This annotates it as __init as well, which lets the linker
> see that it is actually correct.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Tony Lindgren <tony@atomide.com>
