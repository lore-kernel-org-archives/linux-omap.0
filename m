From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.5-rc0 regression: GPRS breaks after very short while
Date: Sat, 18 Jun 2016 12:39:57 +0200
Message-ID: <20160618103957.GA20130@amd>
References: <20160518074924.GA20652@amd>
 <20160518141624.GA8025@earth>
 <20160518201251.GA22015@amd>
 <20160520041258.GB22076@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160520041258.GB22076@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

On Fri 2016-05-20 06:12:59, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, May 18, 2016 at 10:12:51PM +0200, Pavel Machek wrote:
> > > The last one only changes a comment, so not relevant, the other
> > > two fix error handling during initialization and are most likely
> > > also not the problem. Can you try to bisect the problem?
> > 
> > It will not be fun, but I guess it is doable. But before I start it
> > would be good to know -- does it work for you?
> 
> I currently don't have a second SIM card with network access for my
> dev phone, so I usually only test without gprs connection. As a
> result I don't really know if longer data connection would work.
> 
> Also I'm quite busy until next weekend with other stuff. If you did
> not find anything until then, I will do some testing/debugging.

Ok, it looks like problems got less reproducible for me.

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
