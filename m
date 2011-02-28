From: Heikki Krogerus <heikki.krogerus@nokia.com>
Subject: Re: [PATCH 0/1] power_supply: twl4030_charger modification
Date: Mon, 28 Feb 2011 08:05:33 +0200
Message-ID: <20110228060533.GA2181@esdhcp034230>
References: <1298634996-25722-1-git-send-email-heikki.krogerus@nokia.com>
 <20110225121234.GI4190@legolas.emea.dhcp.ti.com>
 <AANLkTik_N0Kk7putk+mb__S7NJxCYHSrxCH=DofduGpX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:54205 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940Ab1B1GFl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 01:05:41 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTik_N0Kk7putk+mb__S7NJxCYHSrxCH=DofduGpX@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, cbouatmailru@gmail.com

On Sat, Feb 26, 2011 at 08:10:17PM +0200, ext Grazvydas Ignotas wrote:
> On Fri, Feb 25, 2011 at 2:12 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Fri, Feb 25, 2011 at 01:56:35PM +0200, Heikki Krogerus wrote:
> >> Hi guys,
> >>
> >> Grazvydas, I don't have hardware to test this with. If this is OK to
> >> you, could you test it?
> 
> Sure, replied to your patch.

Thanks!

> >> Felipe, was the idea that you take this with the atomic notifier
> >> support for otg patches? I guess this is how it needs to be done in
> >> order to keep things bisectable, right? Or does this simply go to
> >> Anton?
> >
> > We can't change patches anymore :-( So as long as it goes on the merge
> > window, we should be ok, hopefully.
> 
> Talking about notifiers, do we have away to find the amount of current
> host can provide yet? I haven't followed USB development closely
> lately.

There is nothing to support this yet. I'm only assuming the ENUMERATED
event will be used for this. Now with the atomic notifiers it should
be OK for the controller drivers to send this notification always when
usb_gadget_vbus_draw() is called.

But Felipe is working with the udc class. Maybe he has some other
method in mind? For now I think we could send the ENUMERATED
event from all the controller drivers. Felipe?

-- 
heikki
