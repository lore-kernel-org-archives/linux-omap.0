From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Merge plans for Staging  Synaptics Touchscreen Driver
Date: Mon, 29 Mar 2010 15:12:40 +0200
Message-ID: <20100329131136.GA26586@ucw.cz>
References: <19039.10.24.255.18.1269336516.squirrel@dbdmail.itg.ti.com> <20100326144415.GA1591@ucw.cz> <33474.10.24.255.18.1269863733.squirrel@dbdmail.itg.ti.com> <49670.10.24.255.17.1269864940.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <49670.10.24.255.17.1269864940.squirrel@dbdmail.itg.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>, kernel list <linux-kernel@vger.kernel.org>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

> >>> Pl add (if required) below tested by for the staging driver.
> >
> >>
> >> 1) are you able to use driver in staging?
> >
> > Yes I am able to use staging driver for single
> > touch events.

Good.

> >> at minimum, non-standard multitouch support needs to be removed before
> >> merging to input. Do you have time to help?
> >
> > Could you review the below patch.
> 
> Forgot to remove unused variables in earlier patch, here's
> the updated one.

Thanks, seems ok.

> Remove non-standard multi touch support.
> 
> Signed-off-by: Hemanth V <hemanthv@ti.com>

ACK.

Now... you probably want to send the patch to Greg. And then, I guess
you could take the patch from staging, and ask for another round of
review on linux-input.

If you could figure out if threaded interrupts can be used for this
driver, that would be welcome bonus.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
