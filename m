From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2: remove incorrect __init annotation
Date: Thu, 14 Mar 2019 08:07:45 -0700
Message-ID: <20190314150745.GC19425@atomide.com>
References: <20190307103557.1688556-1-arnd@arndb.de>
 <20190307153620.GK20201@archlinux-ryzen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307153620.GK20201@archlinux-ryzen>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rajendra Nayak <rnayak@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, Nick Desaulniers <ndesaulniers@google.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Nathan Chancellor <natechancellor@gmail.com> [190307 15:36]:
> On Thu, Mar 07, 2019 at 11:35:50AM +0100, Arnd Bergmann wrote:
> > omap3xxx_prm_enable_io_wakeup() is marked __init, but its caller is not, so
> > we get a warning with clang-8:
> > 
> > WARNING: vmlinux.o(.text+0x343c8): Section mismatch in reference from the function omap3xxx_prm_late_init() to the function .init.text:omap3xxx_prm_enable_io_wakeup()
> > The function omap3xxx_prm_late_init() references
> > the function __init omap3xxx_prm_enable_io_wakeup().
> > This is often because omap3xxx_prm_late_init lacks a __init
> > annotation or the annotation of omap3xxx_prm_enable_io_wakeup is wrong.
> > 
> > When building with gcc, omap3xxx_prm_enable_io_wakeup() is always
> > inlined, so we never noticed in the past.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

Arnd please just apply this directly, this should not cause
merge conflicts:

Acked-by: Tony Lindgren <tony@atomide.com>
