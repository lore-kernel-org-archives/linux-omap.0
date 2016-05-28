From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Nokia N900 retention mode in v4.6, camera buttons fun
Date: Sat, 28 May 2016 13:09:35 +0200
Message-ID: <20160528110935.GB21182@amd>
References: <20160411211026.GH5995@atomide.com>
 <20160412121658.GA32486@amd>
 <20160412123013.GA12296@amd>
 <20160412163055.GP5995@atomide.com>
 <20160417175539.GA502@amd>
 <20160421130450.GQ29406@pali>
 <20160429200559.GA16598@earth>
 <20160501085236.GA14243@amd>
 <20160501154855.GA24970@earth>
 <20160502201216.GA19211@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160502201216.GA19211@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon 2016-05-02 22:12:17, Sebastian Reichel wrote:
> Hi Pavel,
> 
> On Sun, May 01, 2016 at 05:48:56PM +0200, Sebastian Reichel wrote:
> > > I see latest series, and it also talks about frequency scaling.
> > > But I guess it is not going to fix this issue?
> > 
> > No, this is independent of the runtime PM problems. I also worked
> > on runtime PM/idling yesterday and pm_runtime_irq_safe is the main
> > culprit for breaking it (not the only one, though). It's not yet
> > finished though
> 
> I will be on vacation for a week starting tomorrow. If you want to
> play around with my intermediate SSI PM status, you can try this branch:
> 
> https://git.kernel.org/cgit/linux/kernel/git/sre/linux-hsi.git/log/?h=runtime-pm-fixes

Ok, I did:

pavel@amd:/data/l/linux-n900$ git pull
git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git
runtime-pm-fixes
remote: Counting objects: 65, done.
remote: Compressing objects: 100% (25/25), done.
remote: Total 65 (delta 51), reused 54 (delta 40)
Unpacking objects: 100% (65/65), done.

And yes, now the LED goes off (so far with modem enabled but not
used). Thanks!

(You can have my Tested-by: when you submit them, or something :-) )

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
