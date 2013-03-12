From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 1/2] cpufreq: cpufreq-cpu0: support for clock which are
 not in DT yet.
Date: Tue, 12 Mar 2013 15:24:08 +0100
Message-ID: <513F3A88.5060903@ti.com>
References: <1363043130-30270-1-git-send-email-nm@ti.com> <1363043130-30270-2-git-send-email-nm@ti.com> <513EB704.8030907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <513EB704.8030907@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>
Cc: cpufreq <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Guys,

On 03/12/2013 06:03 AM, Santosh Shilimkar wrote:
> On Tuesday 12 March 2013 04:35 AM, Nishanth Menon wrote:
>> On certain SoCs like variants of OMAP, the clock conversion to DT
>> is not complete. In short, the ability to:
>> cpus {
>>     cpu@0 {
>> 	clocks = <&cpuclk 0>;
>>     };
>>  };
>> is not possible. However, the clock node is registered.
>> Allow for clk names to be provided as string so as to be used when needed.
>> Example (for OMAP3630):
>> cpus {
>>     cpu@0 {
>> 	clock-name = "cpufreq_ck";
>>     };
>>  };
>>
>> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: cpufreq@vger.kernel.org
>> Cc: linux-pm@vger.kernel.org
>> Cc: linux-omap@vger.kernel.org
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
> Seems a reasonable to me.

No, it is not...

You cannot add a temp binding just because the OMAP support is not
there, since the real binding already exist.

You need to register properly a clock provider to be able to reference
it.
If you do need a hacky temp code you could do it in OMAP code but not in
the binding.


Regards,
Benoit
