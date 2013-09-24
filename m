From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/1] ARM: dts: am335x-bone-common: correct mux mode for mmc1_cmd
Date: Mon, 23 Sep 2013 21:24:06 -0500
Message-ID: <CAGo_u6qRwq8nYe+A69uqKKfJzg6PMuAcvTQYy2soEWOoaMS3bw@mail.gmail.com>
References: <1379698696-21945-1-git-send-email-balajitk@ti.com>
	<523C9DE4.6040109@ti.com>
	<52405E30.2020001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52405E30.2020001-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, dt list <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 23, 2013 at 10:28 AM, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org> wrote:
> On Saturday 21 September 2013 12:41 AM, Nishanth Menon wrote:
>>
>> On 09/20/2013 12:38 PM, Balaji T K wrote:
>>>
>>> correct mux mode for mmc1_cmd to detect eMMC on bone-black
>>>
>>> Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
>>> ---
>>>   arch/arm/boot/dts/am335x-bone-common.dtsi |    2 +-
>>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi
>>> b/arch/arm/boot/dts/am335x-bone-common.dtsi
>>> index 56361ce..90ab56c 100644
>>> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
>>> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
>>> @@ -117,7 +117,7 @@
>>>                 emmc_pins: pinmux_emmc_pins {
>>>                         pinctrl-single,pins = <
>>>                                 0x80 (PIN_INPUT_PULLUP | MUX_MODE2) /*
>>> gpmc_csn1.mmc1_clk */
>>> -                               0x84 (PIN_INPUT_PULLUP | MUX_MODE1) /*
>>> gpmc_csn2.mmc1_cmd */
>>> +                               0x84 (PIN_INPUT_PULLUP | MUX_MODE2) /*
>>> gpmc_csn2.mmc1_cmd */
>>>                                 0x00 (PIN_INPUT_PULLUP | MUX_MODE1) /*
>>> gpmc_ad0.mmc1_dat0 */
>>>                                 0x04 (PIN_INPUT_PULLUP | MUX_MODE1) /*
>>> gpmc_ad1.mmc1_dat1 */
>>>                                 0x08 (PIN_INPUT_PULLUP | MUX_MODE1) /*
>>> gpmc_ad2.mmc1_dat2 */
>>>
>> is'nt this a common change? why is it "black only"? if it is so, then
>> the pinmux should probably be spun off outside bone-common.dtsi into
>> boneblack.dtsi perhaps?
>>
>
> It is applicable for add-on eMMC-cape for beagle bone white, so eMMC pinmux
> can
> remain in bone-common.dtsi.
> However I could test only on beagle bone black which has eMMC on board,
> since I
> don't have access to eMMC-cape


Could you update the patch to the effect please considering you are
modifying am335x-bone-common.dtsi

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
