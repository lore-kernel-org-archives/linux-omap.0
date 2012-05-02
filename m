From: Tero Kristo <t-kristo@ti.com>
Subject: RE: OMAP3EVM not booting on l-o master
Date: Wed, 2 May 2012 11:39:17 +0300
Message-ID: <1335947957.2149.186.camel@sokoban>
References: <C8443D0743D26F4388EA172BF4E2A7A9317C3A03@DBDE01.ent.ti.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C3B18@DBDE01.ent.ti.com>
	 <alpine.DEB.2.00.1204050330380.10302@utopia.booyaka.com>
	 <alpine.DEB.2.00.1204050403460.10302@utopia.booyaka.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C4B44@DBDE01.ent.ti.com>
	 <alpine.DEB.2.00.1204051303000.10302@utopia.booyaka.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C5DB6@DBDE01.ent.ti.com>
	 <alpine.DEB.2.00.1204060111400.10302@utopia.booyaka.com>
	 <C8443D0743D26F4388EA172BF4E2A7A9317C5EEF@DBDE01.ent.ti.com>
	 <1335173044.2149.64.camel@sokoban> <87obqhawig.fsf@ti.com>
	 <1335532591.2149.163.camel@sokoban> <87fwbowyuu.fsf@ti.com>
	 <1335790016.2149.185.camel@sokoban> <87vckht0lf.fsf@ti.com>
	 <C8443D0743D26F4388EA172BF4E2A7A93E97C988@DBDE01.ent.ti.com>
	 <87y5pchu4f.fsf@ti.com>
	 <C8443D0743D26F4388EA172BF4E2A7A93E97EDE5@DBDE01.ent.ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46434 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752571Ab2EBIjV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 04:39:21 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E97EDE5@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2012-05-02 at 07:48 +0200, Mohammed, Afzal wrote:
> Hi Kevin,
> 
> On Tue, May 01, 2012 at 19:38:00, Hilman, Kevin wrote:
> > >> Afzal, care to give this one a test as well?  It should have the same
> > >> result but is a more targetted fix.  With and ack from Tero and a
> > >> Tested-by from you, I'll post this to the list and and queue it up for
> > >> v3.5.
> 
> With an additional diff [1], your patch makes omap3evm boot
> 
> Without [1], compiler error
> 
> Regards
> Afzal
> 
> [1]
> 
> diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
> index a8c6bd8..a0309de 100644
> --- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
> +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
> @@ -15,6 +15,7 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/irq.h>
> 
>  #include "common.h"
>  #include <plat/cpu.h>

With this addition Kevin's patch looks good to me, so acked.

-Tero

