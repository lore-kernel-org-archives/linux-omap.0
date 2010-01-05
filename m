From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 1/1] ARM: OMAP4: PM: Add check for avoiding dependency
 related update.
Date: Tue, 5 Jan 2010 16:09:51 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001051608340.21295@utopia.booyaka.com>
References: <1261583238-22187-1-git-send-email-abhijitpagare@ti.com> <alpine.DEB.2.00.0912300125320.24862@utopia.booyaka.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C02E919C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40771 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab0AEXJw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 18:09:52 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C02E919C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pagare, Abhijit" <abhijitpagare@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, 30 Dec 2009, Pagare, Abhijit wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Wednesday, December 30, 2009 2:02 PM
> 
> > But really, I'd rather not apply this patch.  The best way forward is to
> > apply a patch that adds the OMAP4 wakeup and sleep dependencies
> > themselves.  Have you had a chance to look at the series that I sent you a
> > few weeks ago off-list that reorganizes the wakeup and sleep dependencies
> > to determine if it is adequate for you to add the OMAP4 wakeup/sleep
> > dependencies afterwards?
> 
> I had a look at the dependency patches that you had sent to me earlier 
> and it seems feasible to add the OMAP4 related dependency data on top of 
> those patches. A small change exists but can be taken care of.

Great, I've just cleaned those up, rebased them, and posted them to the 
list.  If you prefer, you can also get from the 
'move_wkdeps_sleepdeps_to_clkdm' branch at git://git.pwsan.com/linux-2.6


- Paul
