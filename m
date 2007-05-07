From: Tim Bird <tim.bird@am.sony.com>
Subject: Kconfig undefined references (on other platforms)
Date: Mon, 07 May 2007 12:41:27 -0700
Message-ID: <463F80E7.9040201@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi all,

I'm using patch-2.6.20-omap1, with a kernel that I compile
for multiple boards. When I compile the kernel for a MIPS board,
I get some Kconfig warnings on OMAP symbols.

>From the compile:
scripts/kconfig/conf -s arch/mips/Kconfig
sound/arm/Kconfig:42:warning: 'select' used by config symbol 'SND_OMAP_AIC23' refer to undefined symbol 'OMAP_MCBSP'
sound/arm/Kconfig:57:warning: 'select' used by config symbol 'SND_OMAP_TSC2101' refer to undefined symbol 'OMAP_MCBSP'
sound/arm/Kconfig:70:warning: 'select' used by config symbol 'SND_SX1' refer to undefined symbol 'OMAP_MCBSP'

It looks like sound/arm/Kconfig is included (unconditionally) in
sound/Kconfig. OMAP_MCBSP is defined in arch/arm/plat-omap1/Kconfig,
which is not included during my build on MIPS.

Does anyone know what the proper technique is for making either the
selects or the includes conditional, or otherwise quieting these
types of reference warnings?

Thanks,
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
