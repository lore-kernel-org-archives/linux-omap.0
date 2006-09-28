From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix OMAP2 build
Date: Thu, 28 Sep 2006 17:08:30 +0300
Message-ID: <20060928140829.GL29453@atomide.com>
References: <1159178597.7339.271740632@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1159178597.7339.271740632@webmail.messagingengine.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060925 13:09]:
> Doyu-San/Tony,
> 
> This patch fixes OMAP2 build, as Mailbox base is not defined.
> 
> Error message:
> arch/arm/mach-omap2/devices.c:75: error: `OMAP24XX_MAILBOX_BASE' undeclared here (not in a function)
> arch/arm/mach-omap2/devices.c:75: error: initializer element is not constant
> arch/arm/mach-omap2/devices.c:75: error: (near initialization for `mbox_resources[0].start')
> arch/arm/mach-omap2/devices.c:76: error: initializer element is not constant
> arch/arm/mach-omap2/devices.c:76: error: (near initialization for `mbox_resources[0].end')
> arch/arm/mach-omap2/devices.c:78: error: initializer element is not constant
> arch/arm/mach-omap2/devices.c:78: error: (near initialization for `mbox_resources[0]')
> arch/arm/mach-omap2/devices.c:82: error: initializer element is not constant
> arch/arm/mach-omap2/devices.c:82: error: (near initialization for `mbox_resources[1]')
> arch/arm/mach-omap2/devices.c:86: error: initializer element is not constant
> arch/arm/mach-omap2/devices.c:86: error: (near initialization for `mbox_resources[2]')
> make[1]: *** [arch/arm/mach-omap2/devices.o] Error 1
> 

This should be already fixed with 70eb98a161b49479e74fcb9042a82875b73ba68f.

Tony
