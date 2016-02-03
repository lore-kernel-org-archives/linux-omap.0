From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in v4.5-rc1
Date: Wed, 3 Feb 2016 18:16:33 +0100
Message-ID: <CAJZ5v0jcLb0ckR53h3RAqRJsfXTkMeFtkkqT2rX66kWZWH1x3A@mail.gmail.com>
References: <CAPDyKFpNRc3Nf9ofXhZrfBa54vXMxWboDScCrYFrZy97m8Y5gg@mail.gmail.com>
	<Pine.LNX.4.44L0.1602031034360.2041-100000@iolanthe.rowland.org>
	<20160203160951.GF19432@atomide.com>
	<CAPDyKFoNY8xP11n6mFVicYwdy49sB4=H0fTm53754HukFX4HBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoNY8xP11n6mFVicYwdy49sB4=H0fTm53754HukFX4HBQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 3, 2016 at 5:24 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 3 February 2016 at 17:09, Tony Lindgren <tony@atomide.com> wrote:
>> * Alan Stern <stern@rowland.harvard.edu> [160203 07:46]:
>>> On Wed, 3 Feb 2016, Ulf Hansson wrote:
>>>
>>> > > Let me summarize my understanding of this thread so far.
>>> > >
>>> > > It looks like the omap3 code initializes hardware in ->probe() and
>>> > > then it may return -EPROBE_DEFER due to some unmet dependencies.  In
>>> > > that case the hardware is not reset to the previous state and the
>>> > > runtime PM framework is left in the state that corresponds to the
>>> > > current hardware state.  Before we had pm_runtime_reinit(), everything
>>> > > worked as expected on the second ->probe() call, because things were
>>> > > in sync then.
>>> >
>>> > Correct!
>>
>> Well not quite correct. After failed probe PM runtime is set to reset
>> state while hardware is still enabled.
>
> Yes, but that's *after* pm_runtime_reinit() was added.
>
> I think Rafael was thinking about how it worked *before*.

Right.

Thanks,
Rafael
