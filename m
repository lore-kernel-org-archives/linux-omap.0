From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap-serial: add RS485 mode support
Date: Thu, 10 Nov 2011 10:39:06 -0800
Message-ID: <87y5vnesad.fsf@ti.com>
References: <1317587234-20619-1-git-send-email-yanok@emcraft.com>
	<4EB9C749.5010601@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:57503 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754343Ab1KJSon (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Nov 2011 13:44:43 -0500
Received: by qadb12 with SMTP id b12so1172692qad.9
        for <linux-omap@vger.kernel.org>; Thu, 10 Nov 2011 10:44:42 -0800 (PST)
In-Reply-To: <4EB9C749.5010601@emcraft.com> (Ilya Yanok's message of "Wed, 09
	Nov 2011 04:20:25 +0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org

Ilya Yanok <yanok@emcraft.com> writes:

> Hi guys,
>
> any comments on this? Is anybody interested?

There's a major cleanup of the OMAP UART driver in progress[1].  I
suggest you rebase on top of that, or hold onto this until the cleanup
is merged.

Kevin

[1] http://marc.info/?l=linux-omap&m=131914563820506&w=2
