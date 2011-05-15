From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH 2/4] omap: igep0020: minor refactoring
Date: Sun, 15 May 2011 22:27:59 +0200
Message-ID: <201105152228.00408.arnd@arndb.de>
References: <cover.1305235542.git.mike@compulab.co.il> <201105132044.39163.arnd@arndb.de> <20110515185043.GA24785@gentoodev.compulab.local>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:63344 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158Ab1EOU2G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 May 2011 16:28:06 -0400
In-Reply-To: <20110515185043.GA24785@gentoodev.compulab.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mike@compulab.co.il
Cc: linux-arm-kernel@lists.infradead.org, Tony.Lindgren.tony@atomide.com, Enric Balletb??? i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org

On Sunday 15 May 2011, mike@compulab.co.il wrote:
> We can keep all the data structures that differ between IGEP2 and IGEP3.
> However, this significantly reduces the benifit of the series.
> There's already code in the IGEP2 that differentiates between HW
> revisions, so anyway the board support will require some work for
> devicetree transition. Eventually, when devicetree will be usable on
> OMAPs, most of the code currently found in arch/arm/mach-omap2/board*
> will require some work and I hardly believe that the transition can be
> automated...

True. Let's just use the version you posted then.

	Arnd
