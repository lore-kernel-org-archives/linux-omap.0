From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC][PATCH] omap3: Unify omap2_set_globals_3[43,6x]x functions
Date: Tue, 29 Jun 2010 15:24:45 -0700
Message-ID: <87mxudlbo2.fsf@deeprootsystems.com>
References: <1277843427-25596-1-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:52047 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab0F2Wqb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 18:46:31 -0400
Received: by pxi8 with SMTP id 8so94647pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 29 Jun 2010 15:46:31 -0700 (PDT)
In-Reply-To: <1277843427-25596-1-git-send-email-saaguirre@ti.com> (Sergio
	Aguirre's message of "Tue, 29 Jun 2010 15:30:27 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergio Aguirre <saaguirre@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Sergio Aguirre <saaguirre@ti.com> writes:

> The only difference between them is the physical address of the
> uart4 port, which is only present in 36xx chips.
>
> We don't really need to care about keeping these 2 functions, since
> the decision to use uart4 is more cleanly done later when we do have
> access to omap_revision variable.

Also, with the converion of UART to hwmod, there is no longer any need
for UART base addresses in the globals struct (they've been removed in
the work-in-progress conversion of UART.

> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

