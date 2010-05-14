From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 0/2] DSS2:Allow FB to build without VRFB
Date: Fri, 14 May 2010 07:17:57 -0500
Message-ID: <4BED3F75.2040306@ti.com>
References: <1273764028-25822-1-git-send-email-svadivu@ti.com> <1273821814.2814.63.camel@tubuntu.research.nokia.com> <FCCFB4CDC6E5564B9182F639FC35608703042887DB@dbde02.ent.ti.com> <AA4B1310-2BA5-411E-A7EA-AAE03F41CCF3@student.utwente.nl> <4BED2CD9.9000303@ti.com> <5FC7083E-FFD9-4297-AC5D-522FBCBF11F0@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46144 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753906Ab0ENMSE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 May 2010 08:18:04 -0400
In-Reply-To: <5FC7083E-FFD9-4297-AC5D-522FBCBF11F0@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

Koen Kooi had written, on 05/14/2010 06:18 AM, the following:
> Op 14 mei 2010, om 12:58 heeft Nishanth Menon het volgende geschreven:
> 
>> Koen Kooi had written, on 05/14/2010 05:39 AM, the following:
>>> Op 14 mei 2010, om 12:03 heeft Guruswamy, Senthilvadivu het volgende geschreven:
>>>>> -----Original Message-----
>>>>> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com] Sent: Friday, May 14, 2010 12:54 PM
>>>>> To: Guruswamy, Senthilvadivu
>>>>> Cc: linux-omap@vger.kernel.org; linux-fbdev@vger.kernel.org; tony@atomide.com; Hiremath, Vaibhav
>>>>> Subject: Re: [PATCH v2 0/2] DSS2:Allow FB to build without VRFB
>>>>>
>>>>> Hi,
>>>>>
>>>>> On Thu, 2010-05-13 at 17:20 +0200, ext Senthilvadivu Guruswamy wrote:
>>>>>> From: Senthilvadivu Guruswamy  <svadivu@ti.com>
>>>>>>
>>>>>> Hi all,
>>>>>>
>>>>>> This patch series replaces the patch "DSS2 Include VRFB into omap2-3build only"
>>>>>> Thanks for the review comments. 
>>>>>> The intent of this series is to split the patch into 2 logical
>>>>>> patches and also to incorporate the comments on multi-omap build.
>>>>>>
>>>>>> In this series, Kconfig is changed to have OMAP2_VRFB depend on ARCH_OMAP2 and ARCH_OMAP3.
>>>>>> This change takes care of the multi-omap builds. 
>>>>>> This patch would allow successful build of omap_4430sdp_defconfig when OMAP2_DSS and FB_OMAP2 is enabled from menuconfig.
>>>>>>
>>>>>> For verification: Generated the .config on omap3_defconfig with DSS
>>>>>> and FB enabled. Generated .config is same with and without 
>>>>> the patch.
>>>>>> List of Changed Files:
>>>>>> arch/arm/plat-omap/include/plat/vrfb.h
>>>>>> drivers/video/omap2/Kconfig
>>>>>> drivers/video/omap2/omapfb/Kconfig
>>>>> The patch set makes VRFB optional. What happens if VRFB is turned off,
>>>>> and the user uses VRFB for a framebuffer?
>>>> [Senthil] This patch keeps VRFB=y for ARCH_OMAP2 and ARCH_OMAP3.
>>>> User would have got an option to turn it OFF if it had appeared in the menuconfig selections.  I did not give that option in menuconfig explicitly. ie  config OMAP2_VRFB
>>>> 	bool <No name given here>
>>>>
>>>> Suppose on a build the user deliberately gives "CONFIG_OMAP2_VRFB not set",
>>>> then VRFB functions are made as empty functions by the compiler.
>>>>
>>>> This is fine as long as the user does not say omapfb.vrfb=1.
>>>>
>>>> But if the user sets omapfb.vrfb=1, then it is a wrong usage of the bootargs
>>>> as he has already deliberately changed the defconfig to say "VRFB not set".
>>>>
>>>> The result of his experiment: No bootup on the board as the vaddr of VRFB is populated nor of the normal RAM buffer.
>>> And that is unacceptable when working with customers (or users in the open 
>>> source world).  Instead of the kernel hacker spending an hour or 2 on a proper
>>> solution we now need to waste a whole lot more time supporting customers who
>>> pass vrfb in bootargs without knowing that it's turned off in the kernel.
> 
>> But why use bootargs?
> 
> Because (for some unknown reason) you can't toggle vrfb at runtime. If you realize
 > you need rotation you need to reboot. I guess it's because the memory 
