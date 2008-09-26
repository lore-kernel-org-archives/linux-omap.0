From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 00/16] OMAP3: Context save/Restore + OFF mode support
Date: Fri, 26 Sep 2008 17:46:57 +0530
Message-ID: <01f101c91fd1$c6c95900$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52874 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbYIZMRK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 08:17:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Kevin Hilman' <khilman@deeprootsystems.com>

Hi,

This patch set adds context save/restore routines for minimal kernel and OFF mode
support in idle and suspend. This patch set applies on top of pm-1 branch.

This has context save/restore support implemented for the following modules
GPMC, UART, GPIO, I2C, PRCM, INTC, SCM, SRAM. 

A sysfs knob to dynamically control OFF mode is provided at 
/sys/power/enable_off_mode. This is set to 0 (disabled) by default.

After bootup execute the following commands to be able to achieve OFF mode
in idle as well as in suspend.

# echo -n 1 > /sys/power/enable_off_mode
# echo -n 1 > /sys/power/clocks_off_while_idle
# echo -n 1 > /sys/power/sleep_while_idle

regards,
Rajendra


