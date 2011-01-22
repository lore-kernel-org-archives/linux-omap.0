From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH v8 00/18] OMAP2,3: hwmod DSS Adaptation
Date: Sat, 22 Jan 2011 11:02:23 +0530
Message-ID: <AANLkTikf1dO=m_zkQ07YKU-MCRa1bFA0oRHEYXgO2YPQ@mail.gmail.com>
References: <1295621441-16678-1-git-send-email-sumit.semwal@ti.com> <87y66edxk3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:45568 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750875Ab1AVFcr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 22 Jan 2011 00:32:47 -0500
Received: by bwz15 with SMTP id 15so2232308bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 21 Jan 2011 21:32:44 -0800 (PST)
In-Reply-To: <87y66edxk3.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org

Hi Kevin,

On Fri, Jan 21, 2011 at 10:05 PM, Kevin Hilman <khilman@ti.com> wrote:
> Sumit Semwal <sumit.semwal@ti.com> writes:
>
>> v8 of the DSS hwmod patch series fixes some issues based on findings=
 of
>> Kevin Hilman on beagle.
>
> Thanks. =A0I re-tested on beagle and it looks good.
>
> I also briefly tested on beagle with PM. =A0I tested suspend/resume t=
o
> verify we could still hit full-chip retention. =A0I also verified idl=
e
> with and without screen blanked. =A0As expected, with the screen (ext=
ernal
> DVI monitor) active, the DSS power domain did not hit retentiond duri=
ng
> idle, but allowing the screen to blank, DSS powerdomain then hits idl=
e.
>
> Feel free to add:
>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> Tested-by: Kevin Hilman <khilman@ti.com>
>
> Also, can you repost one more time with the
> linux-arm-kernel@lists.infradead.org Cc'd? =A0Thanks.
Thanks very much for helping out with the testing!

I will post an updated one w/ your reviewed-by and tested-by in a bit.

Best regards,
~Sumit.
>
> Kevin
>
>> The VENC platform driver was not getting registered due to missed de=
vice
>> name update for vdda_dac regulator in some board files. This was mov=
ed from
>> 'omap_display' device to 'omap_venc' device in patch 14/18.
>>
>> Also, similarly for DSI platform driver, the regulator name 'vdds_ds=
i' needs two
>> instances - one for dpi, and one for dsi.
>>
>> This version corrects the above two for all board files where 'vdda_=
dac' and
>> 'vdds_dsi' regulators are defined. [patches 14/18 and 15/18]
>>
>> Post this change, boot w/ visible framebuffer and tux was successful=
ly validated
>> on beagle, 3430SDP and zoom3.
>>
>> A patch mentioned in
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42384.html
>> was needed to get OMAP3 to boot up on top of linux-next of 20110115.
>>
>> OMAP4 hwmod support will be posted after the acceptance of this basi=
c change in
>> the dss2 design.
>>
>> -------------------------------------------------
>> [original patch introduction]
>>
>> This patch series decouples the "Clocks for DSS in hwmod adaptation"=
 changes
>> from this series. =A0Another series would be posted which could be d=
iscussed
>> w.r.t clocks in DSS across omap2,3.
>>
>> Removing the SYSCONFIG settings from DSS driver would also be part o=
f these
>> clock changes series and not covered in this series as it depends on=
 some of
>> the omap_hwmod framework changes w.r.t opt clocks handling.
>>
>> Summary of the hwmod DSS design:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> DSS, DISPC, DSI, RFBI, VENC are made as platform drivers each
>> corresponding to the hwmod class in the hwmod database.
>>
>> Each of these platform drivers' init / deinit are handled from core.=
c's
>> omap_dss_probe() in the exact sequence as required.
>>
>> No Hardcoding of silicon data:
>> hwmod database abstracts the SOC data like base addr, irq numbers an=
d are
>> implemented in this patch series.
>>
>> Continue to have custom bus for display panels:
>> "omap_display" driver continues to be a platform driver that registe=
rs the custom
>> bus. =A0It also continues to register the display panels(omap_dss_de=
vice) on the
>> board to the panel drivers (omap_dss_driver)
>> For Eg: =A0primary lcd device would be registered with lcd panel dri=
ver.
>> lcd panel driver if it is on a parallel interface would use library =
functions
>> exported from dpi.o. =A0if it is on a dsi interface would use librar=
y functions
>> exported from dsi platform driver(dsi.o).
>>
>> Clocks:
>> Handling of clocks in DSS only is one of the design approaches, that=
 does not
