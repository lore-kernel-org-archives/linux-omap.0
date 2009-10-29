From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/3] omap3evm: musb: Update power capability for
 OMAP3EVM (Rev >= E)
Date: Thu, 29 Oct 2009 20:12:31 +0200
Message-ID: <20091029181231.GA8726@nokia.com>
References: <1256742758-32702-3-git-send-email-ajay.gupta@ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C012AD6D86F@dlee02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0309C8627C@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940436EEAF1F@dbde02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C012AD6DBEA@dlee02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940436EEAF59@dbde02.ent.ti.com>
 <20091029065838.GA27534@nokia.com>
 <19F8576C6E063C45BE387C64729E73940436EEAFAA@dbde02.ent.ti.com>
 <20091029092331.GB31472@nokia.com>
 <19F8576C6E063C45BE387C64729E73940436EEB054@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61141 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZJ2SM5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 14:12:57 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436EEB054@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>

On Thu, Oct 29, 2009 at 11:29:39AM +0100, ext Gupta, Ajay Kumar wrote:
> Hi,
> > On Thu, Oct 29, 2009 at 08:03:21AM +0100, ext Gupta, Ajay Kumar wrote:
> > > > I was thinking on adding a musb_hdrc_board_data which would group
> > > > board-specific data such as this one.
> > > >
> > > > Musb's init phase is quite messy as of today so we would need to clean
> > > > that up. Anyways, the main idea is:
> > > >
> > > > board will call usb_musb_init() with a musb_hdrc_board_data * as
> > > > parameter. usb-musb would still hold a static struct
> > > > musb_hdrc_platform_data for the (in our case) OMAP-specific init,
> > those
> > > > would be passed down to driver and init phase would be done as
> > > > following:
> > > >
> > > > musb_init()
> > > > 	-> musb_platform_init()
> > > > 		-> musb_board_init()
> > > >
> > > > we could also have board_ops and platform_ops structures for the
> > > > function pointers to be passed to musb_core.c Then all init could be
> > > > done there.
> > > >
> > > > What do you say ???
> > >
> > > This looks really good to isolate board specific settings. Do you have
> > any
> > > ready patch on this ?
> > 
> > no, currently I'm working on refactoring the otg support. I could work
> > on this after I finish otg refactoring unless you want to take this task
> > :-)
> 
> Sure, I will submit the first cut very soon.

We could discuss further off list about the design and implementation
details. Just drop a mail :-)

-- 
balbi
