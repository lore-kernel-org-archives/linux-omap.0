From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] SDTI fixes
Date: Fri, 9 Jan 2009 14:14:28 +0200
Message-ID: <20090109121426.GN2536@atomide.com>
References: <1231487553-17892-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56033 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbZAIMO2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 07:14:28 -0500
Content-Disposition: inline
In-Reply-To: <1231487553-17892-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jouni Hogander <jouni.hogander@nokia.com> [090109 09:53]:
> These patches fixes the problem with sdti-console, where it stops to
> work after PM is initialized.

Pushing to l-o tree.

Tony


> arch/arm/mach-omap2/clockdomains.h |    6 +++-
> arch/arm/mach-omap2/pm34xx.c       |   12 +++++++--
> drivers/misc/sti/sdti.c            |   48 ++++++++++++++++++++++++++++---------
> 3 files changed, 52 insertions(+), 14 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
