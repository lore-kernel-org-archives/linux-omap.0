From: "Mohammed, Afzal" <afzal@ti.com>
Subject: Reg pinmux driver for OMAP based SoC- AM335X
Date: Tue, 31 Jan 2012 14:35:38 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93176CAC6@DBDE01.ent.ti.com>
References: <20120124012038.GT22818@atomide.com>
 <74CDBE0F657A3D45AFBB94109FB122FF178CB81EDB@HQMAIL01.nvidia.com>
 <20120125000407.GU22818@atomide.com>
 <74CDBE0F657A3D45AFBB94109FB122FF178CB82433@HQMAIL01.nvidia.com>
 <20120127020832.GJ29812@atomide.com>
 <20120127065752.GB32740@S2101-09.ap.freescale.net>
 <20120127170545.GH13504@atomide.com>
 <20120130015607.GA10470@S2101-09.ap.freescale.net>
 <20120130172042.GE9339@atomide.com>
 <20120131013215.GB24681@S2101-09.ap.freescale.net>
 <20120131022906.GH9339@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57110 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab2AaOfq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 09:35:46 -0500
In-Reply-To: <20120131022906.GH9339@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>

Hi Tony,

I am working on implementing pincontrol driver for AM335X SoC (OMAP34XX family).

Is there any specific plan you have in mind w.r.t incorporating
pincontrol driver for OMAP family of SoC's. There was an initial patch
for OMAP4 pin control driver, but it seems you were in favour of a
DT based approach. As per my understanding after going through few threads
(lot more remaining) is that pincontrol driver can be either a DT based
or non-DT based (either way we are going out of platform folders), and
it seems you prefer a DT based approach (have seen mentioning about
pinmux-simple.c).

Tegra pincontrol driver posted recently, seems to use DT to distinguish only
the SoC type, with all the pincontrol information for SoC present in Kernel.

I would be thankful if you can give me some pointers on how to proceed for
AM335X pincontrol driver and/or any work in progress for OMAP pincontrol driver.

Regards
Afzal
