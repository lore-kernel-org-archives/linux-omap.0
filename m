From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in v4.5-rc1
Date: Wed, 27 Jan 2016 09:17:45 +0100
Message-ID: <CAPDyKFo-itpp1JUVANSFNiyhKcv1XLUqx1GwRk532LaT+ija0g@mail.gmail.com>
References: <20160126224804.GB19432@atomide.com>
	<CAJZ5v0gTRvyWHVmYNb8Q1QZzhVhokXo541+48mFyDRYv7Hi-Uw@mail.gmail.com>
	<20160126235222.GF19432@atomide.com>
	<2779316.34ov6YOQgv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <2779316.34ov6YOQgv@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 27 January 2016 at 08:54, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, January 26, 2016 03:52:23 PM Tony Lindgren wrote:
>> * Rafael J. Wysocki <rafael@kernel.org> [160126 15:38]:
>> > On Wed, Jan 27, 2016 at 12:22 AM, Tony Lindgren <tony@atomide.com> wrote:
>> > > * Rafael J. Wysocki <rafael@kernel.org> [160126 15:15]:
>> > >> On Tue, Jan 26, 2016 at 11:48 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > >> > Hi,
>> > >> >
>> > >> > Looks like commit 5de85b9d57ab ("PM / runtime: Re-init runtime
>> > >> > PM states at probe error and driver unbind") broke PM on at least
>> > >> > omap3. It seems we now need to additionally also call
>> > >> > pm_runtime_dont_use_autosuspend() to get things working again?
>> > >> >
>> > >> > The following fixes idling on omap3, but I'm wondering if we
>> > >> > should do something in pm_runtime_reinit() instead?
>> > >>
>> > >> Well, does it actually help if you add
>> > >> pm_runtime_dont_use_autosuspend(dev) to pm_runtime_reinit()?
>> > >
>> > > No adding it to pm_runtime_reinit() does not help.
>> >
>> > Yes, I realized that it wouldn't help only after sending the previous
>> > message, sorry about that.
>> >
>> > The reason why it helps in the driver code seems to be that
>> > autosuspend_delay happens to be negative, so update_autosuspend()
>> > decrements the usage counter that would have stayed incremented
>> > otherwise.  Or at least that's the only way it can help I see ATM.
>>
>> Oh OK.
>>
>> > > Looks like we have RPM_ACTIVE set in pm_runtime_reinit() if that
>> > > gives any clues.
>> >
>> > It looks like pm_runtime_reinit() should clear the usage counter too.
>>
>> Yeah if we do this when !pm_runtime_enabled(dev) it seems it's
>> safe to pretty much reset everything?
>
> Not only safe, but also a good idea apparently. :-)

I happy to send a patch, extending pm_runtime_reinit() with some more
data to be reset.

Or, you or Tony intend to send a patch?

Kind regards
Uffe
