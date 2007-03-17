From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC, PATCH 1/7] ARM: build fixups for hrtimers
Date: Sun, 18 Mar 2007 00:51:34 +0100
Message-ID: <1174175495.13341.451.camel@localhost.localdomain>
References: <20070219214719.379287000@mvista.com>
	<20070219214739.523455000@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20070219214739.523455000@mvista.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On Mon, 2007-02-19 at 13:47 -0800, Kevin Hilman wrote:
> Signed-off-by: Kevin Hilman <khilman@mvista.com>
> 
> Index: linux-2.6/kernel/time/tick-sched.c
> ===================================================================
> --- linux-2.6.orig/kernel/time/tick-sched.c
> +++ linux-2.6/kernel/time/tick-sched.c
> @@ -21,6 +21,8 @@
>  #include <linux/sched.h>
>  #include <linux/tick.h>
>  
> +#include <asm/irq_regs.h>
> +
>  #include "tick-internal.h"

Went in already via 9e203bcc1051cac2a8b15c3ee9db4c0d05794abe

	tglx



-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
