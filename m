From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: i2c errors on omap3430sdp
Date: Mon, 29 Sep 2008 08:59:38 -0500
Message-ID: <A24693684029E5489D1D202277BE89441207F124@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39243 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819AbYI2N7p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 09:59:45 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m8TDxeaV021046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 29 Sep 2008 08:59:45 -0500
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m8TDxd8m008364
	for <linux-omap@vger.kernel.org>; Mon, 29 Sep 2008 08:59:39 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

I'm currently testing the OV3640 CSI2 camera implementation for 3430SDP, and I had it working some weeks ago.

Today I did a git pull from the master branch.

Without changing anything i2c related, I now sometimes get a message that I wasn't getting before:

i2c_omap i2c_omap.2: controller timed out waiting for start condition to finish
i2c_omap i2c_omap.2: controller timed out waiting for start condition to finish

Anyone is seeing this?

Any omap i2c registration changes that I could be missing?

Regards,
Sergio

