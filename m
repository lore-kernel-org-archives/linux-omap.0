From: Tony Lindgren <tony@atomide.com>
Subject: Re: patch "phy: Add a driver for dm816x USB PHY" added to linux-phy
 tree
Date: Thu, 26 Mar 2015 09:04:17 -0700
Message-ID: <20150326160416.GG31346@atomide.com>
References: <20150325233606.GA7549@a0393678ub>
 <CAALWOA9ZHM6S+7WUffu0LF=9=fEO+PxfERpu=D9JpAbKSo1yNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:40019 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846AbbCZQIh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Mar 2015 12:08:37 -0400
Content-Disposition: inline
In-Reply-To: <CAALWOA9ZHM6S+7WUffu0LF=9=fEO+PxfERpu=D9JpAbKSo1yNA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, Brian Hutchinson <b.hutchman@gmail.com>, Bin Liu <binmlist@gmail.com>, pebolle@tiscali.nl, rusty@rustcorp.com.au, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Matthijs van Duin <matthijsvanduin@gmail.com> [150326 00:02]:
> On 26 March 2015 at 00:36, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> > Let me know if you find any problems with this patch.
> 
> I spotted a minor issue in drivers/phy/Kconfig:
> 
> > +         Enable this for dm81xx USB to work.
> 
> This should say dm816x instead.

Yes that's correct, the phy on dm814x seems to be like on am335x,
not like on dm816x. Kishon, let me know if you prefer a follow-up
patch to fix this.

I'm not seeing the original mail for this thread anywhere for some
reason BTW. It does not seem to be in the mailing list archives
either, well at least not yet.

Regards,

Tony
