From: "Douglass, Woody" <Woodrow.Douglass@QinetiQ-NA.com>
Subject: Msleep doesn't return!
Date: Tue, 27 Apr 2010 09:01:55 -0400
Message-ID: <D110E3281F2BF547AA3350B5D27DC101013F6011@stafqnaomail.qnao.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 65-125-11-136.dia.static.qwest.net ([65.125.11.136]:45381 "EHLO
	mailgateway02.qinetiq-na.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753012Ab0D0NWg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Apr 2010 09:22:36 -0400
Received: from stafqnaomail2.qnao.net (localhost [127.0.0.1])
	by mailgateway02.qinetiq-na.com (Spam & Virus Firewall) with ESMTP id F2CA2531D87
	for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 13:06:07 +0000 (GMT)
Received: from stafqnaomail2.qnao.net ([10.18.123.31]) by mailgateway02.qinetiq-na.com with ESMTP id WJfh8zcH249bt95S for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 13:06:07 +0000 (GMT)
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello all,

Not sure if this is the right place to ask this, but I have a bit of a
problem with the omap kernel.

I've added some patches to the 2.6.32-omap1 tag of the omap git tree to
support a custom board. When I try to boot, about 30% of the time, it
gets all the way to the prepare_namespace call (in init/do_mounts.c) and
then the msleep call there doesn't return. I've confirmed this by adding
printk statements before and after the msleep call, as well as with a
BDI3000 jtag probe.

Have any of you seen this issue? Do you have any suggestions of how I
can debug this further?

Thanks,
Woody


Confidentiality Note: The information contained in this message, and any attachments, may contain proprietary and/or privileged material. It is intended solely for the person or entity to which it is addressed. Any review, retransmission, dissemination, or taking of any action in reliance upon this information by persons or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and delete the material from any computer. 
