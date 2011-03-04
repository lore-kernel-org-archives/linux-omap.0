From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] OMAP: DSS2: Add DSS2 support for Overo
Date: Fri, 4 Mar 2011 17:30:14 +0200
Message-ID: <1299252614.2053.5.camel@deskari>
References: <1299195980-17057-1-git-send-email-steve@sakoman.com>
	 <1299195980-17057-3-git-send-email-steve@sakoman.com>
	 <1299225648.2196.25.camel@deskari>
	 <AANLkTikSq+9A_HVy0dk2coYb9AvVRgHZOG1q0RRCJtV1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36806 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953Ab1CDPaW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 10:30:22 -0500
In-Reply-To: <AANLkTikSq+9A_HVy0dk2coYb9AvVRgHZOG1q0RRCJtV1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2011-03-04 at 09:25 -0600, Steve Sakoman wrote:
> On Fri, Mar 4, 2011 at 12:00 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> 
> > Why check for CONFIG_PANEL_LGPHILIPS_LB035Q02, but not for the lcd43?
> >
> > And is that even necessary? Of course it would make the kernel very
> > slightly smaller if you leave some code out, but otherwise does that
> > help? If you have the device definitions there, but the user doesn't
> > load the driver, they wouldn't do anything, would they?
> >
> > For me the ifdefs just make the code harder to read, but I'm not sure if
> > there's some standard custom to have these.

<snip>

> The spidev driver turns out to be useful for a lot of embedded
> applications, so I would prefer to leave the check in place if you
> agree that this could be useful.

Yes, sounds like a valid reason to me.

 Tomi


