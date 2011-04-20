From: Paul Alfille <paul.alfille@gmail.com>
Subject: omap byte order error in w1 slave message
Date: Tue, 19 Apr 2011 20:21:49 -0400
Message-ID: <BANLkTi=SP0J6QfaeeadgmQnCtdqLdBF5aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43808 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab1DTAWK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Apr 2011 20:22:10 -0400
Received: by fxm17 with SMTP id 17so137819fxm.19
        for <linux-omap@vger.kernel.org>; Tue, 19 Apr 2011 17:22:09 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

After extensive testing, it's clear that the omap driver in
kernel/drivers/w1/masters/omap_hdq.c reports the slave address in
reversed byte order compared to all the other drivers.

This is in the netlink LIST_SLAVE message.

I've discovered this when testing support in OWFS --
one-wire-file-system (www.owfs.org) which is probably the most
comprehensive 1-wire support around.

I'd be glad to supply detailed information.

The sysfs report is correct, and the CRC8 is computed correctly. If I
just reverse the netlink slave addresses, everything functions well.

If it is not possible to correct the driver, my next alternative is to
always test the address forward and backward (the CRC8 will probably
work only in one direction) and compensate for the bug in that manner.

Paul Alfille
