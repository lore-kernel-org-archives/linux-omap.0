From: virtuoso@slind.org
Subject: [RFC] ETM/JTAG components states across OFF modes
Date: Sat,  1 May 2010 20:38:15 +0300
Message-ID: <1272735501-2963-1-git-send-email-virtuoso@slind.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58981 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab0EARk4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 13:40:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, r-woodruff2@ti.com

Hi,

I've finally got around to doing this. This is a rework of the previously
posted [1] patch that implements ETM and JTAG context saving. There are
two major changes since previous version:
  * coresight OS save/restore mechanism is used for saving the ETM context,
    so that it actually occupies ~54 words on omap3_arm_context instead of
    128;
  * a sysfs file is used to control if the ETM/JTAG context should be saved
    in OFF mode.

When this patchset is ready, it would have to be integrated though RMK (as
I understand it), but I'd like to first discuss it here.

[1]: https://patchwork.kernel.org/patch/72413/

Regards,
--
Alex
