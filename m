From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: dpll4_ck rate broken
Date: Fri, 17 Oct 2008 14:08:28 +0300
Message-ID: <1224241708.19051.6.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55129 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbYJQLIi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 07:08:38 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9HB8CGR011105
	for <linux-omap@vger.kernel.org>; Fri, 17 Oct 2008 14:08:35 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

Hi,

With latest linux-omap kernel, the dpll4_ck rate is a bit funny:

~ # cat /debug/clock/virt_26m_ck/osc_sys_ck/sys_ck/rate 
13000000

~ # cat /debug/clock/virt_26m_ck/osc_sys_ck/sys_ck/dpll4_ck/rate 
3224773576

~ #
cat /debug/clock/virt_26m_ck/osc_sys_ck/sys_ck/dpll4_ck/dpll4_m4_ck/rate 
48000000

I've tested this on OMAP3 SDP board and one other board.

 Tomi


