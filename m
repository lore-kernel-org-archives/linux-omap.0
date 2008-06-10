From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 00/02] OMAP3 CPUidle patches
Date: Tue, 10 Jun 2008 12:38:55 +0530
Message-ID: <0a2301c8cac8$d9352d70$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34315 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844AbYFJHJV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jun 2008 03:09:21 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m5A78vhm028357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 10 Jun 2008 02:09:09 -0500
Received: from a0393137pc (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m5A78t3g004604
	for <linux-omap@vger.kernel.org>; Tue, 10 Jun 2008 12:38:56 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

The next couple of patches which follow implement the Basic OMAP3 CPUidle driver.

The following C states are defined
C0 - System executing code
C1 - MPU WFI + Core active
C2 - MPU CSWR + Core active
C3 - MPU OFF + Core active
C4 - MPU CSWR + Core CSWR
C5 - MPU OFF + Core CSWR
C6 - MPU OFF + Core OFF

Currently only C0/C1/C2/C4 are enabled as OFF support is missing.
For now CPUidle is kept disabled by default.

regards,
Rajendra

