From: "Kim, Milo" <Milo.Kim@ti.com>
Subject: RE: [PATCH] ethernet: add export.h in davinci_cpdma.c
Date: Mon, 2 Jul 2012 02:07:04 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998FCAEF@DQHE02.ent.ti.com>
References: <A874F61F95741C4A9BA573A70FE3998FCAAB@DQHE02.ent.ti.com>
 <20120701.183333.353465166541062775.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120701.183333.353465166541062775.davem@davemloft.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>
List-Id: linux-omap@vger.kernel.org

> > @@ -19,6 +19,7 @@
> >  #include <linux/err.h>
> >  #include <linux/dma-mapping.h>
> >  #include <linux/io.h>
> > +#include <linux/export.h>
> 
> You aren't generating this patch against current sources, otherwise
> you'd see that linux/module.h is included in this driver and therefore
> the problem you ran into is not possible.

Oops ! This patch was generated based on the latest linux-omap tree, but similar code was already patched in linux-next tree.
Thanks for the notice.

Best Regards,
Milo -
