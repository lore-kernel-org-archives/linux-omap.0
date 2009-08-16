From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: MUSB regression in 2.6.31-rc6
Date: Mon, 17 Aug 2009 00:52:42 +0300
Message-ID: <20090816215241.GA11964@gandalf>
References: <20090815174352.c2883585.jhnikula@gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0305398E07@dbde02.ent.ti.com>
 <20090815180701.7710de51.jhnikula@gmail.com>
 <20090815174000.GA13164@nokia.com>
 <20090816104415.e12a5e46.jhnikula@gmail.com>
 <19F8576C6E063C45BE387C64729E739404322AA35B@dbde02.ent.ti.com>
 <20090816131337.GA7634@gandalf>
 <20090816194953.8d96cdb7.jhnikula@gmail.com>
 <20090816171016.GB9923@gandalf>
 <20090816204345.0fa2fbf1.jhnikula@gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:53351 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755772AbZHPVxD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Aug 2009 17:53:03 -0400
Content-Disposition: inline
In-Reply-To: <20090816204345.0fa2fbf1.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: me@felipebalbi.com, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sun, Aug 16, 2009 at 08:43:45PM +0300, Jarkko Nikula wrote:
> On Sun, 16 Aug 2009 20:10:18 +0300
> Felipe Balbi <me@felipebalbi.com> wrote:
> 
> > how about checking whether twl4030_usb is probing fine ?
> > 
> Oh yes, looks like not. I didn't notice this before and didn't post the
> full log. Bad me, now included. See
> 
> <3>twl4030_usb twl4030_usb: ldo init failed

It looks like we're also missing ldo initialization on current
linux-omap. I'll cook a patch tomorrow for that, if you could help me
with testing, then I could send the full version to Greg for
integration.

-- 
balbi
