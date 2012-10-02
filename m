From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: SmartReflex: fix error path in init function
Date: Tue, 02 Oct 2012 14:59:05 -0700
Message-ID: <87vces7cye.fsf@deeprootsystems.com>
References: <1348152453-30532-1-git-send-email-j-pihet@ti.com>
	<1348496201-6378-1-git-send-email-j-pihet@ti.com>
	<1348496201-6378-2-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33730 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab2JBV7G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Oct 2012 17:59:06 -0400
Received: by pbbrr4 with SMTP id rr4so9186703pbb.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Oct 2012 14:59:05 -0700 (PDT)
In-Reply-To: <1348496201-6378-2-git-send-email-j-pihet@ti.com> (Jean Pihet's
	message of "Mon, 24 Sep 2012 16:16:40 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Anton Vorontsov <cbou@mail.ru>, J Keerthy <j-keerthy@ti.com>, Jean Pihet <j-pihet@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Fix the error handling path in omap_sr_probe to correctly
> de-allocate resources in case of problems.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Thanks, queuing this one as a fix for v3.7-rc

Kevin
