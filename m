From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: opp: Introduce ti-opp-supply bindings
Date: Mon, 18 Dec 2017 13:25:00 -0600
Message-ID: <abe0efc0-6dfc-e9b0-c535-aa1a48bf1a6b@ti.com>
References: <20171215042528.28715-1-d-gerlach@ti.com>
 <20171215042528.28715-4-d-gerlach@ti.com>
 <CAJZ5v0iaYAodhiQm3=7OMhtqP3JXoX_RTrYMRDxVwO=3hTL7Bg@mail.gmail.com>
 <CAJZ5v0iRg0Sncqt4s3M5+E0h=HJiEDQ4vnB3=6mFhECCv_Lnng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iRg0Sncqt4s3M5+E0h=HJiEDQ4vnB3=6mFhECCv_Lnng@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Rafael,
On 12/16/2017 04:52 AM, Rafael J. Wysocki wrote:
> On Fri, Dec 15, 2017 at 3:29 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Fri, Dec 15, 2017 at 5:25 AM, Dave Gerlach <d-gerlach@ti.com> wrote:
>>> Document the devicetree bindings that describe Texas Instruments
>>> opp-supply which allow a platform to describe multiple regulators and
>>> additional information, such as registers containing data needed to
>>> program aforementioned regulators.
>>>
>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>
>> I need an ACK from Rob on this one.
> 
> Actually, how this (and the next patch) is related to the [1-2/4]?
> 

The main goal of this series is to add support for scaling the multiple
regulators needed for the CPU on these TI platforms. The OPP core supports
multiple regulators but only to the point that it can associate a list of
regulators to a device. It still by default only scales the normal vdd regulator
when doing a rate transition. Because of this, we must define our own method of
doing rate transitions to take the references to our regulators held in the OPP
core and scale them in the proper sequence depending on what the platform needs.

So to describe the purpose of each patch and their relation to each other:

Patch 1: We must be able to defer the ti-cpufreq driver now that we look for
regulators during probe as they likely won't be ready when we probe.

Patch 2: Tell the OPP core about regulators needed for TI CPUFreq operation
using the OPP core. This doesn't actually do anything besides place them in a
list at this point because the OPP core can't know how TI platforms needs them
scaled in relation to each other. Placing the regulator definition in ti-cpufreq
driver ensures they are registered with opp core before cpufreq-dt probes (which
is triggered at the end of ti-cpufreq probe) and actually makes the opp core get
the regulators.

Patch 3: Binding doc for patch 4 driver.

Patch 4: TI OPP supply driver which understands how to actually make use of the
two regulators that the OPP core now has a reference to. This overrides the
standard opp_set_rate function to let us scale frequency and voltage as needed
for TI platforms.

Regards,
Dave
