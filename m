From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 3/6] ARM: AM335x/AM437x: hwmod: Remove eQEP, ePWM and
 eCAP hwmod entries
Date: Thu, 17 Mar 2016 14:04:07 -0500
Message-ID: <CAL_Jsq+mEPzt3DZLSWhnSuGdqErWQLEv_rGcu2zcn67HfUkMew@mail.gmail.com>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com>
 <1457400224-24797-4-git-send-email-fcooper@ti.com> <20160317150619.GA28105@rob-hp-laptop>
 <56EAD137.1080502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <56EAD137.1080502@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: "Franklin S Cooper Jr." <fcooper@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "paul@pwsan.com" <paul@pwsan.com>, Linux PWM List <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 17, 2016 at 10:45 AM, Franklin S Cooper Jr. <fcooper@ti.com> wrote:
>
>
> On 03/17/2016 10:06 AM, Rob Herring wrote:
>> On Mon, Mar 07, 2016 at 07:23:41PM -0600, Franklin S Cooper Jr wrote:
>>> Devices that utilize the OCP registers and/or PRCM registers and
>>> register bit fields should be modelled using hwmod. Since eQEP, ePWM and
>> s/modelled/modeled/
>
> Will fix.
>>
>>> eCAP don't fall under this category, remove their hwmod entries.
>>>
>>> Instead these clocks simply use the clock that is pass through by its
>>> parent PWMSS. Therefore, PWMSS handles the clock for itself and its
>>> subdevices.
>> Are you breaking compatibility with old DTs here?
>
> No. The first patch makes sure that the ecap and ehrpwm get
> their clocks from their parent which is all they care about.
> Old dtbs will have hwmod entries for ecap and ehrpwm which
> will end up not doing anything.

Okay.

Acked-by: Rob Herring <robh@kernel.org>
