From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/5] drivers: bus: omap_l3: Conversion to devm_*
Date: Tue, 7 May 2013 18:24:08 +0530
Message-ID: <5188F970.6010401@ti.com>
References: <1367496587-6210-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1367496587-6210-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday 02 May 2013 05:39 PM, Peter Ujfalusi wrote:
> Hi,
> 
> Cleanup of platform probe and remove (removing the remove function at the end)
> with converting the driver to use the devm_* versions kzalloc, ioremap and
> request_irq.
> 
Thanks Peter. All patches looks fine to my eyes. In the last patch wher
you are changing the error level is bit debatable but I agree with you.

So FWIW,
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>


> Peter Ujfalusi (5):
>   drivers: bus: omap_l3: Convert to use devm_kzalloc
>   drivers: bus: omap_l3: Convert to use devm_request_and_ioremap()
>   drivers: bus: omap_l3: Convert to use devm_request_irq()
>   drivers: bus: omap_l3: Remove the platform driver's remove function
>   drivers: bus: omap_l3: Change pr_crit() to dev_err() when IRQ request
>     fails
> 
>  drivers/bus/omap_l3_noc.c | 106 +++++++++++-----------------------------------
>  1 file changed, 24 insertions(+), 82 deletions(-)
> 
