From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: prm44xx: Fix section annotation on
 omap44xx_prm_enable_io_wakeup
Date: Mon, 19 Nov 2018 10:00:50 -0800
Message-ID: <20181119180050.GS53235@atomide.com>
References: <20181018005400.7521-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181018005400.7521-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Nathan Chancellor <natechancellor@gmail.com> [181017 17:54]:
> When building the kernel with Clang, the following section mismatch
> warning appears:
> 
> WARNING: vmlinux.o(.text+0x38b3c): Section mismatch in reference from
> the function omap44xx_prm_late_init() to the function
> .init.text:omap44xx_prm_enable_io_wakeup()
> The function omap44xx_prm_late_init() references
> the function __init omap44xx_prm_enable_io_wakeup().
> This is often because omap44xx_prm_late_init lacks a __init
> annotation or the annotation of omap44xx_prm_enable_io_wakeup is wrong.
> 
> Remove the __init annotation from omap44xx_prm_enable_io_wakeup so there
> is no more mismatch.

Applying into omap-for-v4.21/soc thanks.

Tony
