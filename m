From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v9 01/25] gpio/omap: remove dependency on gpio_bank_count
Date: Sun, 5 Feb 2012 18:05:37 +0530
Message-ID: <CAMQu2gzaQ+uHGpu-mpEPaxFim4_yRayKw_XBPBUgu7ML7daR2w@mail.gmail.com>
References: <4F2AF68D.1000505@ti.com> <20120202214907.GA22888@legolas.emea.dhcp.ti.com>
 <20120202215350.GB22888@legolas.emea.dhcp.ti.com> <4F2B078B.1040709@ti.com>
 <20120202220744.GA23092@legolas.emea.dhcp.ti.com> <87liojajs4.fsf@ti.com>
 <20120204160802.GA10818@legolas.emea.dhcp.ti.com> <CA+HSevqvHAgA+PPLm8BH5vfWkc8yY8W+fRpqjT2urq2EWtSYiA@mail.gmail.com>
 <20120205090805.GA13300@legolas.emea.dhcp.ti.com> <CAMQu2gyNhEJ3vr7_o_xYAQOYKaRofJViobKtfH2HoxwgU7nUpw@mail.gmail.com>
 <20120205113521.GA13533@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120205113521.GA13533@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: "Varadarajan, Charulatha" <charu@ti.com>, Kevin Hilman <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sun, Feb 5, 2012 at 5:05 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Sun, Feb 05, 2012 at 02:46:19PM +0530, Shilimkar, Santosh wrote:
>> >> bank->mod_usage check is used to take care of doing pm_runtime_ge=
t*/put* only
>> >> if all the GPIOs in a particular bank are enabled or disabled res=
pectively.
>> >
>> > and why should you care about that ? The first get will enable the
>> > resources you need, the second get will just increase a counter an=
d so
>> > on. So if you have 32 gets, you will disable the module when you h=
ave 32
>> > puts.
>> >
>> Am not sure if it is clear to you that the GPIO resources like clock=
,
>> debounce clk are per bank wise and not per GPIO line. So doing 32
>
> this is just one more reason to have usage counters.
>
>> get/put per bank is stupid. runtime pm is for managing pm
>
> what's stupid is trying to use the pm usage counters as a binary flag=
,
> see below.
>
>> resources and if the pm resource is per bank, it has to be
>> handled per bank.
>
> hehe, what are you talking about Santosh ? That's the whole point of
> reference counting. If there are 32 users for 1 resource, you want to
> make sure that you only free the resources (clocks, or whatever resou=
rce
> you want) after all 32 users are done with it.
>
> Trying to use the pm usage counter as a binary flag, that's the stupi=
d
> part of the OMAP GPIO driver.
>
> Instead of adding checks such as:
>
> if (module_isnt_used())
> =A0 =A0 =A0 =A0enable_clocks();
>
> on get and:
>
> if (module_isnt_needed_anymore())
> =A0 =A0 =A0 =A0disable_clcoks()
>
> on put is the most useless piece of code on that driver. Because such
> checks are already available on PM core through usage counters. The w=
ay
> that part of the code works is as follow:
>
> get() {
> =A0 =A0 =A0 =A0if (pm_counter_is_zero(dev)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0atomic_inc();
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rpm_resume();
> =A0 =A0 =A0 =A0}
> }
>
> put() {
> =A0 =A0 =A0 =A0atomic_dec();
>
> =A0 =A0 =A0 =A0if (pm_counter_is_zero(dev)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rpm_suspend();
> =A0 =A0 =A0 =A0}
> }
>
> Do you not see that you're duplicating functionality by trying to use
> the pm counter a binary flag ?
>
Ahh.. Now I see your point. I miss-understood the point first time
and thought that we have disconnect on the pm resources from
number of GPIO perspective.

What you are saying is to use pm runtime reference counters rather
than creating local ones for GPIO which seems to be right thing to
do. Sorry for the noise.

The agressive clock cutting was tried initially without much success
and may be we can revisit this one more time.

As per as this series is concerned, we would like to fix
the build error pointed by Kevin and queue it for 3.4.

There are few more fixes getting cooked up for GPIO and
as part of that series we will have a look at your suggestion.

Thanks for review.

Regards
santosh




Regards
Santosh
