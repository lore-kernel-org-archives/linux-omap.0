From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Nokia N900 sound driver and ECI GPIOs
Date: Mon, 2 Jan 2017 10:34:34 +0200
Message-ID: <b80636f3-add3-9edf-009d-a938f1e9ebf9@ti.com>
References: <201701012054.54505@pali> <20170101223639.GA13868@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170101223639.GA13868@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, joerg Reisenweber <joerg@openmoko.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 01/02/2017 12:36 AM, Pavel Machek wrote:
> Hi!
> 
>> I'm looking at original Maemo N900 2.6.28 sound driver and GPIOs which
>> controls A/V jack detection.
>>
>> For reference source code of that driver can be found e.g. at alsa-devel
>> ML [1] [2] or in my linux-n900 git tree, branch v2.6.28-nokia [3].
>>
>> In that sound/soc/omap/rx51.c code is function rx51_set_eci_switches()
>> which configures 2 gpios: RX51_ECI_SWITCH_1_GPIO = gpio 178 and
>> RX51_ECI_SWITCH_2_GPIO = gpio 182 based on "eci mode" input parameter.
>>
>> But in mainline kernel code [4] [5] there is no information about gpio 178
>> (as RX51_ECI_SWITCH_1_GPIO) and gpio 182 is called as just "eci-switch".
>> More interesting part is that "eci-switch" gpio is not used in whole
>> mainline code. It is just referenced in Nokia N900 DTS [4]. Looks like
>> sound driver in mainline kernel is incomplete.
>>
>> Jarkko, you are listed as original author of that driver. Do you (or
>> anybody else) remember what that rx51_set_eci_switches() function is
>> doing? And what gpio 178 controls? I was even not able to find gpio 178
>> in RX-51 Schematics [6].
>>
>> And do you know something about Nokia ECI headsets supports for Nokia
>> N900. Looks like there is already some kernel code but support for ECI
>> bus or multibuttons headset is missing.
> 
> What does "ECI" mean?

ECI = Enhancement Control Interface

apart from buttons (play/pause/skip forward/reverse, etc) the
accessories can contain memory to store parameters, like audio tuning
data, etc.

> 
> I'd like to get detection of headset button presses to work in recent
> kernels, but could not figure it out :-(.
> 
> Are there multi-button headsets compatible with N900?

Not sure if n900 is capable of handling ECI communication, n9 was. In n9
the PMIC/Audio chip had an ECI core integrated afaik


> Best regards,
> 									Pavel
> 
> 

-- 
Péter
