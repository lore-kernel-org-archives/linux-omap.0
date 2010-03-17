From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: compilation error on hwmods branch
Date: Wed, 17 Mar 2010 20:42:43 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C489C494@dbde02.ent.ti.com>
References: <87y6isixhc.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37871 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723Ab0CQPMt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 11:12:49 -0400
In-Reply-To: <87y6isixhc.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

In "origin/pm-wip/hwmods" branch, using "omap_3430sdp_defconfig" or  "omap3_defconfig", results in the following error. 
Anyone working on this?

drivers/usb/musb/omap2430.c:261: error: expected identifier or '(' before 'do'
drivers/usb/musb/omap2430.c:261: error: expected identifier or '(' before 'while'
drivers/usb/musb/omap2430.c:268: error: expected identifier or '(' before 'do'
drivers/usb/musb/omap2430.c:268: error: expected identifier or '(' before 'while'
make[2]: *** [drivers/usb/musb/omap2430.o] Error 1
make[1]: *** [drivers/usb/musb] Error 2
make: *** [drivers] Error 2


Last commit:
-----------
commit 799e299e05ca47664c8534dede56fc0a070ae30c
Author: Kevin Hilman <khilman@deeprootsystems.com>
Date:   Thu Jan 7 16:19:53 2010 -0800

    OMAP: UART: omap_device converions, remove implicit 8520 assumptions

    Major rework of OMAP UART init for omap_device conversion as well as
    use with either 8250 driver or new omap-serial driver.

    Signifcant contributions and testing from Govindraj R <govindraj.raja@ti.com>.

    In preparation for a new omap-serial driver, remove 8250 assumptions
    and dependencies from the serial core.

    Convert UART core and PM support to use omap_device layer.  Also add
    support for both console on 8250 or omap-serial driver.

    omap_device conversion:
    - Convert clock API calls to omap_device calls
    - Remove all static platform_data setup and configuration.  This is
      all done by the omap_device build phase.

    Known issues:
    - broken on OMAP4 until OMAP4 UART hwmods are available

    Cc: Govindraj R <govindraj.raja@ti.com>
    Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

