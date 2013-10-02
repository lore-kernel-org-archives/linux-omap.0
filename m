From: Kim Phillips <kim.phillips@linaro.org>
Subject: Re: [LNG] [PATCH] mfd: twl6030: Fix endianness problem in IRQ
 handler
Date: Wed, 2 Oct 2013 11:43:59 -0500
Message-ID: <20131002114359.681cbdf92bd683373f07cca2@linaro.org>
References: <1380712124-20666-1-git-send-email-taras.kondratiuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380712124-20666-1-git-send-email-taras.kondratiuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: taras.kondratiuk@linaro.org
Cc: sameo@linux.intel.com, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-networking@linaro.org, d.xie@sta.samsung.com
List-Id: linux-omap@vger.kernel.org

On Wed,  2 Oct 2013 14:08:44 +0300
Taras Kondratiuk <taras.kondratiuk@linaro.org> wrote:

> From: Danke Xie <d.xie@sta.samsung.com>
> 
> The current TWL 6030 IRQ handler assumes little endianness.
> This change makes it endian-neutral.
> 
> Signed-off-by: Danke Xie <d.xie@sta.samsung.com>
> Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
> ---

this patch causes a new sparse warning:

make C=2 CF="-D__CHECK_ENDIAN__" drivers/mfd/twl6030-irq.o
...
  CHECK   drivers/mfd/twl6030-irq.c
drivers/mfd/twl6030-irq.c:200:19: warning: cast to restricted __le32

does int_sts in the sts union need to be defined as __le32?

Thanks,

Kim
