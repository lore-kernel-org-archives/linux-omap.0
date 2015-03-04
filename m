From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 07/15] twl4030_charger: allow fine control of charger
 current.
Date: Wed, 4 Mar 2015 11:24:15 +0100
Message-ID: <20150304102415.GC30887@amd>
References: <20150224043341.4243.23291.stgit@notabene.brown>
 <20150224043351.4243.88962.stgit@notabene.brown>
 <20150302210501.GJ13270@amd>
 <20150304174741.4b3af1ac@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150304174741.4b3af1ac@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

> does this help?
> 
> 	/*
> 	 * For ichg_eoc, the hardware only supports reg values matching
> 	 * 100XXXX000, and requires the XXXX be stored in the high nibble
> 	 * of TWL4030_BCIMFTH8
> 	 */

A bit, yes. Add "." at the end of sentence ;-).

(Now I'd need to study the datasheets... and figure out how to enable
this on N900).

Thanks,
									Pavel
									

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
