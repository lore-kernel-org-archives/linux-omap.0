From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv2 0/11] Misc fixes [for PM branch]
Date: Fri, 23 Oct 2009 19:03:44 +0300
Message-ID: <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19340 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbZJWQS0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 12:18:26 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9NGIQ7m027784
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 11:18:30 -0500
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9NGIPi4022176
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 19:18:26 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

This set is now missing following patches compared to the previous set:

- IVA2 suspend fix
- Dynamic check for core target state
- Block core off when DSS active
- Next state check for IVA2, USB and PER
- USBHOST powerdomain force to sleep after warm reset

Also removed one of the patches Kevin already applied.

I am still trying to figure out what to do with the remaining patches, but
I decided I would send this partial set which I have modified according to
comments already.

-Tero


