From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/4] usb: musb: Call atomic_notifier_call_chain when
 status is changed
Date: Wed, 18 Sep 2013 15:30:25 +0200
Message-ID: <20130918133025.GB2953@amd.pavel.ucw.cz>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <201309172128.42514@pali>
 <20130918014942.GD19817@radagast>
 <201309181020.15245@pali>
 <CAAwP0s1Ou7Nrq7GhnHX71TFCrTFg=nqUh+GsAJhN8DjZGsF4QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAwP0s1Ou7Nrq7GhnHX71TFCrTFg=nqUh+GsAJhN8DjZGsF4QQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Anton Vorontsov <anton@enomsg.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, freemangordon@abv.bg, Aaro Koskinen <aaro.koskinen@iki.fi>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

> >> > So will you do that? Or it is needed to resend this one line
> >> > hunk again in new email again?
> >>
> >> new patch, new email
> >
> > Guys, WHY ARE YOU SO STUPID AND ARROGANT?
> >
> > Sorry but, need to copy full isolated patch/hunk from one mail to
> > another is hassling. So what you want from me? Do all those non
> > sense working only because yesterday you had bad day? Or what?
...
> 
> Hi Pali,
> 
> There is no need to be rude.
> 
> Felipe asked you to do the split since he believes that the notifier
> chain call for musb xceiv and the twl->phy notifier head init should
> be done in two separate patches.

Actually, there is need to be rude, because Felipe fails to act as
maintainer. Instead of fixing bugs in his code, he bounces bugfix
patches, points people to random READMEs and wastes everyones time.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
