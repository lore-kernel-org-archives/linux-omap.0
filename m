From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] OMAP3: Lock DPLL5 at boot
Date: Wed, 9 Sep 2009 22:03:29 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309C861AF@dbde02.ent.ti.com>
References: <1252418056-5994-1-git-send-email-gadiyar@ti.com>
 <alpine.DEB.2.00.0909090939420.8657@utopia.booyaka.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F9C307DD@dbde02.ent.ti.com>,<alpine.DEB.2.00.0909091022560.8657@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37740 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbZIIQdf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Sep 2009 12:33:35 -0400
In-Reply-To: <alpine.DEB.2.00.0909091022560.8657@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Wed, 9 Sep 2009, Paul Walmsley wrote:
> On Wed, 9 Sep 2009, Pandita, Vikram wrote:
> 
> > >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Paul
> > >Walmsley
> > >> $SUBJECT to reflect the change.
> > >
> > >Thanks for the changes, I will queue this in a for-next branch for .33.
> >
> > Is this for .33 or .32?
> 
> I think it might be a little late for .32.  If there is some crash or
> instability that this fixes, we could queue it up for .32-fixes ?
> 

Well, without this, there's no way the child clocks can be enabled correctly.

Possibly it qualifies as a bug-fix in clock framework?

Rajendra had created this patch quite a while ago and it has received
sufficient testing on various codebases - I guess we just missed sending
it out to l-o early enough.

- Anand

