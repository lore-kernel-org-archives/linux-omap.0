From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/3] musb: fixes vbus off issue after disconnect
Date: Mon, 3 Nov 2008 17:10:58 +0200
Message-ID: <20081103151058.GB7681@gandalf.research.nokia.com>
References: <20081103125047.GM21760@gandalf.research.nokia.com> <19F8576C6E063C45BE387C64729E739403E5E8A787@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37128 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683AbYKCPLo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Nov 2008 10:11:44 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E5E8A787@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "david-b@pacbell.net" <david-b@pacbell.net>, "me@felipebalbi.com" <me@felipebalbi.com>

On Mon, Nov 03, 2008 at 08:33:26PM +0530, Ajay Kumar Gupta wrote:
> I agree but currently in host only mode after disconnect vbus is switched off and
> there is no way to switch it on. Now if we connect other device it doesn't work
> as musb is dead.

Hmm... sounds odd. I haven't been using musb as host only for a long
time, last time I think was on n800 time :-p

Anyways, enable debugging and echo 8 >
/sys/modules/musb_hdrc/parameters/debug and see if you get any event
upon cable attach. You should have an id pin grounded event, then that
should trigger vbus on

> > I believe that we should have a "session" entry on sysfs and upon cable
> > connection, one side switches to a_idle and the other stays in b_idle.
> > The device that writes to session (echo 1 > session) will become host
> > (either b_host or a_host, meaning that hnp would also trigger based on
> > that).
> 
> This is the case of OTG build but what if we configure for only host mode ? All 
> OTG related stuff shouldn't be there in host only mode right ?

most likely, yeah. But still, it would appear more like an embedded host
than a real host controller. Which means we can still switch off vbus
when not in use, I suppose.

-- 
balbi
