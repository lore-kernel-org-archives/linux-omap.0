From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: i2c_omap: arbitration lost
Date: Mon, 6 Apr 2009 17:34:00 -0500
Message-ID: <A24693684029E5489D1D202277BE89442EB826D3@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32811 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754267AbZDFWeI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 18:34:08 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n36MY1vL007950
	for <linux-omap@vger.kernel.org>; Mon, 6 Apr 2009 17:34:06 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n36MY1oS023573
	for <linux-omap@vger.kernel.org>; Mon, 6 Apr 2009 17:34:01 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

While attempting to rebase my patches against latest l-o commit, I got this message during bootup:

<3>i2c_omap i2c_omap.2: Arbitration lost
i2c_omap i2c_omap.2: Arbitration lost
<3>ov3640 2-003c: read from offset 0x300b error -5
ov3640 2-003c: read from offset 0x300b error -5
<3>ov3640 2-003c: Unable to detect sensor, err -19
ov3640 2-003c: Unable to detect sensor, err -19

Is anybody else having the same problem?

Regards,
Sergio
