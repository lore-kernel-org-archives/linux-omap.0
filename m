From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/8] rtc: omap: Add external clock enabling support
Date: Thu, 6 Aug 2015 12:36:54 +0300
Message-ID: <55C32AB6.7090509@ti.com>
References: <1438771792-12604-1-git-send-email-j-keerthy@ti.com> <1438771792-12604-4-git-send-email-j-keerthy@ti.com> <20150805111316.GI16878@atomide.com> <20150805114119.GF3486@piout.net> <20150805114357.GG3486@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150805114357.GG3486-m++hUPXGwpdeoWH0uzbU5w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Alexandre,
On 08/05/2015 02:43 PM, Alexandre Belloni wrote:
> On 05/08/2015 at 13:41:19 +0200, Alexandre Belloni wrote :
>> Hi,
>>
>> On 05/08/2015 at 04:13:17 -0700, Tony Lindgren wrote :
>>> * Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> [150805 03:53]:
>>>> Based on the board property switch the source from internal
>>>> to external clock. Switching to external source is needed for
>>>> rtcwake to work in low power modes.
>>>
>>> I think this is better handled based on the compatible string
>>> in the device driver rather than introducing a custom dts
>>> property for it. You can just set the quirk flag in the driver
>>> probe based on the compatible.
>>>
>>
>> Why not use the clocks property? Then you can pass an external clock. If
>> it is present you can even get its rate if this is needed at some point
>> in the future. You could also disable it when going to suspend.
>>
> 
> Actually, that was already my suggestion back in april:
> http://patchwork.ozlabs.org/patch/445631/
> 
> (Please Cc: the rtc mailing list for RTC related patches so that they
> get picked up by patchwork).
> 

Pls, correct me if I'm not right. Is below what you propose?

Doard dts:
/ {
 rtc_32k_ext_clk: rtc_osc_xi_clkin32_ext {
	#clock-cells = <0>;
	compatible = "fixed-clock";
	clock-frequency = <32000>;
  	clock-output-names = "rtc_osc_xi_clkin32";
  };
}

 &rtc {
 	status = "okay";
	clocks = <&sys_32k_ck>, <&rtc_32k_ext_clk>;
	[optional] clock-names = "int-clk", "ext-clk";
 };

Driver:
1) clk0 is mandatory, internal clock source
2) clk1 is optional, external clock source, so
if present - RTC driver can switch to use ext clock source

-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
