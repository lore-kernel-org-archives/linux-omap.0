From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 04/14] ARM: OMAP2+: gpmc: minimal driver support
Date: Wed, 13 Jun 2012 05:07:17 -0700
Message-ID: <20120613120717.GP12766@atomide.com>
References: <cover.1339419492.git.afzal@ti.com>
 <54e643eb1b4dbefcbb52580fa582043bf4f0da3d.1339419492.git.afzal@ti.com>
 <4FD6586A.9060706@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997E2A@DBDE01.ent.ti.com>
 <4FD782F7.9010003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:35572 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586Ab2FMMHT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 08:07:19 -0400
Content-Disposition: inline
In-Reply-To: <4FD782F7.9010003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [120612 11:01]:
> 
> On 06/12/2012 02:16 AM, Mohammed, Afzal wrote:
> > Hi Jon,
> > 
> > On Tue, Jun 12, 2012 at 02:13:22, Hunter, Jon wrote:
> > 
> >>> +	gpmc_revision = (l >> 4) & 0xf;
> >>
> >> Why are you only storing the major part of the rev? Why not keep both parts?
> > 
> > Does having minor revision add any value ?, at least as of now,
> > I do not see any.
> 
> May be not but it does not hurt either.

Yeah might as well show the full revision.

Tony