>> change the existing implementation. =A0If each of the DSS HW IPs had=
 to handle
>> their own clocks, then corresponding clock changes can be requested =
in the hwmod
>> database as well which is not the current design/implementation. =A0=
As stated,
>> this would be handled in another series seperately.
>> For Eg: VENC would need 54MCLK which is termed as dss_opt clocks as =
of now apart
>> for the dss main clocks. =A0Currently VENC driver needs to be aware =
of this and has to
>> use clk_get/put, clk_enable/disable, since VENC hwmod is not aware o=
f 54MCLK.
>>
>>
>>
>> Current dss driver:
>> -------------------
>> 1. =A0Omapdss platform driver
>> =A0 =A0 =A0 =A0 - initialises necessary Ips dss, dispc.
>> =A0 =A0 =A0 =A0 - also initialises Ips like sdi, dsi, venc, rfbi
>> =A0 =A0 =A0 =A0 - creates a custom bus and registers the display dev=
ices/drivers
>> =A0 =A0 =A0 =A0 connected on the board to the custom bus.
>>
>> 2. =A0Suspend/resume of omapdss
>> =A0 =A0 =A0 =A0 - in turn sends suspend/resume calls for each of the=
 display devices
>> =A0 =A0 =A0 =A0 registered to it.
>>
>> Modified change:
>> ---------------
>> Platform driver for each DSS HW IP in addition to the software "omap=
_display"
>> driver.
>>
>> Omapdss platform driver
>> =A0 =A0 =A0 =A0 - initialises necessary h/w IPs' platform drivers [d=
ss, dispc, dsi, venc, rfbi]
>> =A0 =A0 =A0 =A0 and software libraries like dpi, sdi.
>> =A0 =A0 =A0 =A0 - continues to have a custom bus and registers the d=
isplay devices
>> =A0 =A0 =A0 =A0 and drivers connected on the board to the custom bus=
=2E
>> =A0 =A0 =A0 =A0 - continues to handle suspend/resume of the display =
devices registered
>> =A0 =A0 =A0 =A0 to the custom bus.
>>
>> DSS platform driver
>> =A0 =A0 =A0 =A0 - initialises DSS IP alone
>> =A0 =A0 =A0 - Handles the clocks related to the DSS and other DSSHW =
IPs like RFBI,
>> =A0 =A0 =A0 DSI, VENC, DISPC. =A0Previously this was a part of "omap=
dss" driver in core.c
>> =A0 =A0 =A0 - Continues to handle the DSS IRQs.
>> =A0 =A0 =A0 - No suspend/resume hooks.
>>
>> DISPC platform driver
>> =A0 =A0 =A0 =A0 - initialises DISPC IP alone
>> =A0 =A0 =A0 - Gets the required clock from DSS platform driver.
>> =A0 =A0 =A0 - No suspend/resume hooks.
>> =A0 =A0 =A0 - Continues to provide DISPC library functions.
>>
>> DSI platform driver
>> =A0 =A0 =A0 =A0 - initialises DSI IP alone
>> =A0 =A0 =A0 - Gets the required clock from DSS platform driver.
>> =A0 =A0 =A0 - No suspend/resume hooks.
>> =A0 =A0 =A0 - Continues to provide DSI library functions.
>>
>> RFBI, VENC platform drivers
>> =A0 =A0 =A0 =A0 - initialises DSI,VENC IPs
>> =A0 =A0 =A0 - Gets the required clock from DSS platform driver.
>> =A0 =A0 =A0 - No suspend/resume hooks.
>> =A0 =A0 =A0 - Continues to provide RFBI and VENC library functions.
>>
>> Testing:
>> ---------
>> The patches are tested on 2420-n800, 2430sdp, 3630zoom, 3430sdp.
>> Complete bootup with penguins on panel is done on 3430sdp.
>> For the rest of the mentioned platforms, kernel is built with "OMAP2=
_DSS"
>> and bootup is tested so that base address and clk_get calls are succ=
essful.
>>
>> DSS was built successfully as module, though not tested yet.
>>
>> Changes since v6:
>> -----------------
>> * board-zoom-peripherals.c: Added missing change of device name from=
 omapdss to omap_display.
