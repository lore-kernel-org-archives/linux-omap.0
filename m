From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 08/17] ARM: dts: dra7: Add dt node for the sycon pcie
Date: Wed, 24 Jun 2015 19:00:20 +0530
Message-ID: <558AB0EC.10203@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>	<1435060743-5511-9-git-send-email-kishon@ti.com>	<20150624145017.9b70a1fba477d8b99ce85702@ti.com> <20150624145617.e5248d466fe5b2e0eb1ca087@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150624145617.e5248d466fe5b2e0eb1ca087-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wednesday 24 June 2015 05:26 PM, Roger Quadros wrote:
> On Wed, 24 Jun 2015 14:50:17 +0300
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> wrote:
> 
>> On Tue, 23 Jun 2015 17:28:53 +0530
>> Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:
>>
>>> Add new device tree node for the control module register space where
>>> PCIe registers are present.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>>> ---
>>>  arch/arm/boot/dts/dra7.dtsi |    5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>>> index 260f300..3f434f7 100644
>>> --- a/arch/arm/boot/dts/dra7.dtsi
>>> +++ b/arch/arm/boot/dts/dra7.dtsi
>>> @@ -291,6 +291,11 @@
>>>  			reg = <0x4a002e00 0x7c>;
>>>  		};
>>>  
>>> +		dra7_ctrl_pcie: tisyscon@4a003c00 {
>>> +			compatible = "syscon";
>>> +			reg = <0x4a003c00 0x48>;
>>> +		};
>>> +
>>
>> Why do you need to start from 0x4a003c00?
>> CTRL_CORE_PCIESS1_PCS1 is at 0x4a003c24
> 
> Also, why can't this dra7_ctrl_pcie node be where scm_conf is.

Yes. I think that's the right thing to do. I saw dra7_ctrl_core and
dra7_ctrl_general and added it.

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
