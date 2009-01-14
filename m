From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: RE: [PATCHv3] OMAP: Fix McBSP spin_lock deadlock
Date: Wed, 14 Jan 2009 09:58:02 +0200
Message-ID: <1231919882.13843.166.camel@eenurkka-desktop>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:62465 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756798AbZANIA2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 03:00:28 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0E80FWv023538
	for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2009 10:00:25 +0200
Received: from [172.23.118.146] (ouped118146.nmp.nokia.com [172.23.118.146])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n0E80F6N018152
	for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2009 10:00:16 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Tested to work fine.


