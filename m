From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 0/6] Mailbox: Fix some issues in mailbox module
Date: Mon, 15 Feb 2010 10:23:17 +0200 (EET)
Message-ID: <20100215.102317.235705601.Hiroshi.DOYU@nokia.com>
References: <496565EC904933469F292DDA3F1663E602AA7C18D5@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:22870 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab0BOIXg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 03:23:36 -0500
In-Reply-To: <496565EC904933469F292DDA3F1663E602AA7C18D5@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x0095840@ti.com
Cc: linux-omap@vger.kernel.org

Hi Fernando,

From: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 0/6] Mailbox: Fix some issues in mailbox module
Date: Sat, 13 Feb 2010 02:37:33 +0100

> From a7b162f3af04bbfa39c439c47b8499962410a9c9 Mon Sep 17 00:00:00 2001
> From: Fernando Guzman Lugo <x0095840@ti.com>
> Date: Fri, 12 Feb 2010 19:35:05 -0600
> Subject: [PATCH 0/6] Mailbox: Fix some issues in mailbox module
> 
> This set of patches fix some issue I found when I was working
> with mailbox module.
> 
> Fernando Guzman Lugo (6):
>   Mailbox: free mailbox interrupt before freeing blk queue
>   Mailbox: flush pending deferred works before freeing blk queue
>   Mailbox: change mailbox version print to pr_debug
>   Mailbox: Check valid registered callback before calling
>   Mailbox: sleeping function called from invalid context fix
>   Mailbox: disable mailbox interrupt when request queue

Thank you for patches. They almost look ok, but I'd like to spend time
on patch 5/6 a bit.

   Hiroshi DOYU

