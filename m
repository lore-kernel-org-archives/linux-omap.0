From: kshen <kshen@cisco.com>
Subject: OMAP camera port connected to Davinci VPIF port
Date: Fri, 16 Apr 2010 15:00:36 -0700
Message-ID: <C7EE2C14.2B621%kshen@cisco.com>
References: <4BC8BA17.5060200@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sj-iport-6.cisco.com ([171.71.176.117]:39227 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757854Ab0DPWAh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 18:00:37 -0400
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com [171.70.151.144])
	by sj-core-5.cisco.com (8.13.8/8.14.3) with ESMTP id o3GM0ae0024970
	for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 22:00:37 GMT
In-Reply-To: <4BC8BA17.5060200@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP Linux discussion <linux-omap@vger.kernel.org>

Hi,

On a board I'm working on, it has the OMAP 3530's camera port connected to
the Davinci DM6467's VPIF port. The Davince is supposed to send BT656 stream
over this link to OMAP. How to get the OMAP camera driver to work in this
situation?

In kernel config, I set the CONFIG_VIDEO_OMAP3_CAM=yes option. I saw that
omap34xxcam.c got compiled and the omap34xxcam device got probed during boot
up. But I don't get a /dev/video0 node.

Do I need to write a specific driver for the Davinci VPIF interface? What
else do I need to do?

Thanks,
Ke

