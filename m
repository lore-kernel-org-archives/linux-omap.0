From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 00/11] OMAP3 CPUidle patches
Date: Tue, 1 Jul 2008 19:46:01 +0530
Message-ID: <003d01c8db84$fe61fde0$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57367 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759518AbYGAOQ1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Jul 2008 10:16:27 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m61EG3Ev015438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Jul 2008 09:16:15 -0500
Received: from a0393137pc (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m61EG1q3011273
	for <linux-omap@vger.kernel.org>; Tue, 1 Jul 2008 19:46:02 +0530 (IST)
References: 
In-Reply-To: 
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

The following patches define and enable all of the below mentioned C states for OMAP3. 
These are tested with a minimal kernel config on OMAP3430sdp as most drivers today don't have context save/restore in place and
some even lack aggresive clock handling. 
These apply on top of the workaround patch set submitted by Jouni. 
([PATCH 0/6] 34XX: PM: Workarounds to get omap3 to retention 4th.)

The following is neccessay even with a minimal config to achieve OFF.
 $ echo 1 > /sys/power/sleep_while_idle
 $ echo 1 > /sys/power/clocks_off_while_idle
  
The following C states are defined
C0 - System executing code
C1 - MPU WFI + Core active
C2 - MPU CSWR + Core active
C3 - MPU OFF + Core active
C4 - MPU CSWR + Core CSWR
C5 - MPU OFF + Core CSWR
C6 - MPU OFF + Core OFF
 
regards,
Rajendra