>> =A0 =A0 =A0 Found during testing on OMAP3630 on top of
>> Changes since v5:
>> ----------------
>> 1) Following review comments incorporated:
>> =A0* =A0 =A0http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg42031.html
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Make sure display.c is built when DSS is=
 enabled built-in or as a module.
>> =A0* =A0 =A0http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg42083.html
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hwmod and omap_device headers moved to p=
atch 8 when they're
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 needed the first time.
>> =A0* =A0 =A0http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg42094.html
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 - latency set to AUTO_ADJUST
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 - extra whitespaces removed.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 - pdata memset to 0 before use.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 - if omap_device_build fails, return err=
or.
>> =A0* =A0 =A0http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg42095.html
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 renamed *_deinit_* to *_uninit_*
>>
>> =A0* =A0 =A0http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg42171.html
>> =A0 =A0 =A0 http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg42172.html
>> =A0 =A0 =A0 http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg42173.html
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 - added L3 and L4 firewall related data,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 - corrected handling of .idlest_idle_bit=
 v/w .idlest_stdby_bit
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 - no .idlest_*_bit setting for dependent=
 hwmods
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 - corrected .user to add SDMA
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 - renamed dss_dss to dss_core
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 - hwmod for 3430es1 and later 3xxx are s=
eparated out, with some
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reuse of data.
>> =A0* =A0 =A0Removed forced-disable of dss clocks from omap_dss_remov=
e.
>>
>> Changes since v4:
>> ----------------
>> 1) Following review comments incorporated:
>> =A0* =A0 =A0http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg41970.html
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Corrected the clocks to be enabled in om=
ap_dss_probe.
>> Changes since v3:
>> ----------------
>> 1.) Following review comments incorporated:
>> =A0* =A0 =A0http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg41705.html
>> =A0 =A0 =A0 http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg41683.html
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Created a new display.c file for dss dri=
ver registration
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 related code.
>>
>> =A0* =A0 =A0http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg41573.html
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Changed the oh_name/dev_name handling in=
 hwmod usage.
