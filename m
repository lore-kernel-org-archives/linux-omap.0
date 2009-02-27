From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Subject: OTG MUSB driver issue?
Date: Fri, 27 Feb 2009 18:52:38 +0100
Message-ID: <ac9c93b10902270952w37660667pece3640b0ba46ffc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f178.google.com ([209.85.218.178]:64944 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756569AbZB0Rwn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2009 12:52:43 -0500
Received: by bwz26 with SMTP id 26so1135618bwz.37
        for <linux-omap@vger.kernel.org>; Fri, 27 Feb 2009 09:52:38 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, beagleboard@googlegroups.com

Hi,

Several times I encountered issues with devices connected to the
beagle board's OTG port (through a powered hub).
(kernel 2.6.28-omap1).
Today this happened again and I was lucky enough to be able to find
the symptoms.

Scenario: I had a file on a USB hard disk. This file was copied to an
SD card. After copying the file was corrupted.
Removing the card and hard disk and connecting them to my linux box
allowed me to compare the SD and hard disk version (using cmp -l).
There were differences on four places. Each difference was 4 bytes (32
bits) and occurred on a 4 byte boundary.

I have no idea what causes it, but I strongly suspect the MUSB driver.
A hauppauge usb tv card also does not work when connected to the hub,
whereas the same card works without problem on a linksys NSLU2 (which
also has an arm processor).

Anyone suggestions? Patches ??

Frans.
