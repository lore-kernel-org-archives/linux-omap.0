From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] ARM: OMAP: add corrected DSS regulator supplies
Date: Wed, 12 Jun 2013 07:05:21 -0700
Message-ID: <20130612140520.GT8164@atomide.com>
References: <1369985874-8571-1-git-send-email-tomi.valkeinen@ti.com>
 <51B84FA5.80409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34727 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab3FLOFY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jun 2013 10:05:24 -0400
Content-Disposition: inline
In-Reply-To: <51B84FA5.80409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [130612 03:44]:
> On 31/05/13 10:37, Tomi Valkeinen wrote:
> > Hi Tony,
> > 
> > Here are a few patches adding corrected DSS regulator supplies. The current
> > ones in the board files are not really correct, although the dss driver works
> > ok with them.
> > 
> > So these patches add new regulator supply entries. When these are merged, I'll
> > change omapdss driver to use the new ones, instead of the old ones. After that,
> > we can remove the old ones from the board files.
> > 
> > Note that these patches were also present in the big DSS series I sent
> > yesterday. There's no reason for these patches to be there, so I'm sending them
> > separately, and will drop these from my DSS series.
> 
> Ping.

Thanks, applying into omap-for-v.311/fixes-non-critical.

Regards,

Tony
