From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: dts: am33xx: Correct gpio #interrupt-cells property
Date: Tue, 13 Aug 2013 15:25:42 +0200
Message-ID: <520A33D6.5070700@baylibre.com>
References: <1375873592-26881-1-git-send-email-larsi@wh2.tu-dresden.de> <20130807145309.GG28558@e106331-lin.cambridge.arm.com> <201308071711.00449.poeschel@lemonage.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201308071711.00449.poeschel@lemonage.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars Poeschel <poeschel@lemonage.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Lars Poeschel <larsi@wh2.tu-dresden.de>, "b-cousson@ti.com" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi lars,

On 07/08/2013 17:11, Lars Poeschel wrote:
> On Wednesday 07 August 2013 at 16:53:09, Mark Rutland wrote:
>> On Wed, Aug 07, 2013 at 12:06:32PM +0100, Lars Poeschel wrote:
>>> From: Lars Poeschel <poeschel@lemonage.de>
>>>
>>> Following commit ff5c9059 and therefore other omap platforms using
>>> the gpio-omap driver correct the #interrupt-cells property on am33xx
>>> too. The omap gpio binding documentaion also states that
>>> the #interrupt-cells property should be 2.
>>
>> I take it there are no device nodes for which any of these nodes are an
>> interrupt parent (which would need to be updated)?
>
> As far as I know: No.
>
> Lars
>
>> If so:
>>
>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>>
>> Thanks,
>> Mark.
>>
>>> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>

Thank, applied with Mark and Javier A-By / R-By.

Thanks,
Benoit
