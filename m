From: Paul Walmsley <paul@pwsan.com>
Subject: smc91x problems on 2430SDP
Date: Mon, 14 Dec 2009 13:55:13 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912141353270.12561@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35202 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757575AbZLNUzN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 15:55:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Hi,

smc91x is preventing 2430SDP from booting.  Messages follow at the end of 
this message.  Any ideas?


- Paul


smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@fluxnic.net>
eth%d: spurious interrupt (mask = 0x0b)
eth%d: spurious interrupt (mask = 0x0b)
eth%d: spurious interrupt (mask = 0x0b)
eth%d: spurious interrupt (mask = 0x0b)
eth%d: spurious interrupt (mask = 0x0b)
eth%d: spurious interrupt (mask = 0x0b)
eth%d: spurious interrupt (mask = 0x0b)
eth%d: spurious interrupt (mask = 0x0b)
eth%d: spurious interrupt (mask = 0x0b)
eth%d: spurious interrupt (mask = 0x0b)
eth%d: spurious interrupt (mask = 0x0b)
...
