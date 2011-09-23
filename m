From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 00/18] omap PRCM chain handler
Date: Fri, 23 Sep 2011 15:46:08 +0300
Message-ID: <1316781986-30642-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello,

Following set contains the version 9 of this work. This patch set contains
a number of patches tagged as 'TEMP', they are only meant for testing
purposes and to provide proof of concept. Most of the 'TEMP' patches are
related to UART runtime handling and they will be replaced by work done
by Govindraj Raja.

As this is a new set sent to linux-arm and linux-kernel lists, the basic
concept being tackled with this set is to provide a mechanism for multiple
drivers to register for PRCM interrupts. PRCM interrupt contains a SoC
depenpend number of events, which of most interesting ones are wakeup and
IO chain. These are the only supported events in the driver currently, but
it is possible to add more by tweaking omap3xxx-prm.c and omap4xxx-prm.c
files.

This driver should also be expanded later to contain much of the code
currently included within the OMAP voltage framework, which resides under
arch/arm/mach-omap2/voltage*,vc*,vp*.

Changes compared to previous version of this set:

- PRM driver is now moved under /drivers/mfd
- PRM driver split into three parts now, common, omap3 and omap4
- version of the driver to init is detected based on PRM version (patch 11)
- cleaned up the initialization logic a bit (platform device is built
  separately, provide two different drivers)
- renamed PRM hwmods as prm3xxx and prm4xxx

These patches have been tested on omap3 beagle and omap4 blaze platforms.
Tested features include suspend and dynamic idle.
Tested trees are available at:

git@gitorious.org:~kristo/omap-pm/omap-pm-work.git

branches: omap3_prcm_chain and omap4_prcm_chain

-Tero


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 
