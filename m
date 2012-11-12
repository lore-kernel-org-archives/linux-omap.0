From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V3 00/13] ARM: OMAP: DMTIMER fixes
Date: Mon, 12 Nov 2012 12:34:41 -0800
Message-ID: <20121112203440.GL6801@atomide.com>
References: <1352744444-2633-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:22141 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752998Ab2KLUeo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Nov 2012 15:34:44 -0500
Content-Disposition: inline
In-Reply-To: <1352744444-2633-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [121112 10:22]:
> This series includes several fixes for the OMAP DMTIMER driver. This is
> based upon Tony Lindgren's current master branch [1].

You should be able to use omap-for-v3.8/dt as the base now with
the cleanup merged there. The master branch is just a merge of the
various topic branches, and can't be used as a base for pull requests.

Regards,

Tony

> [1] http://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
