From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ethernet: add export.h in davinci_cpdma.c
Date: Sun, 01 Jul 2012 18:33:33 -0700 (PDT)
Message-ID: <20120701.183333.353465166541062775.davem@davemloft.net>
References: <A874F61F95741C4A9BA573A70FE3998FCAAB@DQHE02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <A874F61F95741C4A9BA573A70FE3998FCAAB@DQHE02.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milo.Kim@ti.com
Cc: arnd@arndb.de, linux-omap@vger.kernel.org, tony@atomide.com, linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org
List-Id: linux-omap@vger.kernel.org

From: "Kim, Milo" <Milo.Kim@ti.com>
Date: Mon, 2 Jul 2012 01:17:03 +0000

> To remove warning messages about 'EXPORT_SYMBOL_GPL', include export header.
 ...
> @@ -19,6 +19,7 @@
>  #include <linux/err.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
> +#include <linux/export.h>

You aren't generating this patch against current sources, otherwise
you'd see that linux/module.h is included in this driver and therefore
the problem you ran into is not possible.
