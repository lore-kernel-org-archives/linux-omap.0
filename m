From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 0/2] convert to use generic irq handler
Date: Fri, 25 Sep 2015 13:36:21 -0700
Message-ID: <5605B045.9080205@oracle.com>
References: <1443209283-20781-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443209283-20781-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, tony@atomide.com
Cc: linux-omap@vger.kernel.org, Austin Schuh <austin@peloton-tech.com>, philipp@peloton-tech.com, linux-rt-users@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 9/25/15 12:28 PM, Grygorii Strashko wrote:
> This patch series contains patches which fixes wrong APIs usage in atomic
> context on RT-kernel. The final goal is to make TI OMAP GPIO driver
> compatible with -RT kernel as much as possible.
>
> Patch 1: required to be compatible with -RT kernel, because PM runtime's
> irq_safe mode is incompatible with -RT.
> Patch 2: This patch converts TI OMAP GPIO driver to use generic irq
>   handler instead of chained IRQ handler. This way OMAP GPIO driver will be
>   compatible with RT-kernel where it will be forced thread IRQ handler
>   while in non-RT kernel it still will be executed in HW IRQ context.
>
> Boot, basic gpio functionality tested on:
>   dra7-evm, BeagleBone(white), am43xx-gpevm, am437x-sk
> Manually tested on dra7-evm including suspend/resume and wakeup.
>
> Links on RFC:
>   https://lkml.org/lkml/2015/8/18/161
>   https://lkml.org/lkml/2015/8/18/162
>
> Grygorii Strashko (2):
>    gpio: omap: move pm runtime in irq_chip.irq_bus_lock/sync_unlock
>    gpio: omap: convert to use generic irq handler
>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
