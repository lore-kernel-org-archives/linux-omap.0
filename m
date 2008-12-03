From: Carlos Chinea <carlos.chinea@nokia.com>
Subject: [PATCH 2.6.28-rc6 0/1] Fix OMAP/README docummentation
Date: Wed, 03 Dec 2008 12:37:18 +0200
Message-ID: <1228300638.26377.124.camel@groo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:27069 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbYLCKjQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Dec 2008 05:39:16 -0500
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mB3Ad8kU013204
	for <linux-omap@vger.kernel.org>; Wed, 3 Dec 2008 12:39:14 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi !

The README file in the OMAP documentation has wrong and misleading
information about how the developers have to access the registers in
OMAP. The following patch removes completely that section.

Please, keep in mind that this does not imply that the rest of the
sections are currently OK. I guess someone with better expertise should
revise those sections.

Br,
Carlos 

