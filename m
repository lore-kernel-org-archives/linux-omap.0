From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: Update DSS2 patches for latest kernel changes
Date: Wed, 04 Nov 2009 11:44:26 +0200
Message-ID: <1257327866.13331.41.camel@tubuntu.research.nokia.com>
References: <19F8576C6E063C45BE387C64729E73940436EEB692@dbde02.ent.ti.com>
	 <1257238471.13331.2.camel@tubuntu.research.nokia.com>
	 <19F8576C6E063C45BE387C64729E73940436EEB86B@dbde02.ent.ti.com>
	 <1257326713.13331.25.camel@tubuntu.research.nokia.com>
	 <1257327144.21596.96.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57161 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbZKDJor (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Nov 2009 04:44:47 -0500
In-Reply-To: <1257327144.21596.96.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "dedekind1@gmail.com" <dedekind1@gmail.com>
Cc: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2009-11-04 at 10:32 +0100, Artem Bityutskiy wrote:
> On Wed, 2009-11-04 at 11:25 +0200, Tomi Valkeinen wrote:
> > On Tue, 2009-11-03 at 10:02 +0100, ext Hiremath, Vaibhav wrote:
> > > > -----Original Message-----
> > > > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > 
> > > > Thanks, although I have already done that =). 
> > > [Hiremath, Vaibhav] I cross-checked your repository and could not find anything there, so I started rebasing it myself.
> > > 
> > > Anyway, please let me know once you are done with it.
> > 
> > I'm not done with it yet, but I pushed the current tree, based on
> > linux-next, to master-new branch in
> > git://gitorious.org/linux-omap-dss2/linux.git (Actually, it's still
> > pushing... Either gitorious or Nokia's proxies are really slow today).
> 
> A side note. I suggest you to send DSS2 once again for review to
> lkml/linux-omap. Even if you do not get comments, it is good to have
> just yet another "it was sent out here" reference, which you can put to
> your pull request later.

Yes, that's my plan. I just need to find time to test things first (and
fix those couple SDP problems), before posting it for review.

 Tomi


