From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH 1/1] DSPBRIDGE Fix for image autoload
Date: Thu, 12 Mar 2009 03:42:56 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0CFF51DBCE@dlee02.ent.ti.com>
References: <7A436F7769CA33409C6B44B358BFFF0CFF51DBC9@dlee02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02A8F2C078@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51583 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962AbZCLInF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 04:43:05 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2C8gx05017532
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 03:43:04 -0500
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2C8gxvW024795
	for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 03:42:59 -0500 (CDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A8F2C078@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

> -----Original Message-----
> From: Gupta, Ramesh
> Sent: Thursday, March 12, 2009 10:31 AM
> To: Menon, Nishanth; linux-omap@vger.kernel.org
> Cc: Kanigeri, Hari; Guzman Lugo, Fernando
> Subject: RE: [PATCH 1/1] DSPBRIDGE Fix for image autoload
> 
> >
> > > -----Original Message-----
> > > From: Menon, Nishanth
> > > Sent: Thursday, March 12, 2009 9:39 AM
> > > To: Gupta, Ramesh; linux-omap@vger.kernel.org
> > > Cc: Kanigeri, Hari; Guzman Lugo, Fernando
> > > Subject: RE: [PATCH 1/1] DSPBRIDGE Fix for image autoload
> > >
> > > > -----Original Message-----
> > > > From: Gupta, Ramesh
> > > > Sent: Thursday, March 12, 2009 8:01 AM
> > > > To: Menon, Nishanth; linux-omap@vger.kernel.org
> > > > Cc: Kanigeri, Hari; Guzman Lugo, Fernando
> > > > Subject: RE: [PATCH 1/1] DSPBRIDGE Fix for image autoload
> > > >
> > > > I have tried this on linux-omap pm branch . This can be
> > applied on
> > > > top
> > > of
> > > > my DVFS
> > > > Patches earlier.
> > > >
> > > Your patch does not apply clean :(
> > > $ wget -O ramesh.auto.patch "http://marc.info/?l=linux-
> > > omap&m=123683598308417&q=raw"
> > > $ vim ramesh.auto.patch (edited to remove the linux-omap trailer) $
> > > patch -p1<./ramesh.auto.patch --dry-run patching file
> > > drivers/dsp/bridge/rmgr/drv_interface.c
> > > Hunk #1 succeeded at 400 (offset -5 lines).
> > > Hunk #2 succeeded at 408 (offset -5 lines).
> > > Hunk #3 succeeded at 450 with fuzz 1 (offset -5 lines).
> > > Hunk #4 succeeded at 470 (offset -5 lines).
> > > Hunk #5 succeeded at 655 (offset -5 lines).
> > >
> > > Could you rebase your patch against the following:
> > > git clone
> > > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-
> > > 2.6.git
> > > cd linux-omap-2.6.git
> > > git checkout -b pm --track origin/pm
> > > git fetch git://gitorious.org/lk/mainline.git
> > > tidspbridge-pm:tidspbridge- pm git checkout tidspbridge-pm
> > git merge
> > > pm
> >
> >
> > And the patch does not work :(
> 
> What is your code base? It does work for me.

As stated above:
git clone git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
cd linux-omap-2.6.git
git checkout -b pm --track origin/pm
git fetch git://gitorious.org/lk/mainline.gittidspbridge-pm:tidspbridge- pm git checkout tidspbridge-pm
git merge pm

Regards,
Nishanth Menon
