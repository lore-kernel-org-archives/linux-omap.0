From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-pm] [PATCH ver. 3] PM: add synchronous runtime interface for interrupt handlers
Date: Thu, 25 Nov 2010 19:58:49 +0100
Message-ID: <201011251958.49249.oliver@neukum.org>
References: <Pine.LNX.4.44L0.1011251052010.22247-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:38495 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab0KYS6H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 13:58:07 -0500
In-Reply-To: <Pine.LNX.4.44L0.1011251052010.22247-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

Am Donnerstag, 25. November 2010, 16:52:39 schrieb Alan Stern:
> When a device is declared irq-safe in this way, the PM core increments
> the parent's usage count, so the parent will never be runtime
> suspended.  This prevents difficult situations in which an irq-safe
> device can't resume because it is forced to wait for its non-irq-safe
> parent.

Shouldn't you walk further up the tree if the parent itself is irq-safe?
It seems like a waste of power to not suspend a paren, that can be
woken in irq.

	Regards
		Oliver
