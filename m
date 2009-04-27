From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [rft/rfc/patch-v2.6.29-rc5+ 00/23] ehci cleanup series
Date: Mon, 27 Apr 2009 12:18:00 +0300
Message-ID: <20090427091800.GA6624@scadufax.research.nokia.com>
References: <1235415335-17408-1-git-send-email-me@felipebalbi.com> <6ed0b2680904270218r4a3843bata8d18a352053b9ec@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28052 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbZD0JXe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Apr 2009 05:23:34 -0400
Content-Disposition: inline
In-Reply-To: <6ed0b2680904270218r4a3843bata8d18a352053b9ec@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: Felipe Balbi <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>

On Mon, Apr 27, 2009 at 11:18:32AM +0200, ext Grazvydas Ignotas wrote:
> On Mon, Feb 23, 2009 at 9:55 PM, Felipe Balbi <me@felipebalbi.com> wrote:
> > Hi all,
> >
> > Please give the following patches a good test. I don't have
> > hw to test them so any comments will be really welcome.
> >
> > We still have lots to do before getting this driver upstream,
> > let's try to keep track of our TODO list and get this driver in
> > mainline for 2.6.31 merge window (2.6.30 is too close already).
> >
> > Let's not try to push this driver until ES2.x and ES3.x are fully
> > supported, that will probably have to be done by an omap_rev
> > check in ehci-omap driver, also, this driver doesn't really
> > enumerate any attached devices, but that's old problem as Tony
> > told me off list.
> >
> > Anyways, I guess this driver is finally walking. Me and Anand (and anyone
> > interested) will be discussing how to get EHCI and OHCI working fine, I'm
> > guessing we won't have really big issues with OHCI but you never know.
> 
> Any news on this? Hope this hasn't been abandoned.

Quite busy with some nokia stuff, but I'll get back to this maybe next
week.

-- 
balbi
