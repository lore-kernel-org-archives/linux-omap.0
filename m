From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [Patch v4 6/6] ARM: dts: DRA7: Add dt nodes for PWMSS
Date: Mon, 7 Mar 2016 18:20:42 -0600
Message-ID: <56DE1ADA.5040903@ti.com>
References: <1457383187-17166-1-git-send-email-fcooper@ti.com>
 <1457383187-17166-7-git-send-email-fcooper@ti.com>
 <alpine.DEB.2.02.1603072352510.27387@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1603072352510.27387@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: vigneshr@ti.com, thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 03/07/2016 05:53 PM, Paul Walmsley wrote:
> On Mon, 7 Mar 2016, Franklin S Cooper Jr wrote:
>
>> From: Vignesh R <vigneshr@ti.com>
>>
>> Add PWMSS device tree nodes for DRA7 SoC family and add documentation
>> for dt bindings.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> [fcooper@ti.com: Use updated bindings for PWMSS and ePWM]
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>> ---
>> Version 4 changes:
>> Remove hwmod entries.
>> Add clocks/clock-names to pwm nodes.
> Hmm, what about moving the eqep, ecap DT nodes under the epwmss nodes?
>
>
> - Paul

We don't have a driver for eQEP which is why there is no DT
entry for it. For eCAP, the original patch series didn't
include the eCAP DT nodes and I never verified why this is
the case. In our TI tree we have eCAP0 only in the DT. The
TRM doesn't state that eCAP0-2 are unsupported so there
should be entries for all 3 eCAPs.

For AM335x and AM437x, eCAP nodes are already under the
ePWMSS nodes.
