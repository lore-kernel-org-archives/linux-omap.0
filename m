From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: am33xx: Move wkup_m3 node to soc node
 and add ranges
Date: Mon, 9 Mar 2015 18:59:06 -0500
Message-ID: <54FE33CA.4090709@ti.com>
References: <1425528742-3087-1-git-send-email-d-gerlach@ti.com> <1425528742-3087-3-git-send-email-d-gerlach@ti.com> <20150305154039.GD13520@atomide.com> <54F88849.1090708@ti.com> <20150305165727.GE13520@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150305165727.GE13520@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>, Kevin Hilman <khilman@linaro.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Tony,

On 03/05/2015 10:57 AM, Tony Lindgren wrote:
> * Suman Anna <s-anna@ti.com> [150305 08:47]:
>> On 03/05/2015 09:40 AM, Tony Lindgren wrote:
>>> * Dave Gerlach <d-gerlach@ti.com> [150304 20:14]:
>> Dave,
>>
>> Looks like the commit message disappeared during your patch preparation.
>>
>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>>> ---
>>>>  arch/arm/boot/dts/am33xx.dtsi | 21 +++++++++++++--------
>>>>  1 file changed, 13 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>>>> index acd3705..086415c 100644
>>>> --- a/arch/arm/boot/dts/am33xx.dtsi
>>>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>>>> @@ -77,10 +77,23 @@
>>>>  	 */
>>>>  	soc {
>>>>  		compatible = "ti,omap-infra";
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <1>;
>>>> +		ranges = <0x0     0x44d00000 0x4000>,
>>>> +			 <0x80000 0x44d80000 0x2000>;
>>>> +
>>>
>>> I think putting the ranges here will cause issues for adding
>>> ranges for anything else.
>>>
>>> How about do something like this instead (untested):
>>>
>>> ocp {
>>> 	l4_wkup: l4_wkup@44c00000 {
>>> 		compatible = "am335-l4-wkup", "simple-bus";
>>> 		ranges = <0 0x44c00000 0x3fffff>;
>>>
>>> 		wkup_m3: wkup_m3@44d00000 {
>>> 			compatible = "ti,am3353-wkup-m3";
>>> 			reg = <0x1000000     0x4000>,	/* M3 UMEM */
>>> 			      <0x180000	     0x2000>;	/* M3 DMEM */
>>> 			ti,hwmods = "wkup_m3";
>>> 			ti,pm-firmware = "am335x-pm-firmware.elf";
>>> 		};
>>>
>>> 		...
>>> 	};
>>> };
>>>
>>> That way we can start moving also the other l4_wkup components there
>>> eventuallly without having to redo the ranges again for wkup_m3.
>>>
>>> You can also look at how the scm_conf was done for dm816x.dtsi for an
>>> example, and the recent large set of patches posted by Tero.

I have taken a look at both the above. The L4_WKUP range includes the
PRCM, Control Module, as well as a few peripherals like DMTimer0, UART0
etc. What all do we want to move here eventually? Depending on that, we
may have to use 2 address cells like in Tero's PRCM cleanup series
rather than the single cell translation used by you in dm816x.dtsi so
that we can retain the relative addresses w.r.t the existing node bases
in the derivative child nodes.

regards
Suman
