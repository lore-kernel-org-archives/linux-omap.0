From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5 v2] omap2/3/4: serial fixes
Date: Wed, 7 Jul 2010 12:54:10 +0300
Message-ID: <20100707095409.GE1920@atomide.com>
References: <1277266674-5906-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51741 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab0GGJyP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 05:54:15 -0400
Content-Disposition: inline
In-Reply-To: <1277266674-5906-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Deepak K <deepak.k@ti.com>, Govindraj R <govindraj.raja@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.com>

Hi,

* Nishanth Menon <nm@ti.com> [100623 07:12]:
> V1:
> http://marc.info/?l=linux-omap&m=127074926903371&w=2
> 
> The patch for Errata i202 went through a series of discussions
> ending in
> V3:
> http://marc.info/?l=linux-omap&m=127109794814030&w=2
> 
> This series introduces an errata variable, does a few sparse cleanups
> and provides fix for an new errata.

I've added these to devel-serial-errata branch with some minor
cosmetic edits. Left out the obvious Cc for people that we know
are reading the mailing lists, then left out the link for the
first patch, and moved the link in the last patch at the end
of the commit message.

Will repost shortly after some tests so they get reviewed also
on LAKML.

Regards,

Tony
