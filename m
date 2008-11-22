From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 2/3] omap mailbox: add initial omap3 support
Date: Sat, 22 Nov 2008 23:09:55 +0200 (EET)
Message-ID: <20081122.230955.212307567.Hiroshi.DOYU@nokia.com>
References: <1227313717-26399-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<1227313717-26399-2-git-send-email-Hiroshi.DOYU@nokia.com>
	<20081122115746.GC6289@frodo>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35103 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbYKVVKG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Nov 2008 16:10:06 -0500
In-Reply-To: <20081122115746.GC6289@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org

Hi Felipe,

From: "ext Felipe Balbi" <me@felipebalbi.com>
Subject: Re: [PATCH 2/3] omap mailbox: add initial omap3 support
Date: Sat, 22 Nov 2008 13:57:47 +0200

> On Sat, Nov 22, 2008 at 02:28:36AM +0200, Hiroshi DOYU wrote:
> > @@ -30,7 +30,7 @@
> >  #define MAILBOX_IRQ_NEWMSG(u)		(1 << (2 * (u)))
> >  #define MAILBOX_IRQ_NOTFULL(u)		(1 << (2 * (u) + 1))
> >  
> > -static unsigned long mbox_base;
> > +static void __iomem *mbox_base;
> 
> ohh. you did :-) forget my previous comment

OK. Anyway, thank you for your review of these patches;)

	Hiroshi DOYU




