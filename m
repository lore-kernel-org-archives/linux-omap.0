From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Wed, 23 Dec 2015 16:54:32 +0200
Message-ID: <567AB5A8.4000505@gmail.com>
References: <20150713131902.GH26485@atomide.com>
 <20151129180939.GE30871@n2100.arm.linux.org.uk>
 <alpine.LFD.2.20.1511291902100.22569@knanqh.ubzr> <201511300115.12478@pali>
 <20151130152352.GY2517@atomide.com> <20151130153933.GD29576@pali>
 <alpine.LFD.2.20.1511301041090.22569@knanqh.ubzr>
 <20151215093325.GK13531@pali> <20151215122038.GI30871@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151215122038.GI30871@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Laura Abbott <lauraa@codeaurora.org>, Sebastian Reichel <sre@debian.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Rob Herring <robherring2@gmail.com>, Pavel Machek <pavel@ucw.cz>, Grant Likely <grant.likely@linaro.org>, linux-omap@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
List-Id: linux-omap@vger.kernel.org

Hi,

On 15.12.2015 14:20, Russell King - ARM Linux wrote:
>
> You could also just save_atags() in there, with a comment saying that
> this is a work-around for N900 which needs the ATAGs saved, and this
> is allowed in ->reserve as a special exception.
>

What about this (just to confirm I got the idea correctly, proper patch 
will follow if that's the case):

diff --git a/arch/arm/mach-omap2/board-generic.c 
b/arch/arm/mach-omap2/board-generic.c
index 34ff14b..8916856 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -83,8 +83,25 @@ static const char *const n900_boards_compat[] 
__initconst = {
         NULL,
  };

+#ifdef CONFIG_ATAGS_PROC
+extern void save_atags(const struct tag *tags);
+
+/* Legacy userspace on Nokia N900 needs ATAGS exported in /proc/atags,
+ * save them while the data is still not overwritten
+ */
+static void __init rx51_reserve(void)
+{
+       const phys_addr_t __atags_pointer = 0x100;
+
+       save_atags(phys_to_virt(__atags_pointer));
+       omap_reserve();
+}
+#else
+#define rx51_reserve omap_reserve
+#endif
+
  DT_MACHINE_START(OMAP3_N900_DT, "Nokia RX-51 board")
-       .reserve        = omap_reserve,
+       .reserve        = rx51_reserve,
         .map_io         = omap3_map_io,
         .init_early     = omap3430_init_early,
         .init_machine   = omap_generic_init,
