From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/1] mtd: omap: nand: Remove 0xFF's that prefixed
 16bit NAND commands
Date: Fri, 26 Oct 2012 11:07:53 -0700
Message-ID: <20121026180752.GO11908@atomide.com>
References: <20121019172457.GA7608@harvey-pc.matrox.com>
 <20121019174252.GA7831@harvey-pc.matrox.com>
 <20121026144915.GA3110@harvey-pc.matrox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:58100 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965824Ab2JZSHy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 14:07:54 -0400
Content-Disposition: inline
In-Reply-To: <20121026144915.GA3110@harvey-pc.matrox.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christopher Harvey <charvey@matrox.com>
Cc: linux-omap@vger.kernel.org

* Christopher Harvey <charvey@matrox.com> [121026 07:47]:
> On Fri, Oct 19, 2012 at 01:42:52PM -0400, Christopher Harvey wrote:
> > ---
> >  drivers/mtd/nand/omap2.c |   14 +++++++++-----
> >  1 files changed, 9 insertions(+), 5 deletions(-)
> 
> Ping?

Looks like you should cc also the MTD list to get more
comments.

Regards,

Tony
