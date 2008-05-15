From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Make N810 keyboard work with console
Date: Wed, 14 May 2008 21:01:17 -0700
Message-ID: <1210824079-22548-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56904 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbYEOEBZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 00:01:25 -0400
In-Reply-To: n810-keyboard
References: n810-keyboard
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: daniel.stone@nokia.com, Tony Lindgren <tony@atomide.com>

Hi all,

Here are few fun patches for N810 hackers to make the integrated
keyboard work with console :) This should be done in a generic way
and the old behaviour is preserved if optional sticky keys are not
passed from platform_data.

Seems to also work nicely with xserver-xorg-video-fbdev.

Regards,

Tony

