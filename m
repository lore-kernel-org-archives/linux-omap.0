From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mfd: twl4030-audio: fix sibling-node lookup
Date: Wed, 29 Nov 2017 11:24:55 +0000
Message-ID: <20171129112455.lqxuubv6dtzl5tf5@dell>
References: <20171111153844.16741-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171111153844.16741-1-johan@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sat, 11 Nov 2017, Johan Hovold wrote:

> A helper purported to look up a child node based on its name was using
> the wrong of-helper and ended up prematurely freeing the parent of-node
> while leaking any matching node.
> 
> To make things worse, any matching node would not even necessarily be a
> child node as the whole device tree was searched depth-first starting at
> the parent.
> 
> Fixes: 019a7e6b7b31 ("mfd: twl4030-audio: Add DT support")
> Cc: stable <stable@vger.kernel.org>     # 3.7
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/mfd/twl4030-audio.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
