From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] arm: omap2: remove redundant multiplatform checks
Date: Wed, 6 Apr 2016 05:49:15 +0800
Message-ID: <201604060526.ouhQYqrT%fengguang.wu@intel.com>
References: <1459886971-32723-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459886971-32723-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, linux@arm.linux.org.uk, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
List-Id: linux-omap@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jonas,

[auto build test ERROR on arm-soc/for-next]
[also build test ERROR on v4.6-rc2 next-20160405]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jonas-Rabenstein/arm-omap2-remove-redundant-multiplatform-checks/20160406-041516
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
config: arm-multi_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from arch/arm/mach-omap2/usb-host.c:33:0:
>> arch/arm/mach-omap2/soc.h:194:0: error: unterminated #if
    #if defined(CONFIG_SOC_OMAP2420)
    ^
>> arch/arm/mach-omap2/soc.h:36:0: error: unterminated #ifndef
    #ifndef __ASSEMBLY__
    ^
   arch/arm/mach-omap2/usb-host.c: In function 'usbhs_init':
>> arch/arm/mach-omap2/usb-host.c:295:2: error: implicit declaration of function 'cpu_is_omap34xx' [-Werror=implicit-function-declaration]
     if (cpu_is_omap34xx()) {
     ^
>> arch/arm/mach-omap2/usb-host.c:299:21: error: 'OMAP3430_REV_ES2_1' undeclared (first use in this function)
      if (omap_rev() <= OMAP3430_REV_ES2_1)
                        ^
   arch/arm/mach-omap2/usb-host.c:299:21: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors
--
   In file included from arch/arm/mach-omap2/twl-common.c:31:0:
>> arch/arm/mach-omap2/soc.h:194:0: error: unterminated #if
    #if defined(CONFIG_SOC_OMAP2420)
    ^
>> arch/arm/mach-omap2/soc.h:36:0: error: unterminated #ifndef
    #ifndef __ASSEMBLY__
    ^
--
   In file included from arch/arm/mach-omap2/id.c:34:0:
>> arch/arm/mach-omap2/soc.h:194:0: error: unterminated #if
    #if defined(CONFIG_SOC_OMAP2420)
    ^
>> arch/arm/mach-omap2/soc.h:36:0: error: unterminated #ifndef
    #ifndef __ASSEMBLY__
    ^
   arch/arm/mach-omap2/id.c: In function 'omap_type':
>> arch/arm/mach-omap2/id.c:60:2: error: implicit declaration of function 'soc_is_omap24xx' [-Werror=implicit-function-declaration]
     if (soc_is_omap24xx()) {
     ^
>> arch/arm/mach-omap2/id.c:66:2: error: implicit declaration of function 'soc_is_omap34xx' [-Werror=implicit-function-declaration]
     } else if (soc_is_omap34xx()) {
     ^
   arch/arm/mach-omap2/id.c: At top level:
>> arch/arm/mach-omap2/id.c:148:1: warning: data definition has no type or storage class
    omap_device_initcall(omap_feed_randpool);
    ^
>> arch/arm/mach-omap2/id.c:148:1: error: type defaults to 'int' in declaration of 'omap_device_initcall' [-Werror=implicit-int]
>> arch/arm/mach-omap2/id.c:148:1: warning: parameter names (without types) in function declaration
   arch/arm/mach-omap2/id.c: In function 'omap3_cpuinfo':
>> arch/arm/mach-omap2/id.c:221:2: error: implicit declaration of function 'soc_is_omap3630' [-Werror=implicit-function-declaration]
     if (soc_is_omap3630()) {
     ^
>> arch/arm/mach-omap2/id.c:224:3: error: implicit declaration of function 'omap3_has_sgx' [-Werror=implicit-function-declaration]
      cpu_name = (omap3_has_sgx()) ? "AM3517" : "AM3505";
      ^
>> arch/arm/mach-omap2/id.c:233:2: error: implicit declaration of function 'omap3_has_iva' [-Werror=implicit-function-declaration]
     } else if (omap3_has_iva() && omap3_has_sgx()) {
     ^
>> arch/arm/mach-omap2/id.c:249:2: error: implicit declaration of function 'omap3_has_l2cache' [-Werror=implicit-function-declaration]
     OMAP3_SHOW_FEATURE(l2cache);
     ^
>> arch/arm/mach-omap2/id.c:252:2: error: implicit declaration of function 'omap3_has_neon' [-Werror=implicit-function-declaration]
     OMAP3_SHOW_FEATURE(neon);
     ^
>> arch/arm/mach-omap2/id.c:253:2: error: implicit declaration of function 'omap3_has_isp' [-Werror=implicit-function-declaration]
     OMAP3_SHOW_FEATURE(isp);
     ^
>> arch/arm/mach-omap2/id.c:254:2: error: implicit declaration of function 'omap3_has_192mhz_clk' [-Werror=implicit-function-declaration]
     OMAP3_SHOW_FEATURE(192mhz_clk);
     ^
   arch/arm/mach-omap2/id.c: In function 'omap3xxx_check_features':
>> arch/arm/mach-omap2/id.c:262:20: error: 'OMAP3_HAS_L2CACHE' undeclared (first use in this function)
      omap_features |= OMAP3_HAS_ ##feat;   \
                       ^
>> arch/arm/mach-omap2/id.c:273:2: note: in expansion of macro 'OMAP3_CHECK_FEATURE'
     OMAP3_CHECK_FEATURE(status, L2CACHE);
     ^
   arch/arm/mach-omap2/id.c:262:20: note: each undeclared identifier is reported only once for each function it appears in
      omap_features |= OMAP3_HAS_ ##feat;   \
                       ^
>> arch/arm/mach-omap2/id.c:273:2: note: in expansion of macro 'OMAP3_CHECK_FEATURE'
     OMAP3_CHECK_FEATURE(status, L2CACHE);
     ^
>> arch/arm/mach-omap2/id.c:262:20: error: 'OMAP3_HAS_IVA' undeclared (first use in this function)
      omap_features |= OMAP3_HAS_ ##feat;   \
                       ^
   arch/arm/mach-omap2/id.c:274:2: note: in expansion of macro 'OMAP3_CHECK_FEATURE'
     OMAP3_CHECK_FEATURE(status, IVA);
     ^
>> arch/arm/mach-omap2/id.c:262:20: error: 'OMAP3_HAS_SGX' undeclared (first use in this function)
      omap_features |= OMAP3_HAS_ ##feat;   \
                       ^
   arch/arm/mach-omap2/id.c:275:2: note: in expansion of macro 'OMAP3_CHECK_FEATURE'
     OMAP3_CHECK_FEATURE(status, SGX);
     ^
>> arch/arm/mach-omap2/id.c:262:20: error: 'OMAP3_HAS_NEON' undeclared (first use in this function)
      omap_features |= OMAP3_HAS_ ##feat;   \
                       ^
   arch/arm/mach-omap2/id.c:276:2: note: in expansion of macro 'OMAP3_CHECK_FEATURE'
     OMAP3_CHECK_FEATURE(status, NEON);
     ^
--
   In file included from arch/arm/mach-omap2/io.c:31:0:
>> arch/arm/mach-omap2/soc.h:194:0: error: unterminated #if
    #if defined(CONFIG_SOC_OMAP2420)
    ^
   In file included from arch/arm/mach-omap2/io.c:31:0:
>> arch/arm/mach-omap2/soc.h:36:0: error: unterminated #ifndef
    #ifndef __ASSEMBLY__
    ^
   arch/arm/mach-omap2/io.c: In function '_omap2_init_reprogram_sdrc':
>> arch/arm/mach-omap2/io.c:389:2: error: implicit declaration of function 'cpu_is_omap34xx' [-Werror=implicit-function-declaration]
     if (!cpu_is_omap34xx())
     ^
   arch/arm/mach-omap2/io.c: In function 'omap3_init_early':
>> arch/arm/mach-omap2/io.c:493:24: error: 'OMAP343X_CLASS' undeclared (first use in this function)
     omap2_set_globals_tap(OMAP343X_CLASS, OMAP2_L4_IO_ADDRESS(0x4830A000));
                           ^
   arch/arm/mach-omap2/io.c:493:24: note: each undeclared identifier is reported only once for each function it appears in
>> arch/arm/mach-omap2/io.c:505:2: error: implicit declaration of function 'omap3xxx_check_revision' [-Werror=implicit-function-declaration]
     omap3xxx_check_revision();
     ^
>> arch/arm/mach-omap2/io.c:506:2: error: implicit declaration of function 'omap3xxx_check_features' [-Werror=implicit-function-declaration]
     omap3xxx_check_features();
     ^
>> arch/arm/mach-omap2/io.c:522:3: error: implicit declaration of function 'cpu_is_omap3630' [-Werror=implicit-function-declaration]
      else if (cpu_is_omap3630())
      ^
>> arch/arm/mach-omap2/io.c:524:26: error: 'OMAP3430_REV_ES1_0' undeclared (first use in this function)
      else if (omap_rev() == OMAP3430_REV_ES1_0)
                             ^
   arch/arm/mach-omap2/io.c: In function 'ti814x_init_early':
>> arch/arm/mach-omap2/io.c:604:24: error: 'TI814X_CLASS' undeclared (first use in this function)
     omap2_set_globals_tap(TI814X_CLASS,
                           ^
>> arch/arm/mach-omap2/io.c:608:2: error: implicit declaration of function 'ti81xx_check_features' [-Werror=implicit-function-declaration]
     ti81xx_check_features();
     ^
   arch/arm/mach-omap2/io.c: In function 'ti816x_init_early':
>> arch/arm/mach-omap2/io.c:620:24: error: 'TI816X_CLASS' undeclared (first use in this function)
     omap2_set_globals_tap(TI816X_CLASS,
                           ^
   arch/arm/mach-omap2/io.c: In function 'am33xx_init_early':
>> arch/arm/mach-omap2/io.c:639:24: error: 'AM335X_CLASS' undeclared (first use in this function)
     omap2_set_globals_tap(AM335X_CLASS,
                           ^
>> arch/arm/mach-omap2/io.c:643:2: error: implicit declaration of function 'am33xx_check_features' [-Werror=implicit-function-declaration]
     am33xx_check_features();
     ^
   arch/arm/mach-omap2/io.c: In function 'am43xx_init_early':
   arch/arm/mach-omap2/io.c:661:24: error: 'AM335X_CLASS' undeclared (first use in this function)
     omap2_set_globals_tap(AM335X_CLASS,
                           ^
   arch/arm/mach-omap2/io.c: In function 'omap4430_init_early':
>> arch/arm/mach-omap2/io.c:685:24: error: 'OMAP443X_CLASS' undeclared (first use in this function)
     omap2_set_globals_tap(OMAP443X_CLASS,
                           ^
>> arch/arm/mach-omap2/io.c:689:2: error: implicit declaration of function 'omap4xxx_check_revision' [-Werror=implicit-function-declaration]
     omap4xxx_check_revision();
     ^
>> arch/arm/mach-omap2/io.c:690:2: error: implicit declaration of function 'omap4xxx_check_features' [-Werror=implicit-function-declaration]
     omap4xxx_check_features();
     ^
   arch/arm/mach-omap2/io.c: In function 'omap5_init_early':
>> arch/arm/mach-omap2/io.c:713:24: error: 'OMAP54XX_CLASS' undeclared (first use in this function)
     omap2_set_globals_tap(OMAP54XX_CLASS,
                           ^
>> arch/arm/mach-omap2/io.c:719:2: error: implicit declaration of function 'omap5xxx_check_revision' [-Werror=implicit-function-declaration]
     omap5xxx_check_revision();
     ^
   arch/arm/mach-omap2/io.c: In function 'dra7xx_init_early':
>> arch/arm/mach-omap2/io.c:744:2: error: implicit declaration of function 'dra7xxx_check_revision' [-Werror=implicit-function-declaration]
     dra7xxx_check_revision();
     ^
   arch/arm/mach-omap2/io.c: In function 'omap_sdrc_init':
>> arch/arm/mach-omap2/io.c:766:2: error: implicit declaration of function 'cpu_is_omap24xx' [-Werror=implicit-function-declaration]
     if (cpu_is_omap24xx() || omap3_has_sdrc()) {
     ^
--
   In file included from arch/arm/mach-omap2/control.c:21:0:
>> arch/arm/mach-omap2/soc.h:194:0: error: unterminated #if
    #if defined(CONFIG_SOC_OMAP2420)
    ^
>> arch/arm/mach-omap2/soc.h:36:0: error: unterminated #ifndef
    #ifndef __ASSEMBLY__
    ^
   arch/arm/mach-omap2/control.c: In function 'omap_ctrl_write_dsp_boot_addr':
>> arch/arm/mach-omap2/control.c:245:2: error: implicit declaration of function 'cpu_is_omap243x' [-Werror=implicit-function-declaration]
     u32 offset = cpu_is_omap243x() ? OMAP243X_CONTROL_IVA2_BOOTADDR :
     ^
>> arch/arm/mach-omap2/control.c:246:8: error: implicit declaration of function 'cpu_is_omap34xx' [-Werror=implicit-function-declaration]
           cpu_is_omap34xx() ? OMAP343X_CONTROL_IVA2_BOOTADDR :
           ^
>> arch/arm/mach-omap2/control.c:247:8: error: implicit declaration of function 'cpu_is_omap44xx' [-Werror=implicit-function-declaration]
           cpu_is_omap44xx() ? OMAP4_CTRL_MODULE_CORE_DSP_BOOTADDR :
           ^
   arch/arm/mach-omap2/control.c: In function 'omap3_save_scratchpad_contents':
>> arch/arm/mach-omap2/control.c:316:2: error: implicit declaration of function 'cpu_is_omap3630' [-Werror=implicit-function-declaration]
     if (cpu_is_omap3630())
     ^
>> arch/arm/mach-omap2/control.c:319:25: error: 'OMAP3430_REV_ES3_0' undeclared (first use in this function)
     else if (omap_rev() != OMAP3430_REV_ES3_0 &&
                            ^
   arch/arm/mach-omap2/control.c:319:25: note: each undeclared identifier is reported only once for each function it appears in
>> arch/arm/mach-omap2/control.c:320:20: error: 'OMAP3430_REV_ES3_1' undeclared (first use in this function)
         omap_rev() != OMAP3430_REV_ES3_1 &&
                       ^
>> arch/arm/mach-omap2/control.c:321:20: error: 'OMAP3430_REV_ES3_1_2' undeclared (first use in this function)
         omap_rev() != OMAP3430_REV_ES3_1_2)
                       ^
   cc1: some warnings being treated as errors
--
   In file included from arch/arm/mach-omap2/devices.c:31:0:
>> arch/arm/mach-omap2/soc.h:194:0: error: unterminated #if
    #if defined(CONFIG_SOC_OMAP2420)
    ^
>> arch/arm/mach-omap2/soc.h:36:0: error: unterminated #ifndef
    #ifndef __ASSEMBLY__
    ^
   arch/arm/mach-omap2/devices.c: In function 'omap3_l3_init':
>> arch/arm/mach-omap2/devices.c:50:2: error: implicit declaration of function 'cpu_is_omap34xx' [-Werror=implicit-function-declaration]
     if (!(cpu_is_omap34xx()) || of_have_populated_dt())
     ^
   arch/arm/mach-omap2/devices.c: At top level:
>> arch/arm/mach-omap2/devices.c:66:1: warning: data definition has no type or storage class
    omap_postcore_initcall(omap3_l3_init);
    ^
>> arch/arm/mach-omap2/devices.c:66:1: error: type defaults to 'int' in declaration of 'omap_postcore_initcall' [-Werror=implicit-int]
>> arch/arm/mach-omap2/devices.c:66:1: warning: parameter names (without types) in function declaration
   arch/arm/mach-omap2/devices.c:214:1: warning: data definition has no type or storage class
    omap_arch_initcall(omap2_init_devices);
    ^
>> arch/arm/mach-omap2/devices.c:214:1: error: type defaults to 'int' in declaration of 'omap_arch_initcall' [-Werror=implicit-int]
   arch/arm/mach-omap2/devices.c:214:1: warning: parameter names (without types) in function declaration
   arch/arm/mach-omap2/devices.c:240:1: warning: data definition has no type or storage class
    omap_postcore_initcall(omap_gpmc_init);
    ^
   arch/arm/mach-omap2/devices.c:240:1: error: type defaults to 'int' in declaration of 'omap_postcore_initcall' [-Werror=implicit-int]
   arch/arm/mach-omap2/devices.c:240:1: warning: parameter names (without types) in function declaration
   arch/arm/mach-omap2/devices.c:40:19: warning: 'omap3_l3_init' defined but not used [-Wunused-function]
    static int __init omap3_l3_init(void)
                      ^
   arch/arm/mach-omap2/devices.c:193:19: warning: 'omap2_init_devices' defined but not used [-Wunused-function]
    static int __init omap2_init_devices(void)
                      ^
   arch/arm/mach-omap2/devices.c:216:19: warning: 'omap_gpmc_init' defined but not used [-Wunused-function]
    static int __init omap_gpmc_init(void)
                      ^
   cc1: some warnings being treated as errors
--
   In file included from arch/arm/mach-omap2/serial.c:36:0:
>> arch/arm/mach-omap2/soc.h:194:0: error: unterminated #if
    #if defined(CONFIG_SOC_OMAP2420)
    ^
>> arch/arm/mach-omap2/soc.h:36:0: error: unterminated #ifndef
    #ifndef __ASSEMBLY__
    ^
>> arch/arm/mach-omap2/serial.c:216:1: warning: data definition has no type or storage class
    omap_postcore_initcall(omap_serial_early_init);
    ^
>> arch/arm/mach-omap2/serial.c:216:1: error: type defaults to 'int' in declaration of 'omap_postcore_initcall' [-Werror=implicit-int]
>> arch/arm/mach-omap2/serial.c:216:1: warning: parameter names (without types) in function declaration
   arch/arm/mach-omap2/serial.c: In function 'omap_serial_init_port':
>> arch/arm/mach-omap2/serial.c:289:2: error: implicit declaration of function 'cpu_is_omap34xx' [-Werror=implicit-function-declaration]
     if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
     ^
>> arch/arm/mach-omap2/serial.c:289:2: error: implicit declaration of function 'cpu_is_omap44xx' [-Werror=implicit-function-declaration]
   arch/arm/mach-omap2/serial.c: At top level:
   arch/arm/mach-omap2/serial.c:176:19: warning: 'omap_serial_early_init' defined but not used [-Wunused-function]
    static int __init omap_serial_early_init(void)
                      ^
   cc1: some warnings being treated as errors
--
   In file included from arch/arm/mach-omap2/timer.c:55:0:
>> arch/arm/mach-omap2/soc.h:194:0: error: unterminated #if
    #if defined(CONFIG_SOC_OMAP2420)
    ^
>> arch/arm/mach-omap2/soc.h:36:0: error: unterminated #ifndef
    #ifndef __ASSEMBLY__
    ^
   arch/arm/mach-omap2/timer.c: In function 'omap_dmtimer_init':
>> arch/arm/mach-omap2/timer.c:206:2: error: implicit declaration of function 'cpu_is_omap34xx' [-Werror=implicit-function-declaration]
     if (!cpu_is_omap34xx() && !soc_is_dra7xx())
     ^
   arch/arm/mach-omap2/timer.c: In function 'omap_dm_timer_get_errata':
>> arch/arm/mach-omap2/timer.c:223:2: error: implicit declaration of function 'cpu_is_omap24xx' [-Werror=implicit-function-declaration]
     if (cpu_is_omap24xx())
     ^
   arch/arm/mach-omap2/timer.c: At top level:
>> arch/arm/mach-omap2/timer.c:746:1: warning: data definition has no type or storage class
    omap_arch_initcall(omap2_dm_timer_init);
    ^
>> arch/arm/mach-omap2/timer.c:746:1: error: type defaults to 'int' in declaration of 'omap_arch_initcall' [-Werror=implicit-int]
>> arch/arm/mach-omap2/timer.c:746:1: warning: parameter names (without types) in function declaration
   arch/arm/mach-omap2/timer.c:730:19: warning: 'omap2_dm_timer_init' defined but not used [-Wunused-function]
    static int __init omap2_dm_timer_init(void)
                      ^
   cc1: some warnings being treated as errors
--
   In file included from arch/arm/mach-omap2/pm.c:27:0:
>> arch/arm/mach-omap2/soc.h:194:0: error: unterminated #if
    #if defined(CONFIG_SOC_OMAP2420)
    ^
>> arch/arm/mach-omap2/soc.h:36:0: error: unterminated #ifndef
    #ifndef __ASSEMBLY__
    ^
   arch/arm/mach-omap2/pm.c: In function 'omap2_init_processor_devices':
>> arch/arm/mach-omap2/pm.c:99:2: error: implicit declaration of function 'omap3_has_iva' [-Werror=implicit-function-declaration]
     if (omap3_has_iva())
     ^
>> arch/arm/mach-omap2/pm.c:102:2: error: implicit declaration of function 'cpu_is_omap44xx' [-Werror=implicit-function-declaration]
     if (cpu_is_omap44xx()) {
     ^
   arch/arm/mach-omap2/pm.c: In function 'omap_pm_begin':
>> arch/arm/mach-omap2/pm.c:224:2: error: implicit declaration of function 'cpu_is_omap34xx' [-Werror=implicit-function-declaration]
     if (cpu_is_omap34xx())
     ^
   arch/arm/mach-omap2/pm.c: At top level:
>> arch/arm/mach-omap2/pm.c:297:1: warning: data definition has no type or storage class
    omap_postcore_initcall(omap2_common_pm_init);
    ^
>> arch/arm/mach-omap2/pm.c:297:1: error: type defaults to 'int' in declaration of 'omap_postcore_initcall' [-Werror=implicit-int]
>> arch/arm/mach-omap2/pm.c:297:1: warning: parameter names (without types) in function declaration
   arch/arm/mach-omap2/pm.c:289:19: warning: 'omap2_common_pm_init' defined but not used [-Wunused-function]
    static int __init omap2_common_pm_init(void)
                      ^
   cc1: some warnings being treated as errors
..

vim +194 arch/arm/mach-omap2/soc.h

c49f34bc Tony Lindgren  2012-08-31   30  #include "omap34xx.h"
c49f34bc Tony Lindgren  2012-08-31   31  #include "omap44xx.h"
c49f34bc Tony Lindgren  2012-08-31   32  #include "ti81xx.h"
c49f34bc Tony Lindgren  2012-08-31   33  #include "am33xx.h"
c49f34bc Tony Lindgren  2012-08-31   34  #include "omap54xx.h"
e4c060db Tony Lindgren  2012-10-05   35  
e4c060db Tony Lindgren  2012-10-05  @36  #ifndef __ASSEMBLY__
e4c060db Tony Lindgren  2012-10-05   37  
e4c060db Tony Lindgren  2012-10-05   38  #include <linux/bitops.h>
6852215a R Sricharan    2013-02-06   39  #include <linux/of.h>
e4c060db Tony Lindgren  2012-10-05   40  
e4c060db Tony Lindgren  2012-10-05   41  /*
e4c060db Tony Lindgren  2012-10-05   42   * Test if multicore OMAP support is needed
e4c060db Tony Lindgren  2012-10-05   43   */
e4c060db Tony Lindgren  2012-10-05   44  #undef MULTI_OMAP2
e4c060db Tony Lindgren  2012-10-05   45  #define MULTI_OMAP2
6852215a R Sricharan    2013-02-06   46  
e4c060db Tony Lindgren  2012-10-05   47  /*
e4c060db Tony Lindgren  2012-10-05   48   * Omap device type i.e. EMU/HS/TST/GP/BAD
e4c060db Tony Lindgren  2012-10-05   49   */
e4c060db Tony Lindgren  2012-10-05   50  #define OMAP2_DEVICE_TYPE_TEST		0
e4c060db Tony Lindgren  2012-10-05   51  #define OMAP2_DEVICE_TYPE_EMU		1
e4c060db Tony Lindgren  2012-10-05   52  #define OMAP2_DEVICE_TYPE_SEC		2
e4c060db Tony Lindgren  2012-10-05   53  #define OMAP2_DEVICE_TYPE_GP		3
e4c060db Tony Lindgren  2012-10-05   54  #define OMAP2_DEVICE_TYPE_BAD		4
e4c060db Tony Lindgren  2012-10-05   55  
e4c060db Tony Lindgren  2012-10-05   56  int omap_type(void);
e4c060db Tony Lindgren  2012-10-05   57  
e4c060db Tony Lindgren  2012-10-05   58  /*
e4c060db Tony Lindgren  2012-10-05   59   * omap_rev bits:
d0b50905 Tony Lindgren  2015-10-16   60   * SoC id bits	(0730, 1510, 1710, 2422...)	[31:16]
d0b50905 Tony Lindgren  2015-10-16   61   * SoC revision	(See _REV_ defined in cpu.h)	[15:08]
d0b50905 Tony Lindgren  2015-10-16   62   * SoC class bits (15xx, 16xx, 24xx, 34xx...)	[07:00]
e4c060db Tony Lindgren  2012-10-05   63   */
e4c060db Tony Lindgren  2012-10-05   64  unsigned int omap_rev(void);
e4c060db Tony Lindgren  2012-10-05   65  
816a65ef Tony Lindgren  2013-01-11   66  static inline int soc_is_omap(void)
816a65ef Tony Lindgren  2013-01-11   67  {
816a65ef Tony Lindgren  2013-01-11   68  	return omap_rev() != 0;
816a65ef Tony Lindgren  2013-01-11   69  }
816a65ef Tony Lindgren  2013-01-11   70  
e4c060db Tony Lindgren  2012-10-05   71  /*
d0b50905 Tony Lindgren  2015-10-16   72   * Get the SoC revision for OMAP devices
e4c060db Tony Lindgren  2012-10-05   73   */
e4c060db Tony Lindgren  2012-10-05   74  #define GET_OMAP_REVISION()	((omap_rev() >> 8) & 0xff)
e4c060db Tony Lindgren  2012-10-05   75  
e4c060db Tony Lindgren  2012-10-05   76  /*
e4c060db Tony Lindgren  2012-10-05   77   * Macros to group OMAP into cpu classes.
e4c060db Tony Lindgren  2012-10-05   78   * These can be used in most places.
d0b50905 Tony Lindgren  2015-10-16   79   * soc_is_omap24xx():	True for OMAP2420, OMAP2422, OMAP2423, OMAP2430
d0b50905 Tony Lindgren  2015-10-16   80   * soc_is_omap242x():	True for OMAP2420, OMAP2422, OMAP2423
d0b50905 Tony Lindgren  2015-10-16   81   * soc_is_omap243x():	True for OMAP2430
d0b50905 Tony Lindgren  2015-10-16   82   * soc_is_omap343x():	True for OMAP3430
d0b50905 Tony Lindgren  2015-10-16   83   * soc_is_omap443x():	True for OMAP4430
d0b50905 Tony Lindgren  2015-10-16   84   * soc_is_omap446x():	True for OMAP4460
d0b50905 Tony Lindgren  2015-10-16   85   * soc_is_omap447x():	True for OMAP4470
e4c060db Tony Lindgren  2012-10-05   86   * soc_is_omap543x():	True for OMAP5430, OMAP5432
e4c060db Tony Lindgren  2012-10-05   87   */
e4c060db Tony Lindgren  2012-10-05   88  #define GET_OMAP_CLASS	(omap_rev() & 0xff)
e4c060db Tony Lindgren  2012-10-05   89  
e4c060db Tony Lindgren  2012-10-05   90  #define IS_OMAP_CLASS(class, id)			\
e4c060db Tony Lindgren  2012-10-05   91  static inline int is_omap ##class (void)		\
e4c060db Tony Lindgren  2012-10-05   92  {							\
e4c060db Tony Lindgren  2012-10-05   93  	return (GET_OMAP_CLASS == (id)) ? 1 : 0;	\
e4c060db Tony Lindgren  2012-10-05   94  }
e4c060db Tony Lindgren  2012-10-05   95  
e4c060db Tony Lindgren  2012-10-05   96  #define GET_AM_CLASS	((omap_rev() >> 24) & 0xff)
e4c060db Tony Lindgren  2012-10-05   97  
e4c060db Tony Lindgren  2012-10-05   98  #define IS_AM_CLASS(class, id)				\
e4c060db Tony Lindgren  2012-10-05   99  static inline int is_am ##class (void)			\
e4c060db Tony Lindgren  2012-10-05  100  {							\
e4c060db Tony Lindgren  2012-10-05  101  	return (GET_AM_CLASS == (id)) ? 1 : 0;		\
e4c060db Tony Lindgren  2012-10-05  102  }
e4c060db Tony Lindgren  2012-10-05  103  
e4c060db Tony Lindgren  2012-10-05  104  #define GET_TI_CLASS	((omap_rev() >> 24) & 0xff)
e4c060db Tony Lindgren  2012-10-05  105  
e4c060db Tony Lindgren  2012-10-05  106  #define IS_TI_CLASS(class, id)			\
e4c060db Tony Lindgren  2012-10-05  107  static inline int is_ti ##class (void)		\
e4c060db Tony Lindgren  2012-10-05  108  {							\
e4c060db Tony Lindgren  2012-10-05  109  	return (GET_TI_CLASS == (id)) ? 1 : 0;	\
e4c060db Tony Lindgren  2012-10-05  110  }
e4c060db Tony Lindgren  2012-10-05  111  
06c2d368 Keerthy        2016-02-17  112  #define GET_DRA_CLASS	((omap_rev() >> 24) & 0xff)
06c2d368 Keerthy        2016-02-17  113  
06c2d368 Keerthy        2016-02-17  114  #define IS_DRA_CLASS(class, id)				\
06c2d368 Keerthy        2016-02-17  115  static inline int is_dra ##class (void)			\
06c2d368 Keerthy        2016-02-17  116  {							\
06c2d368 Keerthy        2016-02-17  117  	return (GET_DRA_CLASS == (id)) ? 1 : 0;		\
06c2d368 Keerthy        2016-02-17  118  }
06c2d368 Keerthy        2016-02-17  119  
e4c060db Tony Lindgren  2012-10-05  120  #define GET_OMAP_SUBCLASS	((omap_rev() >> 20) & 0x0fff)
e4c060db Tony Lindgren  2012-10-05  121  
e4c060db Tony Lindgren  2012-10-05  122  #define IS_OMAP_SUBCLASS(subclass, id)			\
e4c060db Tony Lindgren  2012-10-05  123  static inline int is_omap ##subclass (void)		\
e4c060db Tony Lindgren  2012-10-05  124  {							\
e4c060db Tony Lindgren  2012-10-05  125  	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
e4c060db Tony Lindgren  2012-10-05  126  }
e4c060db Tony Lindgren  2012-10-05  127  
e4c060db Tony Lindgren  2012-10-05  128  #define IS_TI_SUBCLASS(subclass, id)			\
e4c060db Tony Lindgren  2012-10-05  129  static inline int is_ti ##subclass (void)		\
e4c060db Tony Lindgren  2012-10-05  130  {							\
e4c060db Tony Lindgren  2012-10-05  131  	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
e4c060db Tony Lindgren  2012-10-05  132  }
e4c060db Tony Lindgren  2012-10-05  133  
e4c060db Tony Lindgren  2012-10-05  134  #define IS_AM_SUBCLASS(subclass, id)			\
e4c060db Tony Lindgren  2012-10-05  135  static inline int is_am ##subclass (void)		\
e4c060db Tony Lindgren  2012-10-05  136  {							\
e4c060db Tony Lindgren  2012-10-05  137  	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
e4c060db Tony Lindgren  2012-10-05  138  }
e4c060db Tony Lindgren  2012-10-05  139  
06c2d368 Keerthy        2016-02-17  140  #define IS_DRA_SUBCLASS(subclass, id)			\
06c2d368 Keerthy        2016-02-17  141  static inline int is_dra ##subclass (void)		\
06c2d368 Keerthy        2016-02-17  142  {							\
06c2d368 Keerthy        2016-02-17  143  	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
06c2d368 Keerthy        2016-02-17  144  }
06c2d368 Keerthy        2016-02-17  145  
e4c060db Tony Lindgren  2012-10-05  146  IS_OMAP_CLASS(24xx, 0x24)
e4c060db Tony Lindgren  2012-10-05  147  IS_OMAP_CLASS(34xx, 0x34)
e4c060db Tony Lindgren  2012-10-05  148  IS_OMAP_CLASS(44xx, 0x44)
e4c060db Tony Lindgren  2012-10-05  149  IS_AM_CLASS(35xx, 0x35)
e4c060db Tony Lindgren  2012-10-05  150  IS_OMAP_CLASS(54xx, 0x54)
e4c060db Tony Lindgren  2012-10-05  151  IS_AM_CLASS(33xx, 0x33)
c664d0a9 Afzal Mohammed 2013-05-27  152  IS_AM_CLASS(43xx, 0x43)
e4c060db Tony Lindgren  2012-10-05  153  
e4c060db Tony Lindgren  2012-10-05  154  IS_TI_CLASS(81xx, 0x81)
06c2d368 Keerthy        2016-02-17  155  IS_DRA_CLASS(7xx, 0x7)
e4c060db Tony Lindgren  2012-10-05  156  
e4c060db Tony Lindgren  2012-10-05  157  IS_OMAP_SUBCLASS(242x, 0x242)
e4c060db Tony Lindgren  2012-10-05  158  IS_OMAP_SUBCLASS(243x, 0x243)
e4c060db Tony Lindgren  2012-10-05  159  IS_OMAP_SUBCLASS(343x, 0x343)
e4c060db Tony Lindgren  2012-10-05  160  IS_OMAP_SUBCLASS(363x, 0x363)
e4c060db Tony Lindgren  2012-10-05  161  IS_OMAP_SUBCLASS(443x, 0x443)
e4c060db Tony Lindgren  2012-10-05  162  IS_OMAP_SUBCLASS(446x, 0x446)
e4c060db Tony Lindgren  2012-10-05  163  IS_OMAP_SUBCLASS(447x, 0x447)
e4c060db Tony Lindgren  2012-10-05  164  IS_OMAP_SUBCLASS(543x, 0x543)
e4c060db Tony Lindgren  2012-10-05  165  
e4c060db Tony Lindgren  2012-10-05  166  IS_TI_SUBCLASS(816x, 0x816)
e4c060db Tony Lindgren  2012-10-05  167  IS_TI_SUBCLASS(814x, 0x814)
e4c060db Tony Lindgren  2012-10-05  168  IS_AM_SUBCLASS(335x, 0x335)
c664d0a9 Afzal Mohammed 2013-05-27  169  IS_AM_SUBCLASS(437x, 0x437)
06c2d368 Keerthy        2016-02-17  170  IS_DRA_SUBCLASS(75x, 0x75)
06c2d368 Keerthy        2016-02-17  171  IS_DRA_SUBCLASS(72x, 0x72)
e4c060db Tony Lindgren  2012-10-05  172  
d0b50905 Tony Lindgren  2015-10-16  173  #define soc_is_ti81xx()			0
d0b50905 Tony Lindgren  2015-10-16  174  #define soc_is_ti816x()			0
d0b50905 Tony Lindgren  2015-10-16  175  #define soc_is_ti814x()			0
e4c060db Tony Lindgren  2012-10-05  176  #define soc_is_am35xx()			0
e4c060db Tony Lindgren  2012-10-05  177  #define soc_is_am33xx()			0
e4c060db Tony Lindgren  2012-10-05  178  #define soc_is_am335x()			0
c664d0a9 Afzal Mohammed 2013-05-27  179  #define soc_is_am43xx()			0
c664d0a9 Afzal Mohammed 2013-05-27  180  #define soc_is_am437x()			0
d0b50905 Tony Lindgren  2015-10-16  181  #define soc_is_omap44xx()		0
d0b50905 Tony Lindgren  2015-10-16  182  #define soc_is_omap443x()		0
d0b50905 Tony Lindgren  2015-10-16  183  #define soc_is_omap446x()		0
d0b50905 Tony Lindgren  2015-10-16  184  #define soc_is_omap447x()		0
e4c060db Tony Lindgren  2012-10-05  185  #define soc_is_omap54xx()		0
e4c060db Tony Lindgren  2012-10-05  186  #define soc_is_omap543x()		0
6852215a R Sricharan    2013-02-06  187  #define soc_is_dra7xx()			0
af438fec Rajendra Nayak 2014-08-27  188  #define soc_is_dra74x()			0
af438fec Rajendra Nayak 2014-08-27  189  #define soc_is_dra72x()			0
e4c060db Tony Lindgren  2012-10-05  190  
e4c060db Tony Lindgren  2012-10-05  191  #if defined(CONFIG_ARCH_OMAP2)
d0b50905 Tony Lindgren  2015-10-16  192  #  define soc_is_omap24xx()		is_omap24xx()
e4c060db Tony Lindgren  2012-10-05  193  #endif
e4c060db Tony Lindgren  2012-10-05 @194  #if defined(CONFIG_SOC_OMAP2420)
d0b50905 Tony Lindgren  2015-10-16  195  #  define soc_is_omap242x()		is_omap242x()
e4c060db Tony Lindgren  2012-10-05  196  #if defined(CONFIG_SOC_OMAP2430)
d0b50905 Tony Lindgren  2015-10-16  197  #  define soc_is_omap243x()		is_omap243x()

:::::: The code at line 194 was first introduced by commit
:::::: e4c060db2c13f10de09101afc564763f9fd0019a ARM: OMAP: Split plat/cpu.h into local soc.h for mach-omap1 and mach-omap2

:::::: TO: Tony Lindgren <tony@atomide.com>
:::::: CC: Tony Lindgren <tony@atomide.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--Nq2Wo0NMKNjxTN9z
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--Nq2Wo0NMKNjxTN9z--