layout for
 >vrfb is completely different, but again, I'm not a kernel hacker :)
Sorry, I am no DSS hacker myself, but looking at mainline 2.6.34-rc6 
kernel drivers/video/omap2/omapfb/omapfb-main.c, as part of late_init, 
omapfb_init gets called -> which causes probe to be called if there is a 
display around, which calls create_framebuffers and based on the 
rotation flag DMA or VRFB bootargs call to allocate goes to 
drivers/video/omap2/vrfb.c, i see request_mem_region and 
release_mem_region from a physical address mapped - so ok.. we loose 
some of our memory map..

Since this entire fuss is about being able to select the type of 
rotation... how about changing vrfb to rotation_type which defaults to 
best possible for the silicon as indicated by FEATURES as I have been 
mentioning so far..


just an idea about what I am talking about, here is an illustration patch:

diff --git a/Documentation/arm/OMAP/DSS b/Documentation/arm/OMAP/DSS
index 0af0e9e..b3df400 100644
--- a/Documentation/arm/OMAP/DSS
+++ b/Documentation/arm/OMAP/DSS
@@ -279,8 +279,11 @@ omapfb.test=<y|n>
  	- Draw test pattern to framebuffer whenever framebuffer settings change.
  	  You need to have OMAPFB debug support enabled in kernel config.

-omapfb.vrfb=<y|n>
-	- Use VRFB rotation for all framebuffers.
+omapfb.rotation_type= 0|1|2
+	 - Select rotation type on hardware
+	   0 - Default: Use Optimal rotation style for the silicon
+	   1 - Force use VRFB rotation for all framebuffers if available
+	   2 - Use DSS to rotate all framebuffers

  omapfb.rotate=<angle>
  	- Default rotation applied to all framebuffers.

diff --git a/arch/arm/plat-omap/include/plat/cpu.h 
b/arch/arm/plat-omap/include/plat/cpu.h
index 7514174..52aebae 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -444,6 +444,7 @@ extern u32 omap3_features;
  #define OMAP3_HAS_NEON			BIT(3)
  #define OMAP3_HAS_ISP			BIT(4)
  #define OMAP3_HAS_192MHZ_CLK		BIT(5)
+#define OMAP3_HAS_VRFB			BIT(6)

  #define OMAP3_HAS_FEATURE(feat,flag)			\
  static inline unsigned int omap3_has_ ##feat(void)	\
@@ -457,5 +458,6 @@ OMAP3_HAS_FEATURE(iva, IVA)
  OMAP3_HAS_FEATURE(neon, NEON)
  OMAP3_HAS_FEATURE(isp, ISP)
  OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
+OMAP3_HAS_FEATURE(vrfb, VRFB)

  #endif
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c 
b/drivers/video/omap2/omapfb/omapfb-main.c
index 4b4506d..b0cc251 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -33,6 +33,7 @@
  #include <plat/display.h>
  #include <plat/vram.h>
  #include <plat/vrfb.h>
+#include <plat/cpu.h>

  #include "omapfb.h"

@@ -43,7 +44,7 @@

  static char *def_mode;
  static char *def_vram;
-static int def_vrfb;
+static int def_rotate_type;
  static int def_rotate;
  static int def_mirror;

@@ -1872,8 +1873,14 @@ static int omapfb_create_framebuffers(struct 
omapfb2_device *fbdev)
  		ofbi->id = i;

  		/* assign these early, so that fb alloc can use them */
-		ofbi->rotation_type = def_vrfb ? OMAP_DSS_ROT_VRFB :
-			OMAP_DSS_ROT_DMA;
+
+		/* Unless forced to use otherwise, use vrfb */
+		if (omap3_has_vrfb())
+			ofbi->rotation_type = (def_rot_style == 2) ?
+				OMAP_DSS_ROT_DMA : OMAP_DSS_ROT_VRFB;
+		else
+			ofbi->rotation_type = OMAP_DSS_ROT_DMA;
+
  		ofbi->mirror = def_mirror;

  		fbdev->num_fbs++;
@@ -2272,7 +2279,7 @@ static void __exit omapfb_exit(void)
  module_param_named(mode, def_mode, charp, 0);
  module_param_named(vram, def_vram, charp, 0);
  module_param_named(rotate, def_rotate, int, 0);
-module_param_named(vrfb, def_vrfb, bool, 0);
+module_param_named(rotation_type, def_rot_style, int, 0);
  module_param_named(mirror, def_mirror, bool, 0);

  /* late_initcall to let panel/ctrl drivers loaded first.
-- 
Regards,
Nishanth Menon
