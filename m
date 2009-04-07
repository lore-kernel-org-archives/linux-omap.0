From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: i2c_omap: arbitration lost
Date: Tue, 7 Apr 2009 06:02:03 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFED9AE34@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE89442EB826D3@dlee02.ent.ti.com>,<A24693684029E5489D1D202277BE89442EB826FE@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33664 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750731AbZDGLEX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Apr 2009 07:04:23 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n37B4H9B007716
	for <linux-omap@vger.kernel.org>; Tue, 7 Apr 2009 06:04:22 -0500
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id n37B4GJn014325
	for <linux-omap@vger.kernel.org>; Tue, 7 Apr 2009 06:04:16 -0500 (CDT)
In-Reply-To: <A24693684029E5489D1D202277BE89442EB826FE@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Aguirre Rodriguez, Sergio Alberto
> Sent: Monday, April 06, 2009 5:34 PM
> To: linux-omap@vger.kernel.org
> Subject: i2c_omap: arbitration lost
>
> <3>i2c_omap i2c_omap.2: Arbitration lost
> i2c_omap i2c_omap.2: Arbitration lost
> <3>ov3640 2-003c: read from offset 0x300b error -5
> ov3640 2-003c: read from offset 0x300b error -5
> <3>ov3640 2-003c: Unable to detect sensor, err -19
> ov3640 2-003c: Unable to detect sensor, err -19
>
> Is anybody else having the same problem?
Do you see i2c errors during twl5030 operations? did you try enable i2c-dev and try some i2cdev access to other devices? Arbitration Lost happens only in a multi-master scenario -> two masters (OMAP and someone else) trying to talk on the bus at the same time - so did you try some platform like SDP3430-VG5.0 or so..
Regards,
Nishanth Menon