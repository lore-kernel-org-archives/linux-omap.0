From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] OMAP-GPMC generic timing migration
Date: Mon, 15 Oct 2012 09:01:55 -0700
Message-ID: <20121015160154.GB15569@atomide.com>
References: <cover.1349450723.git.afzal@ti.com>
 <5076B166.2020006@gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9FBC41@DBDE01.ent.ti.com>
 <20121011144756.GB12552@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9FCEC9@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20867 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753014Ab2JOQCC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 12:02:02 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9FCEC9@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: Daniel Mack <zonque@gmail.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hunter, Jon" <jon-hunter@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, David Woodhouse <David.Woodhouse@intel.com>

* Mohammed, Afzal <afzal@ti.com> [121015 05:42]:
> Hi Tony,
> 
> On Thu, Oct 11, 2012 at 20:17:56, Tony Lindgren wrote:
> > * Mohammed, Afzal <afzal@ti.com> [121011 05:48]:
> 
> > After -rc1 is out, let's plan on adding the minimal
> > set required for removing plat and mach includes from
> > drivers into a clean-up branch. Afzal, can you maybe
> > do a pull request for that set against -rc1 when it's
> > out? Just the minimal set of patches.
> 
> Pull request on gpmc cleanup for common ARM zImage has
> been sent.

Thanks.
 
> > Yes, then please do a second pull request for what's needed
> > to apply the minimal DT bindings. For the DT binding, let's
> > just leave out the timings for now as we can load those from
> > auxdata. Then the binding for the timings can be added
> > later on. So just the minimal binding using standard features
> > for the iorange and interrupt.
> 
> Ok, I will keep timings aside for now and proceed with DT
> (avoiding auxdata usage with generic routine looked to me a
> saner approach though, with an initial DT'fy delay)

Oh well if you think it's easier to do the timings too in
the DT binding, please go ahead with that. It may take some
longer discussion on the lists for the binding though. But
up to you.

Regards,

Tony
