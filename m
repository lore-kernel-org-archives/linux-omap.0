From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Subject: Re: [PATCH 2/3] EDAC: ti: add support for TI keystone and DRA7xx EDAC
Date: Thu, 09 Nov 2017 12:50:04 +0100
Message-ID: <1510228204.3471.44.camel@pengutronix.de>
References: <1510087139-21885-1-git-send-email-t-kristo@ti.com>
 <1510087139-21885-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1510087139-21885-3-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-edac@vger.kernel.org, bp@alien8.de, mchehab@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 2017-11-07 at 22:38 +0200, Tero Kristo wrote:
> +       if (edac_mc_add_mc(mci)) {
> +               pr_err("%s: Failed to register mci.\n", __func__);
> +               return -ENOMEM;
This leaks the allocated mci structure in the error case.

> +       }
> +
> +       /* add EMIF ECC error handler */
> +       error_irq = platform_get_irq(pdev, 0);
> +       if (!error_irq) {
> +               dev_err(dev, "DDR3 EDAC irq number not defined\n");
> +               return ret;
This leaves the mc registered in the error case.

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
