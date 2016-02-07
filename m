From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/5] HSI: nokia-modem: kernel based PM
Date: Sun, 7 Feb 2016 22:39:49 +0100
Message-ID: <20160207213949.GC6147@amd>
References: <1454203187-688-1-git-send-email-sre@kernel.org>
 <1454203187-688-3-git-send-email-sre@kernel.org>
 <20160131172948.GC3721@amd>
 <20160131180009.GB18175@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160131180009.GB18175@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun 2016-01-31 19:00:09, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Jan 31, 2016 at 06:29:48PM +0100, Pavel Machek wrote:
> > > So far power management had to be done in uerspace using exported
> > 
> > "userspace"
> 
> Right, thanks.
> 
> > > This patch adds kernel based power management, which will bind the
> > > modem's power state to the state of the phonet network interface.
> > 
> > Ok, so I have ofonod that already does power management in
> > userspace. What happens when power management is done twice?
> 
> I have patches for ofono, which add support for the in-kernel
> power management. Currently ofono will not start with the new
> method, since it wants the GPIOs for userspace based PM.

Ok, but breaking userspace is a no-no, and stock ofono works well on
N900. So this should not go in as-is...?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
