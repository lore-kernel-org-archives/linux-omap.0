From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V2] PM: OPP: introduce function to free cpufreq table
Date: Wed, 25 May 2011 11:24:10 -0700
Message-ID: <8739k2wsdx.fsf@ti.com>
References: <1306309406-3299-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:51690 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752580Ab1EYSYQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 14:24:16 -0400
Received: by mail-iy0-f170.google.com with SMTP id 12so14195856iyb.1
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 11:24:15 -0700 (PDT)
In-Reply-To: <1306309406-3299-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Wed, 25 May 2011 00:43:26 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Todd <toddpoynor@google.com>, Rafael <rjw@sisk.pl>, linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> cpufreq table allocated by opp_init_cpufreq_table is better
> freed by OPP layer itself. This allows future modifications to
> the table handling to be transparent to the users.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>
