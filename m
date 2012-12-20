From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v2] ARM: OMAP2: hwmod: Fix "register offset NULL check"
 bug
Date: Thu, 20 Dec 2012 07:35:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212200734160.7362@utopia.booyaka.com>
References: <1355835378-23437-1-git-send-email-gururaja.hebbar@ti.com> <alpine.DEB.2.00.1212190210021.2446@utopia.booyaka.com> <1BAFE6F6C881BF42822005164F1491C33EB0C4FB@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48142 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab2LTHf2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Dec 2012 02:35:28 -0500
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EB0C4FB@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>

On Thu, 20 Dec 2012, Hebbar, Gururaja wrote:

> On Wed, Dec 19, 2012 at 07:43:50, Paul Walmsley wrote:
> 
> > We've got a few hwmods on OMAP44xx that don't have clkctrl_offs registers 
> > listed in the hwmod data, and which are not marked with HWMOD_NO_IDLEST.  
> > What's going to happen in those cases?
> 
> Hmm. This is a special case to me. Let me go back and do some review.
> Will be back with some more details.

Probably what needs to happen is that those hwmods need to be marked with 
HWMOD_NO_IDLEST, in a separate patch before yours.  As far as I can tell, 
that's how they should have been marked initially.  Then your patch should 
be fine.

- Paul