>>
>> =A0* =A0 =A0http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg41753.html
>> =A0 =A0 =A0 http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg41718.html
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 removed device_initcall_sync(); init / d=
einit of each DSS h/w IP
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 platform drivers are done from omap_dss_=
probe() in sequence.
>>
>> =A0* =A0 =A0http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg41754.html
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock patches were cleaned up as per rev=
iew comments.
>>
>> =A0* =A0 =A0http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg41756.html
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk() =3D> dev_dbg change was separat=
ed out.
>>
>>
>> Changes since v2:
>> -------------------
>> 1.) Following review comments incorporated:
>> =A0 =A0 =A0 Split the device/driver name change and registration pat=
ches logically.
>> =A0 =A0 =A0 http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg41205.html
>> =A0 =A0 =A0 http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg41204.html
>> =A0 =A0 =A0 http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg41203.html
>>
>> Changes since v1:
>> ------------------
>> 1.) Dynamically register for OMAP2,3 specific DSS HW IPs in devices.=
c
>> 2.) Following review comments incorporated:
>> =A0 =A0 =A0 Updation of all the board files on l-o dss2 branch as pe=
r
>> =A0 =A0 =A0 http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg36915.html
>> =A0 =A0 =A0 Comments incorporated in devices.c and display.h as per
>> =A0 =A0 =A0 http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg36919.html
>> =A0 =A0 =A0 Comments incorporated in dispc.c, dss.c, dsi.c, venc.c, =
rfbi.c
>> =A0 =A0 =A0 so that platform_device is just above platform_driver re=
gistrations as per
>> =A0 =A0 =A0 http://www.mail-archive.com/linux-omap@vger.kernel.org/m=
sg36963.html
>> 3.) Squashed some of the patches to one patch.
>>
>> Changes since RFC:
>> -------------------
>> 1) All the platform driver registration except DSS, were within the =
file core.c.
>> Registeration of these driver got seperated to its own file.
>> 2) Usage of regulators by different drivers are implemented.
>> For Eg: Regulator used by VENC is moved to venc driver. =A0But vdda_=
dac would be
>> needed by DPI and DSI as well.
>> 4) OMAP2420 and OMAP2430 hwmod database are generated in this v1.
>> 5) Module support for omapdss driver can continue as the DSS HW IP s=
pecific platform
>> drivers are decoupled from omapdss driver.
>> 6) Following review comments incorporated:
>> =A0 =A0 =A0 Changed the hwmod device name from "dss" to "dss_dss"
>> =A0 =A0 =A0 Changed name of core driver from "omapdss" to "omap_disp=
lay" as it deals with panels.
>> =A0 =A0 =A0 Fixed comments on return values from platform_get_resour=
ce/irq functions.
>>
>> Patch Base:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Patch-set rebased and tested w/ Zoom3 (OMAP3630) on top of:
>> url =3D git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-nex=
t.git
>> branch "master"
>> commit =A0 =A0 =A0 =A0e8883f8057c0f7c9950fa9f20568f37bfa62f34a
>> Description: Add linux-next specific files for 20110115
>> +
>> Patch mentioned in http://www.mail-archive.com/linux-omap@vger.kerne=
l.org/msg42384.html
>> [PATCH] OMAP: counter_32k: init clocksource as part of machine timer=
 init
