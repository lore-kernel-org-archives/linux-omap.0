From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/10] Rearranging things before sending patches to mainline
Date: Wed, 12 Mar 2008 12:45:40 +0200
Message-ID: <1205318750-9596-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65455 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbYCLKp7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2008 06:45:59 -0400
In-Reply-To: 34xx-2008-03-12
References: 34xx-2008-03-12
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Hi all,

Attached series moves things around a bit to make room for 34xx PM,
renames some files to have consistent naming, and moves STI support
from plat-omap to drivers/misc.

This is all to allow us to get arch/arm/*omap* stuff in sync with
mainline. I'll be putting together a series of patches for Russell
over next few days for post 2.6.25.

Regards,

Tony
