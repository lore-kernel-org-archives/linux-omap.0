From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/3] ARM:OMAP3: Enable SDRC workaround for ES3.1
Date: Tue, 31 Mar 2009 17:18:44 -0700
Message-ID: <878wmltee3.fsf@deeprootsystems.com>
References: <1238075941-24931-1-git-send-email-kalle.jokiniemi@digia.com>
	<1238075941-24931-2-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:13072 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765412AbZDAASy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2009 20:18:54 -0400
Received: by rv-out-0506.google.com with SMTP id f9so3291435rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 31 Mar 2009 17:18:52 -0700 (PDT)
In-Reply-To: <1238075941-24931-2-git-send-email-kalle.jokiniemi@digia.com> (Kalle Jokiniemi's message of "Thu\, 26 Mar 2009 15\:58\:59 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: linux-omap@vger.kernel.org

Kalle Jokiniemi <kalle.jokiniemi@digia.com> writes:

> Enable a workaround to manually restart the SDRC
> auto-refresh after wake-up from off mode also on
> ES3.1 silicon revision chips.
>
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

Thanks, pushing to PM branch.

Kevin

