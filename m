From: Bill Gatliff <bgat@billgatliff.com>
Subject: Anyone using an ISP1505?
Date: Thu, 17 Dec 2009 13:01:15 -0600
Message-ID: <4B2A7FFB.6090909@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f211.google.com ([209.85.217.211]:61048 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbZLQTBP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 14:01:15 -0500
Received: by gxk3 with SMTP id 3so1347010gxk.1
        for <linux-omap@vger.kernel.org>; Thu, 17 Dec 2009 11:01:13 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, beagleboard@googlegroups.com

Guys:


I'm working on an OMAP3530CUS board that uses an ISP1505 USB PHY, and I
haven't gotten much luck getting the kernel to recognize any USB
devices.  No luck, actually.  :)  My oscilloscope and the schematic say
that the hardware is wired up properly, I'm just wondering if anyone has
a similar configuration that's working for them--- and which kernel they
are using?

The only thing I'm a little concerned about is the possibility that the
"nop" transceiver isn't the right one for the ISP1505.  I have seen
patches floating around that claim to support the ISP1504, which should
be compatible with the 1505 if the datasheet is to be believed; but
those patches were in the context of i.MX3x machines, and they also
depended on a "slim framework for external transceivers" patch that
AFAICT hasn't been merged anywhere despite having been posted back in June.

Said patches can be found here:

http://kerneltrap.org/mailarchive/linux-usb/2009/6/10/5909543

Anyone have any ideas on how to pursue this, before I start chasing a
solution down myself?


Thanks!!


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

