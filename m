From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [OMAPZOOM][PATCH v2 0/2] Some more camera syncup patches
Date: Wed, 7 Jan 2009 18:12:59 -0600
Message-ID: <A24693684029E5489D1D202277BE894416328C8E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49042 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbZAHANH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 19:13:07 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n080D1RD030833
	for <linux-omap@vger.kernel.org>; Wed, 7 Jan 2009 18:13:06 -0600
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n080D0GT007318
	for <linux-omap@vger.kernel.org>; Wed, 7 Jan 2009 18:13:00 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

Hi,

These 2 patches also syncs up some other features added previously on TI internal tree:

- Preview settings fix: this fixes some gains in order to obtain a much better image in OV sensor. (Same as v1)

- Set VPP constraints: This is needes when TI PM is enabled, as this ensures proper operation maintaining voltage frequency levels. (v2: FIXED with correct silicon revision checking, Thanks to Vikram for pointing this out)

Regards,
Sergio
