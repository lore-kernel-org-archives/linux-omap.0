From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 00/17] OMAP3: Base support for VDD2 DVFS
Date: Fri,  9 Jan 2009 17:45:28 +0200
Message-ID: <1231515945-10234-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49099 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbZAIP41 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 10:56:27 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n09Ftwsg014214
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 17:56:24 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n09FtXjH003289
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 17:55:33 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Resending this set against the latest PM branch. This set provides base
SDRC + SRAM + clock framework support for VDD2 DVFS control. Main reasoning
for this set is that when VDD2 clock is changed, memory clocking changes also
and you need to be rather careful when you are doing this.


