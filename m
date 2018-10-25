From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: twl-core: Fix section annotations on
 {,un}protect_pm_master
Date: Thu, 25 Oct 2018 09:02:56 +0100
Message-ID: <20181025080256.GH4939@dell>
References: <20181017171322.13572-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181017171322.13572-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 17 Oct 2018, Nathan Chancellor wrote:

> When building the kernel with Clang, the following section mismatch
> warning appears:
> 
> WARNING: vmlinux.o(.text+0x3d84a3b): Section mismatch in reference from
> the function twl_probe() to the function
> .init.text:unprotect_pm_master()
> The function twl_probe() references
> the function __init unprotect_pm_master().
> This is often because twl_probe lacks a __init
> annotation or the annotation of unprotect_pm_master is wrong.
> 
> Remove the __init annotation on the *protect_pm_master functions so
> there is no more mismatch.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> Alternatively, I suppose that twl_probe could be marked as __init but
> I'm not sure if deferral is possible or not (which I believe would cause
> issues but not sure). I went with this more conservative approache but
> I'm happy to respin if necessary.
> 
> Thanks!
> 
>  drivers/mfd/twl-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied for v4.21, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
