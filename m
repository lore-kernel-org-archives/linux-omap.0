From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 0/1] input: lm8323: setting correct value to size_y
Date: Sat, 24 Oct 2009 16:18:21 -0400
Message-ID: <4AE3610D.9060102@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:59549 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbZJXUS2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Oct 2009 16:18:28 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9OKIVEs025773
	for <linux-omap@vger.kernel.org>; Sat, 24 Oct 2009 15:18:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Balbi and folks,

Regarding the N810 keyboard problem on 2.6.29-omap1 discussed some
months ago [1], I was checking it out and as mentioned by Luke, platform
parameter size_y must be set to 12 (instead of 8).

Therefore, there's no need of changing calculation of keysize on lm8323
driver.

This patch must be applied against linux-omap tree v2.6.29-omap1 (commit
58cf2f1425abfd3a449f9fe985e48be2d2555022). It boots N810 fine and
keyboard works properly.

BR,

Carlos.

[1] http://marc.info/?t=124432522800002&r=1&w=2

-- 
Carlos Eduardo Aguiar
Software Developer
Mobile Linux Software
Nokia Institute of Technology - INdT
E-mail: carlos.aguiar@indt.org.br

