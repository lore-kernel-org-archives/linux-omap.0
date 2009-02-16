From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: [PATCH 0/2] OMAP: tsc2005: Configuration and stability changes
Date: Mon, 16 Feb 2009 15:49:29 +0200
Message-ID: <1234792171-4095-1-git-send-email-ext-phil.2.carmody@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32604 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795AbZBPNwa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Feb 2009 08:52:30 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1GDq21O007627
	for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2009 15:52:28 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ext-phil.2.carmody@nokia.com

I have attempted to separate what looked like it might be a painful big 
patch into two logically distinct smaller patches. Fortunately no lines
of code are touched by both patches, so it's possible to consider their
changes independently. 0001 is relative to the current master HEAD. 
 
Firstly, 0001 addresses changes in the structure of the driver and brings
the driver up to date with respect to TI's datasheet errata (March 2008),
but doesn't change the bahaviour of the state machine at all.

Secondly, 0002 modifies the state machine behavior for improved stability.
It uses PENDAV mode, rather than DAV mode, which provides a regular stream
of interrupts while the pen is down. In order to compensate for IRQs which
can't be handled synchronously, a saturating counting scheme is added, and 
if there are any IRQs that haven't yet been handled when an SPI read 
completes, or the pen-up timeout expires, then another SPI read is started.
For additional stability, the batch delay and pen-up timeout are increased
in order to limit the rate of the interrupts.



