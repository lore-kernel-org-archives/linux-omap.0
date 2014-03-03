From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/4] power_supply: Introduce PSE compliant algorithm
Date: Mon, 3 Mar 2014 11:42:22 +0100
Message-ID: <20140303104222.GA26675@amd.pavel.ucw.cz>
References: <1391490780-6141-1-git-send-email-jenny.tc@intel.com>
 <1391490780-6141-4-git-send-email-jenny.tc@intel.com>
 <CACRpkdbppewuSSJu=Y=1T7oOCxz_ynhNspyPT=S894KoUB6H6g@mail.gmail.com>
 <20140228030727.GB27921@jenny-desktop>
 <20140228100816.GA13406@amd.pavel.ucw.cz>
 <20140303031137.GA1132@jenny-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140303031137.GA1132@jenny-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Jenny Tc <jenny.tc@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, Kim Milo <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Rhyland Klein <rklein@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@ring0.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pallala Ramakrishna <ramakrishna.pallala@intel.com>=?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <f>
List-Id: linux-omap@vger.kernel.org

Hi!

> > > Just to convey that is_battery_full is a local function and not generic. You
> > > can find similar usage in power_supply_core.c (__power_supply_changed_work)
> > > and in other drivers. Isn't it advised to have __ prefixes?
> > 
> > It is static; everybody sees it is local. __ prefix usually means
> > something else.
> 
> Agreed, I will remove the __ prefix in next patchset. Meanwhile I would
> appreciate if anyone could help me to understand what __ prefix
> really means.

If you have __foo() and foo(), the __foo() is typically worker
function, where foo() provides locking around it etc. 
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
