From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH] ARM: omap: make am43xx build with SMP enabled
Date: Mon, 24 Jun 2013 07:25:50 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EB248E5@DBDE04.ent.ti.com>
References: <201306220122.47786.arnd@arndb.de>
 <20130624071742.GP5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51377 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab3FXH0Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jun 2013 03:26:24 -0400
In-Reply-To: <20130624071742.GP5523@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>
Cc: "Kishore, Ankur" <a-kishore@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

Hi,

On Mon, Jun 24, 2013 at 12:47:42, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [130621 16:28]:
> > With am43xx enabled, omap4 and omap5 disabled and SMP on, I get these
> > build errors:
> > 
> > arch/arm/mach-omap2/built-in.o: In function `scu_gp_set':
> > :(.text+0x7858): undefined reference to `omap4_get_scu_base'
> > arch/arm/mach-omap2/built-in.o: In function `scu_gp_clear':
> > :(.text+0x793c): undefined reference to `omap4_get_scu_base'
> > arch/arm/mach-omap2/built-in.o: In function `omap4_cpu_die':
> > :(.ref.text+0x44): undefined reference to `omap4_hotplug_cpu'
> > 
> > The easiest way to work around that is to turn on the missing
> > functions, even though we know they won't be used on am43xx,
> > which is single-CPU.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Ankur Kishore <a-kishore@ti.com>
> > Cc: Afzal Mohammed <afzal@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> 
> Looks OK to me:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Wait, seeing another build error after applying this patch,
I will respond back soon.

Regards
Afzal
