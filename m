From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 10/18] OMAP4: clock data: Remove UNIPRO clock nodes
Date: Wed, 6 Jul 2011 01:00:05 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107060059330.4217@utopia.booyaka.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com> <1309552901-8944-11-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36437 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab1GFHAG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 03:00:06 -0400
In-Reply-To: <1309552901-8944-11-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> From: Jon Hunter <jon-hunter@ti.com>
> 
> UNIPRO was removed from OMAP4 devices from ES2.0 onwards.
> Since this IP was anyway non-functional and not supported,
> it is best to remove it completely.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> [b-cousson@ti.com: Update the changelog]
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

The PRCM data changes in this patch have been separated from the clock
data changes.  The PRCM data changes have been queued for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'prcm_cleanup_a_3.1' branch.
The clock data changes have been queued for 3.1 at
git://git.pwsan.com/linux-2.6 in the 'clock_cleanup_a_3.1' branch.

Thanks,

- Paul
