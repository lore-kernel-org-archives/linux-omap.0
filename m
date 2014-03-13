From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv8 2/4] power_supply: Introduce generic psy charging
 driver
Date: Thu, 13 Mar 2014 10:10:41 +0100
Message-ID: <20140313091040.GB9494@amd.pavel.ucw.cz>
References: <1394170174-21959-1-git-send-email-jenny.tc@intel.com>
 <1394170174-21959-3-git-send-email-jenny.tc@intel.com>
 <20140307202520.GD27645@amd.pavel.ucw.cz>
 <20140310043328.GB27798@jenny-desktop>
 <CACRpkdaBv2-Grq3VPD8AqDS-aqaY9wtkaRqfkJCrEia1hTm0SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaBv2-Grq3VPD8AqDS-aqaY9wtkaRqfkJCrEia1hTm0SA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jenny Tc <jenny.tc@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, Kim Milo <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Rhyland Klein <rklein@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@ring0.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pallala Ramakrishna <ramakrishna.pallala@intel.com>, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordo>
List-Id: linux-omap@vger.kernel.org

On Wed 2014-03-12 15:32:59, Linus Walleij wrote:
> On Mon, Mar 10, 2014 at 5:33 AM, Jenny Tc <jenny.tc@intel.com> wrote:
> > On Fri, Mar 07, 2014 at 09:25:20PM +0100, Pavel Machek wrote:
> 
> >> > +   /* sort based on priority. 0 has the highest priority  */
> >> > +   for (i = 0; i < cnt; ++i)
> >> > +           for (j = 0; j < cnt; ++j)
> >> > +                   if (psy_prioirty(psy_lst[j]) > psy_prioirty(psy_lst[i]))
> >> > +                           swap(psy_lst[j], psy_lst[i]);
> >> > +
> >>
> >> WTF? Bubble sort in kernel?
> >
> > Yes, it's bubble sort. Since the number of power supply objects in real systems
> > (max 4) are limited, I feel the complexity would be as same as any other
> > sorting algorithms. Any suggestions?
> 
> You already have a kernel quicksort implementation in lib/sort.c.
> 
> Please restructure the code to make use of this as it is already
> compiled into every kernel.

Actually.. I believe the code needs more surgery than that. It should
not need those string lookups -- just attach data directly to struct
psy. And yes, if sort remains, it needs to use library function, but
I strongly believe sorting should not be neccessary here.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
