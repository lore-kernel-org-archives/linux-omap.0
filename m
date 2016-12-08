From: Tero Kristo <t-kristo@ti.com>
Subject: Re: Cpufreq regression in next-20161207
Date: Thu, 8 Dec 2016 10:54:06 +0200
Message-ID: <bba6373e-3f2e-cbfa-1928-e205b2dc5ff3@ti.com>
References: <20161208045640.GB4264@atomide.com>
 <20161208050739.GE24152@vireshk-i7> <20161208055220.GD4264@atomide.com>
 <20161208055738.GB31711@vireshk-i7> <20161208060447.GE4264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20161208060447.GE4264@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stephen Boyd <sboyd@codeaurora.org>, Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 08/12/16 08:04, Tony Lindgren wrote:
> * Viresh Kumar <viresh.kumar@linaro.org> [161207 21:58]:
>> On 07-12-16, 21:52, Tony Lindgren wrote:
>>> Hmm good question. Maybe we don't have the regulators configured for
>>> pandaboard?
>>
>> Hmm, and who would be the right person to confirm that? And its not only about
>> pandaboard but the whole OMAP4 family (which is using cpufreq-dt driver).
>
> Nishanth and Dave in Cc should be able to confirm. Most likely it's some
> missing .config option for the regulators in multi_v7_defconfig compared
> to omap2plus_defconfig though.
>
> Regards,
>
> Tony

Pandaboard has a weird configuration, where MPU VDD is controlled by a 
separate component; TPS62361, but rest of the voltages are provided by 
TWL6030. The support for this was attempted to be upstreamed along with 
the required changes for the VC/VP framework under mach-omap2, but this 
was never accepted.

I'm not sure but I recall it wasn't possible to control the MPU voltage 
via the default I2C interface, instead you had to use the VC/VP path, 
which isn't fully implemented for OMAP4. As a consequence, none of the 
OMAP4 boards have a properly functioning MPU voltage supply control in 
place and you will rely on u-boot provided voltages.

-Tero
