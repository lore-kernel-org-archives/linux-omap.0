From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH v2 0/5] Mailbox: Fix some issues in mailbox module
Date: Tue, 23 Mar 2010 12:34:23 -0500
Message-ID: <4BA8FB9F.8080709@ti.com>
References: <496565EC904933469F292DDA3F1663E602CA2B9B29@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47220 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753613Ab0CWRee (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Mar 2010 13:34:34 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602CA2B9B29@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

On 2/18/2010 1:06 AM, Guzman Lugo, Fernando wrote:
>  From 79f2b477b19c49b36c51e8589c0a3d52ecd9ec99 Mon Sep 17 00:00:00 2001
> From: Fernando Guzman Lugo<x0095840@ti.com>
> Date: Thu, 18 Feb 2010 01:06:34 -0600
> Subject: [PATCH] Mailbox: Fix some issues in mailbox module
>
> This set of patches fix some issue I found when I was working
> with mailbox module.
>
> Fernando Guzman Lugo (4):
>    Mailbox: free mailbox interrupt before freeing blk queue
>    Mailbox: flush pending deferred works before freeing blk queue
>    Mailbox: Check valid registered callback before calling
>    Mailbox: disable mailbox interrupt when request queue
>
> Hiroshi DOYU (1):
>    Mailbox: new mutext lock for h/w mailbox configuration
>
>   arch/arm/plat-omap/mailbox.c |   29 ++++++++++++++++++++---------
>   1 files changed, 20 insertions(+), 9 deletions(-)
>

Cherry-picked until 2.6.34 rebase is available.

Pushed to dspbridge.

- omar
