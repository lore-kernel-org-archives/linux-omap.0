From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/6] TI816X: Update common omap platform files
Date: Thu, 05 Aug 2010 07:28:12 -0700
Message-ID: <87pqxx2kxv.fsf@deeprootsystems.com>
References: <1280523096-25041-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62732 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756867Ab0HEO2P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Aug 2010 10:28:15 -0400
Received: by pwj7 with SMTP id 7so81416pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 05 Aug 2010 07:28:15 -0700 (PDT)
In-Reply-To: <1280523096-25041-1-git-send-email-hemantp@ti.com> (Hemant
	Pedanekar's message of "Sat, 31 Jul 2010 02:21:36 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Hemant Pedanekar <hemantp@ti.com> writes:

> This patch updates the common platform files with TI816X specific additions.
>
> Also adds new files for TI816X modules base addresseses and irq definitions.
>
> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>

General question on the static mapping of the L4_SLOW area.  It would
help if you comment on why this region should be statically mapped.
The mapping is not used in this series, so it's hard to judge here whether
it could be mapped dynamically.

Kevin
