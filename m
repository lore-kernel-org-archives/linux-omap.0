From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/4] power_supply: Introduce generic psy charging driver
Date: Wed, 12 Feb 2014 12:00:05 +0100
Message-ID: <20140212110005.GF25706@amd.pavel.ucw.cz>
References: <1391490780-6141-1-git-send-email-jenny.tc@intel.com>
 <1391490780-6141-3-git-send-email-jenny.tc@intel.com>
 <20140204113630.GC2450@amd.pavel.ucw.cz>
 <20140205081458.GA19586@jenny-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140205081458.GA19586@jenny-desktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Jenny Tc <jenny.tc@intel.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Anton Vorontsov <anton.vorontsov@linaro.org>, Kim Milo <Milo.Kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Rhyland Klein <rklein@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@ring0.de>, aaro.koskinen@iki.fi, Pallala Ramakrishna <ramakrishna.pallala@intel.com>, freemangordon@abv.bg, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed 2014-02-05 13:44:58, Jenny Tc wrote:
> On Tue, Feb 04, 2014 at 12:36:30PM +0100, Pavel Machek wrote:
> > > +struct psy_charger_context {
> > > +	bool is_usb_cable_evt_reg;
> > > +	int psyc_cnt;
> > > +	int batt_status;
> > > +	/*cache battery and charger properties */
> > 
> > Comment coding style. Please run you patches through checkpatch.
> 
> checkpatch doesn't throw any error/warning. /* ... */ not allowed for single line
> comments? (will fix missing space after /*)

I meant the space after /*. Maybe checkpatch does not report anything
here, but I guess there are other places where it will comment :-).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
