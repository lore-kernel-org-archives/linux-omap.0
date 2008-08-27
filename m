From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 0/4] Misc PM patches for 34xx
Date: Wed, 27 Aug 2008 18:45:58 +0300
Message-ID: <1219851962-28972-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63465 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757929AbYH0NyH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2008 09:54:07 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7RDraY7015133
	for <linux-omap@vger.kernel.org>; Wed, 27 Aug 2008 16:54:04 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m7RDrqmm020594
	for <linux-omap@vger.kernel.org>; Wed, 27 Aug 2008 16:53:52 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

Here are a few PM patches for omap34xx. First two are important to get dynamic
idle and suspend to work in generic cases where we have enabled some gpio:s
and/or UART:s. These patches add dynamic clock handling for these. Dynamic
clock handling is enabled via sysfs entries under /sys/power/.

The last two are debugging related patches, they add support for PM debug
for omap34xx and add some state control functionality to PM, like possibility
to manually force some powerdomains to specific states, and to control the
target powerdomain states for suspend. Entries to control these features
are added under debug filesystem and /sys/power/.

The last two patches are more like nice to have at this point, if there
are some issues with these, please check the first two patches first and
integrate those if possible.

-Tero


