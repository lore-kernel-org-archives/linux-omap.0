From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 08/10] [PM-WIP-MMC] OMAP MMC: Register offset handling
Date: Thu, 26 Aug 2010 16:22:03 -0700
Message-ID: <8739u1vu1w.fsf@deeprootsystems.com>
References: <16162.10.24.255.18.1282335070.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50562 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317Ab0HZXWI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 19:22:08 -0400
Received: by ywh1 with SMTP id 1so563018ywh.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Aug 2010 16:22:07 -0700 (PDT)
In-Reply-To: <16162.10.24.255.18.1282335070.squirrel@dbdmail.itg.ti.com>
	(kishore kadiyala's message of "Sat, 21 Aug 2010 01:41:10 +0530
	(IST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, adrian.hunter@nokia.com, akpm@linux-foundation.org, madhu.cr@ti.com

"kishore kadiyala" <kishore.kadiyala@ti.com> writes:

> Since OMAP4 has added new set of registers , this patch adds
> different array's for OMAP3 and OMAP4 and choose the right one
> during run time.Newly added registers are updated at the bottom
> of array.
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Adrian Hunter <adrian.hunter@nokia.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>

This one could go upstream independently of this series as it's not
directly related to the rest of the series.

Please post this one independently, and in the next rev of the rest of
the series, state the dependency on this patch.

Kevin
