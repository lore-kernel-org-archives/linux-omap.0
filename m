From: Tony Lindgren <tony@atomide.com>
Subject: Re: Enabling MUSB support
Date: Tue, 2 Sep 2008 15:37:36 -0700
Message-ID: <20080902223736.GI23085@atomide.com>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com> <20080827133825.GC7354@gandalf.research.nokia.com> <200808272354.28531.david-b@pacbell.net> <21722675-22F7-43A5-83A6-B426B092CC89@student.utwente.nl> <5A47E75E594F054BAF48C5E4FC4B92AB02C40F5BE2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62366 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbYIBWhk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 18:37:40 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C40F5BE2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

* Gadiyar, Anand <gadiyar@ti.com> [080828 01:04]:
> > Op 28 aug 2008, om 08:54 heeft David Brownell het volgende geschreven:
> > > p.s. FWIW my beagle identifies itself as 3430 ES2.2
> > >     not as 3530.
> > 
> > You sadly can't detect the cpu revision in software (es2.2 doesn't  
> > exist for 3530 afaik), see the threads on linux-omap about 
> > adding that info to KConfig.
> 
> Or for 3430 afaik.

Oops, sorry I should have replied here instead. We can do it from
board-*.c files with omap2_set_globals_xxxx().

Tony
