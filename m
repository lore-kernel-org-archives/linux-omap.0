From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [PATCH v5 0/6] ARM: am335x/am437x/dra7: Add PWM support for DRA7
Date: Tue, 8 Mar 2016 11:04:19 -0600
Message-ID: <56DF0613.90203@ti.com>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com>
 <alpine.DEB.2.02.1603080642400.4974@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1603080642400.4974@utopia.booyaka.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vigneshr@ti.com
List-Id: linux-omap@vger.kernel.org



On 03/08/2016 12:55 AM, Paul Walmsley wrote:
> Hi Franklin
>
> On Mon, 7 Mar 2016, Franklin S Cooper Jr wrote:
>
>> This patch series adds support for PWM for DRA7. The IP is same as that
>> present in AM33XX and AM437XX.
>>
>> However, before doing so remove unnecessary hwmod entries for eCAP, ePWM
>> and eQEP.
>>
>> This series is almost identical to v4. Only difference is the addition of
>> eCAP DT nodes in the dra7.dtsi file.
>>
>> This series was tested on AM335x GP, AM437x GP and X15 + LCD screen for
>> PWM based backlight.
>>
>> This series was also verified to be backwards compatible with old dtbs.
> Looking at these to see what I can pick for v4.7, I'm curious about the 
> dependencies.  Can I take patches 2 and 3 before 1 is merged, or does 1 
> need to be merged first?
>
> - Paul

1 needs to be merged first.
