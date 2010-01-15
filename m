From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: [PATCH 12/18] OMAP3 clock: split out DPLL3 M2 divider
 functions into clkt3xxx_dpll3m2.c
Date: Fri, 15 Jan 2010 14:50:14 +0200
Message-ID: <20100115125014.GK29059@shisha.kicks-ass.net>
References: <20100115090613.30690.49355.stgit@localhost.localdomain>
 <20100115090703.30690.171.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:41551 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932188Ab0AOMyr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 07:54:47 -0500
Content-Disposition: inline
In-Reply-To: <20100115090703.30690.171.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jouni =?utf-8?B?SMO2Z2FuZGVy?= <jouni.hogander@nokia.com>

On Fri, Jan 15, 2010 at 02:07:04 -0700, Paul Walmsley wrote:
> Split the DPLL3 M2 divider clock functions out of clock34xx.c and move them
> into clkt3xxx_dpll3m2.c to improve maintainability.

I'm not very familiar with maintainability issues of dpll3m2, so
forgive me if it is ignorant for me to ask you to elaborate on this.
It does look like a bit of an overkill to have a separate file for
a divider. But again, I might well be missing the point.

Regards,
--
Alex
