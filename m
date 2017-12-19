From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: opp: Introduce ti-opp-supply bindings
Date: Tue, 19 Dec 2017 01:26:06 +0100
Message-ID: <CAJZ5v0iX9NykEu1yzL4D=iJ29fkd6ejXmu8kS9h4Mk8e1YxFWw@mail.gmail.com>
References: <20171215042528.28715-1-d-gerlach@ti.com> <20171215042528.28715-4-d-gerlach@ti.com>
 <CAJZ5v0iaYAodhiQm3=7OMhtqP3JXoX_RTrYMRDxVwO=3hTL7Bg@mail.gmail.com>
 <CAJZ5v0iRg0Sncqt4s3M5+E0h=HJiEDQ4vnB3=6mFhECCv_Lnng@mail.gmail.com> <abe0efc0-6dfc-e9b0-c535-aa1a48bf1a6b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <abe0efc0-6dfc-e9b0-c535-aa1a48bf1a6b-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 18, 2017 at 8:25 PM, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> wrote:
> Rafael,
> On 12/16/2017 04:52 AM, Rafael J. Wysocki wrote:
>> On Fri, Dec 15, 2017 at 3:29 PM, Rafael J. Wysocki <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>> On Fri, Dec 15, 2017 at 5:25 AM, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> wrote:
>>>> Document the devicetree bindings that describe Texas Instruments
>>>> opp-supply which allow a platform to describe multiple regulators and
>>>> additional information, such as registers containing data needed to
>>>> program aforementioned regulators.
>>>>
>>>> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
>>>
>>> I need an ACK from Rob on this one.
>>
>> Actually, how this (and the next patch) is related to the [1-2/4]?
>>
>
> The main goal of this series is to add support for scaling the multiple
> regulators needed for the CPU on these TI platforms. The OPP core supports
> multiple regulators but only to the point that it can associate a list of
> regulators to a device. It still by default only scales the normal vdd regulator
> when doing a rate transition. Because of this, we must define our own method of
> doing rate transitions to take the references to our regulators held in the OPP
> core and scale them in the proper sequence depending on what the platform needs.
>
> So to describe the purpose of each patch and their relation to each other:
>
> Patch 1: We must be able to defer the ti-cpufreq driver now that we look for
> regulators during probe as they likely won't be ready when we probe.
>
> Patch 2: Tell the OPP core about regulators needed for TI CPUFreq operation
> using the OPP core. This doesn't actually do anything besides place them in a
> list at this point because the OPP core can't know how TI platforms needs them
> scaled in relation to each other. Placing the regulator definition in ti-cpufreq
> driver ensures they are registered with opp core before cpufreq-dt probes (which
> is triggered at the end of ti-cpufreq probe) and actually makes the opp core get
> the regulators.
>
> Patch 3: Binding doc for patch 4 driver.
>
> Patch 4: TI OPP supply driver which understands how to actually make use of the
> two regulators that the OPP core now has a reference to. This overrides the
> standard opp_set_rate function to let us scale frequency and voltage as needed
> for TI platforms.

Thanks for the explanation, I've applied the series.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
