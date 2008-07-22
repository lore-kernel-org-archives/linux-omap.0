From: "Rangasamy, Devaraj" <dev@ti.com>
Subject: RE: OMAP3 SYS_OFF_MODE support
Date: Tue, 22 Jul 2008 19:56:10 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB022C16CEAF@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB5930111C4FD8A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:36572 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615AbYGVO0W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jul 2008 10:26:22 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930111C4FD8A@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "TK, Pratheesh Gangadhar" <pratheesh@ti.com>, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Currently sr_configure_vc() is the only dedicated API to configure Voltage controller parameter. But still SYSOFF specific configuration shall be moved to prcm init.

Regards,
Deva

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of TK, Pratheesh Gangadhar
Sent: Tuesday, July 22, 2008 5:36 PM
To: Peter 'p2' De Schrijver; linux-omap@vger.kernel.org
Subject: RE: OMAP3 SYS_OFF_MODE support

I am just wondering why these changes are present in smartreflex.c. These should be initialized during prcm init or PMIC init (if there are parameters dependent on PMIC) ideally. I can't think of any dependency between smartreflex and SYS_OFF_MODE feature.

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Peter 'p2' De Schrijver
Sent: Monday, July 21, 2008 9:47 PM
To: linux-omap@vger.kernel.org
Subject: RFC: OMAP3 SYS_OFF_MODE support


The following patch set introduces support for the OMAP3 SYS_OFF_MODE
signal. This will cause a properly programmed triton2 to shutdown the
VDD1 and VDD2 regulators when both core and MPU powerdomain are in off
state. The patches includes programming triton2 with the appropriate
scripts for the SDP3430 board.
By default the OMAP3 polarity of the SYS_OFF_MODE signal is inverted
compared to what triton2 expects. This means the polarity needs to be
changed before the triton2 scripts are activated, otherwise the system
will crash. At the moment this is done in omap2_clk_init as this
function is called before triton2 is initialized. Better suggestions are
welcome.
Thanks to Kalle Jokiniemi for doing the initial patch and test work.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
