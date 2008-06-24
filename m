From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH 0/1] ARM: OMAP: SmartReflex driver: enable in
	omap_3430sdp_defconfig
Date: Tue, 24 Jun 2008 09:41:34 +0300
Message-ID: <1214289694.6100.60.camel@kj-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:36935 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbYFXGkY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2008 02:40:24 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5O6eAx0017899
	for <linux-omap@vger.kernel.org>; Tue, 24 Jun 2008 09:40:21 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

Sending a patch to enable the SmartReflex driver by default in
omap_3430sdp_defconfig. Having the SmartReflex enabled removes the need
for "[PATCH 3/8] 34XX: PM: Workaround for missing smartreflex driver"
sent by Jouni H=C3=B6gander.

--
Kalle Jokiniemi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
