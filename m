From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] omap: Add basic support for Pandora handheld console
Date: Sat, 18 Oct 2008 23:40:18 +0300
Message-ID: <20081018204015.GS31842@frodo>
References: <1224357743-23060-1-git-send-email-notasas@gmail.com> <20081018195518.GQ31842@frodo> <6ed0b2680810181319l6aa9f76co652a89778eefcdd1@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42834 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbYJRUkq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Oct 2008 16:40:46 -0400
Content-Disposition: inline
In-Reply-To: <6ed0b2680810181319l6aa9f76co652a89778eefcdd1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: me@felipebalbi.com, linux-omap@vger.kernel.org

On Sat, Oct 18, 2008 at 11:19:57PM +0300, Grazvydas Ignotas wrote:
> On Sat, Oct 18, 2008 at 10:55 PM, Felipe Balbi <me@felipebalbi.com> wrote:
> > On Sat, Oct 18, 2008 at 10:22:23PM +0300, Grazvydas Ignotas wrote:
> >> +     hsmmc_init();
> >> +     usb_musb_init();
> >> +     usb_ehci_init();
> >
> > Are you guys really using both ??
> >
> > do you have an otg port on pandora ??
> 
> Yup, we have both EHCI and OTG. See http://openpandora.ca/ . EHCI was
> functional several weeks back, now it locks up just like on beagle.
> Will resend soon with coding style changes..

cool :-)

I'll put my hands in that board when it comes out :-p

BTW, the EHCI stuff is regarding to a infinite loop without timeout.
Search the archives of linux-omap and you will find a simple workaround
;-)

-- 
balbi
