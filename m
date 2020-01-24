From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: Re: [Patch v4 00/10] ARM: dts: dra7: add cal nodes
Date: Fri, 24 Jan 2020 09:21:56 +0200
Message-ID: <668be3a7-d9be-6a2e-71ba-5631bf99dfae@ti.com>
References: <20191211140558.10407-1-bparrot@ti.com>
 <20200123171737.GB5885@atomide.com> <20200123172624.GE5885@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200123172624.GE5885-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 23/01/2020 19:26, Tony Lindgren wrote:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [200123 17:18]:
>> * Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org> [191211 06:03]:
>>> This patch series adds the needed clkctrl and ty-sysc nodes for CAL module.
>>> It also adds support for the module in related dtsi and dts for DRA72,
>>> DRA76 and AM654 SoC.
>>
>> Applying these into omap-for-v5.6/ti-sysc-dt-cam on top of Tero's
>> for-5.6-ti-clk branch. It might be too later for v5.6, but we'll
>> see.
> 
> Actually I'll leave out the k3-am65 dts changes as I don't see
> acks for those. Tero can pick up those later.
> 
> Regards,
> 
> Tony
> 

Right, I think I also missed the cal clkctrl patch in this series. This 
series is imho applying against too many different trees (three if I am 
not mistaken) and should be split up to avoid confusion / not to get 
lost in mailboxes.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
