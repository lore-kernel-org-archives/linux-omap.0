From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/2] cpufreq: cpufreq-cpu0: provide compatibility string
 for DT matchup
Date: Tue, 12 Mar 2013 20:05:14 +0530
Message-ID: <513F3D22.4080302@ti.com>
References: <1363043130-30270-1-git-send-email-nm@ti.com> <1363043130-30270-3-git-send-email-nm@ti.com> <513EB7FE.1070000@ti.com> <513F3B98.6050909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <513F3B98.6050909@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-kernel@vger.kernel.org, cpufreq <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 12 March 2013 07:58 PM, Benoit Cousson wrote:
> On 03/12/2013 06:07 AM, Santosh Shilimkar wrote:
>> On Tuesday 12 March 2013 04:35 AM, Nishanth Menon wrote:
>>> commit 5553f9e (cpufreq: instantiate cpufreq-cpu0 as a platform_driver)
>>> now forces platform device to be registered for allowing cpufreq-cpu0
>>> to be used by SoCs. example: drivers/cpufreq/highbank-cpufreq.c
>>>
>>> However, for SoCs that wish to link up using device tree, instead
>>> of platform device, provide compatibility string match:
>>> compatible = "cpufreq,cpu0";
> 
> You cannot add a non-HW relative binding... DT is supposed to represent
> the pure HW.
> AFAIK, cpufreq has nothing to do with the HW definition.
> 
You are right. 

>>>
>>> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Cc: Shawn Guo <shawn.guo@linaro.org>
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: cpufreq@vger.kernel.org
>>> Cc: linux-pm@vger.kernel.org
>>> Cc: linux-omap@vger.kernel.org
>>>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> ---
>>>  .../devicetree/bindings/cpufreq/cpufreq-cpu0.txt   |    3 +++
>>>  drivers/cpufreq/cpufreq-cpu0.c                     |    6 ++++++
>>>  2 files changed, 9 insertions(+)
>>>
>> Looks fine to me. CC'ing dt list in case some one has
>> comments on binding updates.
>>
>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Not-Acked-by-me.
> 
I obviously missed the point while acking the patch.

Regards,
santosh


