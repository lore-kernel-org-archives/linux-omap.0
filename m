From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 0/3] Support for OMAP3 Zoom2 board
Date: Wed, 13 May 2009 23:23:19 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F50018C7@dbde02.ent.ti.com>
References: <1241732526-6218-1-git-send-email-mlc@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53328 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754602AbZEMRx3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 13:53:29 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4DHrOC0026705
	for <linux-omap@vger.kernel.org>; Wed, 13 May 2009 12:53:30 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n4DHrNP5016312
	for <linux-omap@vger.kernel.org>; Wed, 13 May 2009 23:23:23 +0530 (IST)
In-Reply-To: <1241732526-6218-1-git-send-email-mlc@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Christensen, Mikkel" <mlc@ti.com>

Tony/All
 Any comments on Zoom2 support patches? 


>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>Christensen, Mikkel
>Sent: Thursday, May 07, 2009 4:42 PM
>To: linux-omap@vger.kernel.org
>Cc: Christensen, Mikkel
>Subject: [PATCH 0/3] Support for OMAP3 Zoom2 board
>
>The following patch series adds support for Zoom2 board.
>
>The board has:
> - Modem attached to UART1
> - WLAN attached to UART2
> - GPS attached to UART3
>
>An external debug board is included for console and LAN.
>
>For details refer to this site:
>http://www.logicpd.com/products/development-kits/texas-instruments-zoom%E2%84%A2-omap34x-ii-mdp
>
>Future work:
> - SMSC911x NFS mount problem
> - Low level debug uart need to use debug board
> - Dynamic detection of debug board presence
>
>TI wiki with FAQs on getting this board booting:
>https://omapzoom.org/gf/project/omapzoom/wiki/?pagename=GettingStartedWithZoomII_AKA_OMAP34XII_MDP
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

