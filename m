From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 02/10 V4] omap3: pm: introduce opp accessor functions
Date: Sat, 19 Dec 2009 10:42:13 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912191038400.26767@utopia.booyaka.com>
References: <1260339435-20294-1-git-send-email-nm@ti.com> <1260339435-20294-2-git-send-email-nm@ti.com> <1260339435-20294-3-git-send-email-nm@ti.com> <87iqceo1hb.fsf@deeprootsystems.com> <4B21954A.7010305@ti.com> <87tyvxms0j.fsf@deeprootsystems.com>
 <7A436F7769CA33409C6B44B358BFFF0C012B9F4C3F@dlee02.ent.ti.com> <alpine.DEB.2.00.0912171738240.12561@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60174 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbZLSRmO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Dec 2009 12:42:14 -0500
In-Reply-To: <alpine.DEB.2.00.0912171738240.12561@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Dasgupta, Romit" <romit@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Aguirre, Sergio" <saaguirre@ti.com>, Tero Kristo <Tero.Kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Premi, Sanjeev" <premi@ti.com>

On Thu, 17 Dec 2009, Paul Walmsley wrote:

> Following are some comments on your OPP code (revision five).
> 
> While preparing them, I put together some experimental patches to
> verify that the comments resulted in cleaner code.  They will be sent
> as separate messages.  You might find them useful.  If so, you're
> welcome to integrate them to your code.

Just wanted to clarify that the patches only implement a subset of the 
comments from this mail - mostly just the items that I wasn't sure how 
they would turn out.


- Paul
