From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/9] mfd: Drop unnecessary static
Date: Mon, 17 Jul 2017 12:01:09 +0100
Message-ID: <20170717110109.c53tmzvvcd64f7c4@dell>
References: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
 <1493928654-18768-6-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493928654-18768-6-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Tony Lindgren <tony@atomide.com>, keescook@chromium.org, kernel-janitors@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, 04 May 2017, Julia Lawall wrote:

> Drop static on a local variable, when the variable is initialized before
> any use, on every possible execution path through the function.
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @bad exists@
> position p;
> identifier x;
> type T;
> @@
> 
> static T x@p;
> ...
> x = <+...x...+>
> 
> @@
> identifier x;
> expression e;
> type T;
> position p != bad.p;
> @@
> 
> -static
>  T x@p;
>  ... when != x
>      when strict
> ?x = e;
> // </smpl>
> 
> The change increases the code size but decreases the size of the bss segment.
> 
> before:
>    text    data     bss     dec     hex filename
>    3369     272     300    3941     f65 drivers/mfd/twl4030-irq.o
> 
> after:
>    text    data     bss     dec     hex filename
>    3401     272      28    3701     e75 drivers/mfd/twl4030-irq.o
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/mfd/twl4030-irq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
