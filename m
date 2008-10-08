From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 00/05] OMAP3: CPUidle driver
Date: Wed, 8 Oct 2008 17:30:33 +0530
Message-ID: <001601c9293d$79bd4200$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37139 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448AbYJHMAr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2008 08:00:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Kevin Hilman' <khilman@deeprootsystems.com>

Hi,

This patch set implements Cpuidle driver for OMAP3 platforms. It is validated on the 3430SDP (using the 
omap_3430sdp_min_defconfig) and applies on the pm-20081006 branch.

The following C states are defined and used 

 *      C0 . System executing code (Not an idle state)
 *      C1 . MPU WFI + Core active
 *      C2 . MPU CSWR + Core active
 *      C3 . MPU OFF + Core active
 *      C4 . MPU CSWR + Core CSWR
 *      C5 . MPU OFF + Core CSWR
 *      C6 . MPU OFF + Core OFF

CPUidle support is not enabled by default in any of the defconfigs and hence has to enabled seperately 
if you plan to test these patches.

CPUIdle ---> [*] CPU idle PM support

regards,
Rajendra

