From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH] regulator: core: Pass max_uV value to
 regulator_set_voltage_rdev
Date: Fri, 28 Sep 2018 23:36:33 +0300
Message-ID: <74a96485-268c-3e80-bde5-70e28896c48c@gmail.com>
References: <20180615112916.GK112168@atomide.com>
 <CGME20180618140856eucas1p281619f9bf003655a3c2eac356216ab25@eucas1p2.samsung.com>
 <1529330913-11152-1-git-send-email-m.purski@samsung.com>
 <20180702080505.GN112168@atomide.com>
 <95655644-ef41-f5bd-7e8e-a257d48cd020@gmail.com>
 <20180928202251.GM5662@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928202251.GM5662@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Maciej Purski <m.purski@samsung.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-omap@vger.kernel.org

On 9/28/18 11:22 PM, Tony Lindgren wrote:
> * Dmitry Osipenko <digetx@gmail.com> [180928 20:13]:
>> Tony, could you please give a try to the patch below?
>>
>> Do the following:
>>
>> 1) git cherry-pick 696861761a58d8c93605b5663824929fb6540f16
>> 2) git cherry-pick 456e7cdf3b1a14e2606b8b687385ab2e3f23a49a
>> 3) Apply this patch:
> 
> Seems to be getting closer, system boots up and starts
> init, but then I start getting tons of this on beagle-x15:
> 
> [   17.089059] cpu cpu0: vbb failed for 1210000uV[min 950000uV max 1500000uV]
> [   17.096342] cpu cpu0: vbb failed for 1060000uV[min 850000uV max 1500000uV]
> [   17.103275] cpufreq: __target_index: Failed to change cpu frequency: -22
> [   17.118139] cpu cpu0: vbb failed for 1210000uV[min 950000uV max 1500000uV]
> [   17.125078] cpu cpu0: vbb failed for 1060000uV[min 850000uV max 1500000uV]
> [   17.132105] cpufreq: __target_index: Failed to change cpu frequency: -22
> [   17.148187] cpu cpu0: vbb failed for 1210000uV[min 950000uV max 1500000uV]
> [   17.155265] cpu cpu0: vbb failed for 1060000uV[min 850000uV max 1500000uV]
> [   17.162355] cpufreq: __target_index: Failed to change cpu frequency: -22
> [   17.171111] cpu cpu0: vbb failed for 1210000uV[min 950000uV max 1500000uV]
> [   17.178156] cpu cpu0: vbb failed for 1060000uV[min 850000uV max 1500000uV]
> [   17.185240] cpufreq: __target_index: Failed to change cpu frequency: -22
> [   17.197636] cpu cpu0: vbb failed for 1210000uV[min 950000uV max 1500000uV]
> [   17.204597] cpu cpu0: vbb failed for 1060000uV[min 850000uV max 1500000uV]
> [   17.211621] cpufreq: __target_index: Failed to change cpu frequency: -22
> [   17.227466] cpu cpu0: vbb failed for 1210000uV[min 950000uV max 1500000uV]
> [   17.234428] cpu cpu0: vbb failed for 1060000uV[min 850000uV max 1500000uV]
> [   17.241467] cpufreq: __target_index: Failed to change cpu frequency: -22

Thank you very much for testing and for the quick reply! That's an interesting result. I'll take a closer look at the patches and come back once there will be another patch to try.
