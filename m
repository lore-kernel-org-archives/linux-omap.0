From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 05/15] OMAP: DSS2: RFBI: convert to new kfifo API
Date: Tue, 12 Jan 2010 12:35:19 +0200
Message-ID: <1263292519.2087.70.camel@tubuntu.research.nokia.com>
References: <1262956969-1664-1-git-send-email-tomi.valkeinen@nokia.com>
	 <1262956969-1664-2-git-send-email-tomi.valkeinen@nokia.com>
	 <1262956969-1664-3-git-send-email-tomi.valkeinen@nokia.com>
	 <1262956969-1664-4-git-send-email-tomi.valkeinen@nokia.com>
	 <1262956969-1664-5-git-send-email-tomi.valkeinen@nokia.com>
	 <1262956969-1664-6-git-send-email-tomi.valkeinen@nokia.com>
	 <20100108165210.GA6831@atomide.com>
	 <1263200958.2087.9.camel@tubuntu.research.nokia.com>
	 <48239d391001110125jb780503v2b17bdd4affb42f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55010 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab0ALKe2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 05:34:28 -0500
In-Reply-To: <48239d391001110125jb780503v2b17bdd4affb42f6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sergey Lapin <slapinid@gmail.com>
Cc: ext Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Mon, 2010-01-11 at 10:25 +0100, ext Sergey Lapin wrote:
> Hi, all!
> 
> >> Heh, maybe update the comments on this one before asking
> >> Linus to pull? :)
> >
> > Yes, perhaps that would be wise =). I hope somebody is able to test the
> > patch, as I don't have hardware to test it.
> Is there some guidelines on porting old rfbi driver to dss2?
> Then I could test this one.

Unfortunately no. You could look at panel-taal.c, which is a DSI command
mode display, as that is quite similar to what an rfbi display would be.

At some point I had a hackish port of N800 display to DSS2, but I didn't
have time to keep it up to date, so I left it out. Perhaps I will port
it again now that DSS2 is more stable (right... ;).

 Tomi


