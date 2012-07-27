From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 2/8] ARM: OMAP3+: voltage/pwrdm/clkdm/clock add recursive usecount tracking
Date: Fri, 27 Jul 2012 12:14:59 -0700
Message-ID: <87k3xpj9sc.fsf@ti.com>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
	<1342189185-5306-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:36081 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751965Ab2G0TPC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jul 2012 15:15:02 -0400
Received: by pbbro8 with SMTP id ro8so5772080pbb.11
        for <linux-omap@vger.kernel.org>; Fri, 27 Jul 2012 12:15:01 -0700 (PDT)
In-Reply-To: <1342189185-5306-3-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Fri, 13 Jul 2012 17:19:39 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> This patch fixes the usecount tracking for omap3+, previously the
> usecount numbers were rather bogus and were not really useful for
> any purpose. Now usecount numbers track the number of really active
> clients on each domain. This patch also adds support for usecount
> tracking on powerdomain level and autoidle flag for clocks that
> are hardware controlled and should be skipped in usecount
> calculations.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>

Minor nit: please avoid using BUG_ON() which will panic the whole
kernel.  Proper error detection is preferred, but your usage, a
WARN_ON() should suffice.

Otherwise,

Reviewed-by: Kevin Hilman <khilman@ti.com>

Kevin
