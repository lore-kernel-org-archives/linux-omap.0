From: <kalle.jokiniemi@nokia.com>
Subject: RE: [PATCH v3 2/2] RX-51: Enable isp1704 power on/off
Date: Wed, 30 Mar 2011 07:00:29 +0000
Message-ID: <9D0D31AA57AAF5499AFDC63D6472631B06F20F@008-AM1MPN1-036.mgdnok.nokia.com>
References: <1301405280-16899-1-git-send-email-kalle.jokiniemi@nokia.com>
 <1301405280-16899-3-git-send-email-kalle.jokiniemi@nokia.com>
 <a5285450b1fc92da8a42cc0733360a30@mail.gmail.com>
 <9D0D31AA57AAF5499AFDC63D6472631B06F1AE@008-AM1MPN1-036.mgdnok.nokia.com>
 <13db9138ec7598cfe100deae367f0b6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:17515 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638Ab1C3HAi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Mar 2011 03:00:38 -0400
In-Reply-To: <13db9138ec7598cfe100deae367f0b6a@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: keshava_mgowda@ti.com, linux-usb@vger.kernel.org, cbouatmailru@gmail.com
Cc: balbi@ti.com, Heikki.Krogerus@nokia.com, sshtylyov@mvista.com, tony@atomide.com, khilman@ti.com, linux-omap@vger.kernel.org, jhnikula@gmail.com

Hi,

 > -----Original Message-----
 > From: ext Keshava Munegowda [mailto:keshava_mgowda@ti.com]

<snip>

> >  > > +
 > >  > >  static struct platform_device rx51_charger_device = {
 > >  > > -	.name = "isp1704_charger",
 > >                             ^space here
 > >
 > >
 > >
 > >  > > +	.name	= "isp1704_charger",
 > >                               ^tab here
 > >  >
 > >  > I don't understand what difference between above two lines?
 > >  > Is your mail client causing this? Or get send-mail doing this?
 > >
 > > No, changed space for tab so that all the members are indented same way.
 > > I had that (apparently obscure) explanation about this in the commit log
 > ;)
 > 
 > Then, I am sorry; I couldn't able to notice this!

No problem, you're not the first one to point that out :)

- Kalle


