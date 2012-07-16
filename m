From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: OMAP HWMOD: Query regarding parent<->child support
Date: Mon, 16 Jul 2012 19:41:56 +0530
Message-ID: <5004212C.5030807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58483 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231Ab2GPOMF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jul 2012 10:12:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Mugunthan V N <mugunthanvnm@ti.com>, Avinash Philip <avinashphilip@ti.com>

Hi All,

During migration to run-time PM we came across unique (I believe) issue
with respect to CPSW driver and eHRPWM. I am looking for pointers to
handle these use-cases, as I am still going through the code and trying
to understand myself on how can we handle this.

CPSW:
=====
CPSW Subsystem is built with 5 sub-modules,
	- CPSW SS (BaseAddr@0x4A100000, rst@0x8)
	- MDIO (BaseAddr@0x4A101000)
	- CPSW WR (0x4A101200, rst@0x4)
	- CPSW SL1 (0x4A100D80, rst@0xc)
	- CPSW SL2 (0x4A100DC0, rst@0xc)
	- CPSW CPDMA (0x4A100800, rst@0x1c)

  Issue1:
  -------
    IP's are reused from legacy devices, for example, we have 2
    separate platform driver for MDIO and cpsw, used between Davinci
   and AM335x.

    Everything is controlled through one MODULEMODE register in PRCM.
    So now we have 2 different modules accessing same resources
   (CLKCTRL.MODULEMODE), it is tricky to handle this usecase.
    Earlier with clock api's, it was easy, since clock framework used
    to handle ref_count for this and was sufficient here but with
    migration to runtime PM, we no longer use clk api's.

    Option1:
	It must be handled at driver level, and there will be
	handshaking between both the drivers. Which might impact legacy
	devices.

   Option2:
	It must be handled at SoC level, and parent and child creation
	is required here. parent->child creation is possible with
	platform device, but not sure about how it can be integrated
	with omap_device and hwmod.

	I am reading code and trying to understand how can this be
	handled? what is right place to create this parent<->child
	relation?

  Issue2:
  -------
    Due to one of the HW bug, we have assert ocp-reset 4 sub-modules of
    CPSW before disabling clock/module (MODULEMODE=0) everytime.
    So for example, in every suspend-resume code before disabling the
    module, we have to assert ocp-reset and then disable the module.
    Also, please note that, the MDIO driver is separate and independent
    and requires clock to access sysconf register.

    We can have hwmod_class->reset function here, but the reset offset
    is different for every module, which makes it even difficult to
    handle.

    So if we have parent-child relation at some level, Where, we can
    register custom reset function to handle this scenario is required,
    like,
	CPSW
	    -> MDIO
	    -> CPSW WR
	    -> CPSW SL1
	    -> CPSW SL2
	    -> CPDMA

    Currently, as part of internal release we implemented in hackish
    way, where we pass base address of sub-modules (- 0x8) so that we
    can access rst_off in common function with,
      omap_hwmod_addr_space->pa_start + class.rst_offs

eHRPWM1/2/3:
============
  Here we have same issue as issue1 mentioned above for CPSW. eHRPWM is
  built with 2 independent sub-modules (eCAP and HRPWM) with single
  resource access (MODULEMODE).

  Functionality point-of-view both can work independently, except
  clock/module enable disable (which is shared between both).

  Will MFD solve this issue? and will it be right approach? Would it
  make sense to have MFD for such small small independent drivers?

Thanks,
Vaibhav
