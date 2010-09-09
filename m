From: Gary Thomas <gary@mlbassoc.com>
Subject: OMAP 3530 McBSP Frame Sync errors
Date: Thu, 09 Sep 2010 09:56:58 -0600
Message-ID: <4C8903CA.9090501@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:53379 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958Ab0IIQFZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Sep 2010 12:05:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I'm trying to use McBSP4 with an external CODEC which is a
slave device (i.e. the OMAP generates the Frame Sync pulses)
In this mode, the BSP is purely the master of these signals.

What can it possibly mean to get Frame Sync errors in this case
(I'm reading from the external CODEC)?

FYI, my registers look like this:
   PCR0: 0x00000f0f
   RCR1: 0x00000040, RCR2: 0x00008041
   XCR1: 0x00000040, XCR2: 0x00008041
   SRGR1: 0x00000f07, SRGR2: 0x0000101f

Any ideas or help?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
