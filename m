From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 3/4] Add support for DEVKIT8000 LCD
Date: Fri, 13 Nov 2009 13:50:38 +0200
Message-ID: <1258113038.20378.148.camel@tubuntu.research.nokia.com>
References: <838d5a2d54d0668ad72fffee7196d595@djdvant.com>
	 <1258026396.20378.106.camel@tubuntu.research.nokia.com>
	 <6cb69d4a0911120814i4a29e896g2436aea9670d193c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34076 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755082AbZKML5Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 06:57:16 -0500
In-Reply-To: <6cb69d4a0911120814i4a29e896g2436aea9670d193c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Daniel Toussaint <daniel@dmhome.net>
Cc: ext Kim Botherway <kbotherway@djdvant.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2009-11-12 at 17:14 +0100, ext Daniel Toussaint wrote:
> 
> 
> On Thu, Nov 12, 2009 at 7:46 PM, Tomi Valkeinen
> <tomi.valkeinen@nokia.com> wrote:
>         On Thu, 2009-11-12 at 11:23 +0100, ext Kim Botherway wrote:
>         > This patch add support for the Timll DEVKIT8000 LCD panel
>         
>         
>         I don't handle old omapfb patches. I think you should contact
>         Imre Deak
>         for those, although my advise would be to use the new display
>         subsystem
>         driver.
> 
> Question more or less related to this thread : when submitting new
> boards, it is better to work with DSS2 directly right ? I am also
> preparing a new board patch at this point, so I would like to know
> what is the sanest way to work ? Patch the linux-omap-2.6 tree with
> DSS2 patches , and then diff from there ? Or is is wiser to first
> submit without display related items, and wait for linux-omap-2.6 tree
> to have DSS2 support - which is going to happen soon I guess.  

Keep in mind that DSS2 is still a bit living target, you may need to do
changes to your board file or panel driver every now and then. If that
is ok for you, then I'd say DSS2 is better choice.

I'd say if you can wait, submit the patches only after DSS2 has gone in.
And I think at least the panel drivers should go through me, and I won't
take any patches until the core DSS2 driver has been merged.

 Tomi


