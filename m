From: Ameya Palande <ameya.palande@nokia.com>
Subject: CONFIG_CPU_IDLE broken for N900
Date: Tue, 10 Aug 2010 15:21:31 +0300
Message-ID: <1281442891.17541.26.camel@chotu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36943 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755620Ab0HJMWG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 08:22:06 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o7ACLd5C016599
	for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 15:22:04 +0300
Received: from [172.21.22.240] (helruo-dhcp022240.ntc.nokia.com [172.21.22.240])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o7ACLUaV006724
	for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 15:21:30 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

When I enable CONFIG_CPU_IDLE and boot kernel, it hangs around the point
when it switches to user space. I am able to reproduce this for 2.6.35
on linux-omap and linux-2.6 trees.

Has anyone else noticed the same thing for omap3 based boards?

Cheers,
Ameya.

