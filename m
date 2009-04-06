From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: i2c_omap: arbitration lost
Date: Mon, 6 Apr 2009 17:52:53 -0500
Message-ID: <A24693684029E5489D1D202277BE89442EB826FE@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE89442EB826D3@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56331 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbZDFWxB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 18:53:01 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n36MqtCI008880
	for <linux-omap@vger.kernel.org>; Mon, 6 Apr 2009 17:53:00 -0500
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n36MqtKB001949
	for <linux-omap@vger.kernel.org>; Mon, 6 Apr 2009 17:52:55 -0500 (CDT)
In-Reply-To: <A24693684029E5489D1D202277BE89442EB826D3@dlee02.ent.ti.com>
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
> Hi,
> 
> While attempting to rebase my patches against latest l-o commit, I got
> this message during bootup:
> 
> <3>i2c_omap i2c_omap.2: Arbitration lost
> i2c_omap i2c_omap.2: Arbitration lost
> <3>ov3640 2-003c: read from offset 0x300b error -5
> ov3640 2-003c: read from offset 0x300b error -5
> <3>ov3640 2-003c: Unable to detect sensor, err -19
> ov3640 2-003c: Unable to detect sensor, err -19
> 
> Is anybody else having the same problem?

BTW, I forgot to mention I'm testing with a SDP3430-VG9.0.0 board with ES3.1 silicon and TWL5030 power chip.

> 
> Regards,
> Sergio
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

