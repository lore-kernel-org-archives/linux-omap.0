From: Maulik Mankad <x0082077@ti.com>
Subject: [PATCH v2 0/2] ARM : OMAP : Get rid of ifdef
Date: Mon,  4 Jan 2010 16:38:26 +0530
Message-ID: <1262603306-12918-1-git-send-email-x0082077@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53977 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752842Ab0ADLJL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jan 2010 06:09:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Maulik Mankad <x0082077@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, Olof Johansson <olof@lixom.net>, Sergei Shtylyov <sshtylyov@ru.mvista.com>

Hi,

Felipe,

Here is the Version 2 of the 2 patch series based 
on top of your for-tony branch at [1].

[1] git://gitorious.org/usb/usb.git for-tony

Maulik Mankad (2):
ARM : OMAP : Add empty functions in header file
ARM : OMAP : Remove #ifdef from board-omap3evm.c

The Version 2 of the patch set fixes the comments 
received for Version 1. 

The patches are compile tested and do not report
any checkpatch warnings.

Thanks,
Maulik

