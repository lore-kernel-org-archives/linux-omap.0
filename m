From: Faiz Abbas <a0230074@ti.com>
Subject: Re: [PATCH] ARM: dts: am57xx-idk: Remove support for voltage
 switching for SD card
Date: Thu, 2 May 2019 20:00:14 +0530
Message-ID: <50559611-a501-4331-c88b-5d05f6e756e9@ti.com>
References: <20190502084748.22518-1-faiz_abbas@ti.com>
 <20190502142016.GO8007@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190502142016.GO8007@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org, bcousson@baylibre.com, ulf.hansson@linaro.org, adrian.hunter@intel.com
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 02/05/19 7:50 PM, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [190502 01:48]:
>> If UHS speed modes are enabled, a compatible SD card switches down to
>> 1.8V during enumeration. If after this a software reboot/crash takes
>> place and on-chip ROM tries to enumerate the SD card, the difference in
>> IO voltages (host @ 3.3V and card @ 1.8V) may end up damaging the card.
>>
>> The fix for this is to have support for power cycling the card in
>> hardware (with a PORz/soft-reset line causing a power cycle of the
>> card). Since am571x-, am572x- and am574x-idk don't have this
>> capability, disable voltage switching for these boards.
>>
>> The major effect of this is that the maximum supported speed
>> mode is now high speed(50 MHz) down from SDR104(200 MHz).
> 
> This sounds a bit urgent, does it also need a stable tag or is
> it safe to apply against any earlier kernels?
> 

This should be good to apply on any previous releases.

Thanks,
Faiz
