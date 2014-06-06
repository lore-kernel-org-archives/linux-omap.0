From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am43x-epos-evm: Add Missing cpsw-phy-sel for
 am43x-epos-evm
Date: Fri, 6 Jun 2014 10:28:01 -0500
Message-ID: <5391DE01.2080600@ti.com>
References: <1402035454-25676-1-git-send-email-george.cherian@ti.com> <53916556.10608@ti.com> <53918F75.1050000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53918F75.1050000-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/06/2014 04:52 AM, George Cherian wrote:
> On 6/6/2014 12:23 PM, Nishanth Menon wrote:
>> On 06/06/2014 01:17 AM, George Cherian wrote:
>>> AM437x EPOS evm use external clock for RMII interface.
>>> Enable the same in DT.
>>>
>>> Signed-off-by: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
>>> Reported-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
>>> ---
>>>   arch/arm/boot/dts/am43x-epos-evm.dts | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
>>> index 19f1f7e..90098f9 100644
>>> --- a/arch/arm/boot/dts/am43x-epos-evm.dts
>>> +++ b/arch/arm/boot/dts/am43x-epos-evm.dts
>>> @@ -319,6 +319,10 @@
>>>   	phy-mode = "rmii";
>>>   };
>>>   
>>> +&phy_sel {
>>> +	rmii-clock-ext;
>>> +};
>>> +
>>>   &i2c0 {
>>>   	status = "okay";
>>>   	pinctrl-names = "default";
>>>
>> Where does this apply on?
>> With linux-next next-20140506 tag, and this patch applied, I get the
> Is'nt next-20140506 a month old.

Uggh.. yeah - 1AM+migraine is not a good combination to try to do
testing. :( Apologies on the noise


> I tried the patch on next-20140604.

Tested on next-20140606 - applies clean, builds and works :)

am43xx-epos:  Boot PASS: http://slexy.org/raw/s2fT6zs45y

Tested-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