>>
>> (This patch is required for OMAP bootup w/ 20110115 linux-next)
>>
>> --------------------------------------------------------------------=
--------
>> Senthilvadivu Guruswamy (15):
>> =A0 OMAP2420: hwmod data: add DSS DISPC RFBI VENC
>> =A0 OMAP2430: hwmod data: add DSS DISPC RFBI VENC
>> =A0 OMAP3: hwmod data: add DSS DISPC RFBI DSI VENC
>> =A0 OMAP2,3 DSS2 Change driver name to omap_display
>> =A0 OMAP2,3 DSS2 Use Regulator init with driver name
>> =A0 OMAP2,3: DSS2: board files: replace platform_device_register wit=
h
>> =A0 =A0 omap_display_init()
>> =A0 OMAP2,3: DSS2: Build omap_device for each DSS HWIP
>> =A0 OMAP2,3: DSS2: DSS: create platform_driver, move init,exit to dr=
iver
>> =A0 OMAP2,3: DSS2: Move clocks from core driver to dss driver
>> =A0 OMAP2,3: DSS2: RFBI: create platform_driver, move init,exit to d=
river
>> =A0 OMAP2,3: DSS2: DISPC: create platform_driver, move init,exit to
>> =A0 =A0 driver
>> =A0 OMAP2,3: DSS2: VENC: create platform_driver, move init,exit to d=
river
>> =A0 OMAP2,3: DSS2: DSI: create platform_driver, move init,exit to dr=
iver
>> =A0 OMAP2,3: DSS2: Use platform device to get baseaddr
>> =A0 OMAP2,3: DSS2: Get DSS IRQ from platform device
>>
>> Sumit Semwal (3):
>> =A0 OMAP2,3: DSS2: remove forced clk-disable from omap_dss_remove
>> =A0 OMAP2,3: DSS2: Create new file display.c for central dss driver
>> =A0 =A0 registration.
>> =A0 OMAP2,3: DSS2: replace printk with dev_dbg in init
>>
>> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A03 +
>> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 =A0 =A0 =A0| =A0 26 +=
--
>> =A0arch/arm/mach-omap2/board-am3517evm.c =A0 =A0 =A0 =A0| =A0 16 +-
>> =A0arch/arm/mach-omap2/board-cm-t35.c =A0 =A0 =A0 =A0 =A0 | =A0 22 +=
-
>> =A0arch/arm/mach-omap2/board-devkit8000.c =A0 =A0 =A0 | =A0 22 +-
>> =A0arch/arm/mach-omap2/board-igep0020.c =A0 =A0 =A0 =A0 | =A0 20 +-
>> =A0arch/arm/mach-omap2/board-omap3beagle.c =A0 =A0 =A0| =A0 22 +-
>> =A0arch/arm/mach-omap2/board-omap3evm.c =A0 =A0 =A0 =A0 | =A0 30 +--
>> =A0arch/arm/mach-omap2/board-omap3pandora.c =A0 =A0 | =A0 17 +-
>> =A0arch/arm/mach-omap2/board-omap3stalker.c =A0 =A0 | =A0 26 +-
>> =A0arch/arm/mach-omap2/board-rx51-peripherals.c | =A0 =A04 +-
>> =A0arch/arm/mach-omap2/board-rx51-video.c =A0 =A0 =A0 | =A0 15 +-
>> =A0arch/arm/mach-omap2/board-zoom-display.c =A0 =A0 | =A0 15 +-
>> =A0arch/arm/mach-omap2/board-zoom-peripherals.c | =A0 12 +-
>> =A0arch/arm/mach-omap2/clock2420_data.c =A0 =A0 =A0 =A0 | =A0 =A08 +=
-
>> =A0arch/arm/mach-omap2/clock2430_data.c =A0 =A0 =A0 =A0 | =A0 =A08 +=
-
>> =A0arch/arm/mach-omap2/clock3xxx_data.c =A0 =A0 =A0 =A0 | =A0 14 +-
>> =A0arch/arm/mach-omap2/display.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 96 ++++++
>> =A0arch/arm/mach-omap2/omap_hwmod_2420_data.c =A0 | =A0311 +++++++++=
+++++++++-
>> =A0arch/arm/mach-omap2/omap_hwmod_2430_data.c =A0 | =A0284 +++++++++=
+++++++
>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c =A0 | =A0433 +++++++++=
++++++++++++++++
>> =A0arch/arm/plat-omap/include/plat/display.h =A0 =A0| =A0 16 +
>> =A0arch/arm/plat-omap/include/plat/l3_2xxx.h =A0 =A0| =A0 20 ++
>> =A0arch/arm/plat-omap/include/plat/l3_3xxx.h =A0 =A0| =A0 20 ++
>> =A0arch/arm/plat-omap/include/plat/l4_2xxx.h =A0 =A0| =A0 24 ++
>> =A0arch/arm/plat-omap/include/plat/l4_3xxx.h =A0 =A0| =A0 10 +
>> =A0drivers/video/omap2/dss/core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A04=
48 ++------------------------
>> =A0drivers/video/omap2/dss/dispc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A01=
14 ++++---
>> =A0drivers/video/omap2/dss/dsi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 78 ++++-
>> =A0drivers/video/omap2/dss/dss.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
411 +++++++++++++++++++++++-
>> =A0drivers/video/omap2/dss/dss.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 46 ++--
>> =A0drivers/video/omap2/dss/rfbi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A01=
18 ++++---
>> =A0drivers/video/omap2/dss/venc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A01=
25 +++++---
>> =A033 files changed, 2049 insertions(+), 785 deletions(-)
>> =A0create mode 100644 arch/arm/mach-omap2/display.c
>> =A0create mode 100644 arch/arm/plat-omap/include/plat/l3_2xxx.h
>> =A0create mode 100644 arch/arm/plat-omap/include/plat/l3_3xxx.h
>> =A0create mode 100644 arch/arm/plat-omap/include/plat/l4_2xxx.h
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
