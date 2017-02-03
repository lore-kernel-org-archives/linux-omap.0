From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] DTS: dra7: Add "opp_high" opp node to support 1.5 GHz
 SoC operation
Date: Fri, 3 Feb 2017 17:14:27 -0600
Message-ID: <CAGo_u6qiXnmMCXs=NB=L6E1Ecguo_1MAHap9bi1G-5rVbaiN7g@mail.gmail.com>
References: <1486135491-14223-1-git-send-email-lukma@denx.de>
 <1486135491-14223-2-git-send-email-lukma@denx.de> <f17ceda2-45e0-9c67-7c8a-5a35132a2d0a@ti.com>
 <20170204000615.4417940f@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170204000615.4417940f@jawa>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Russell King <linux@armlinux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, dt list <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 3, 2017 at 5:06 PM, Lukasz Majewski <lukma@denx.de> wrote:
[...]
>> > +           opp_high@1500000000 {
>> > +                   opp-hz = /bits/ 64 <1500000000>;
>> > +                   opp-microvolt = <1210000 950000 1250000>;
>> > +           };
>> >     };
>> >
>> >     /*
>> >
>> Please keep this out of the way till we get the AVS class0 integrated
>> in. devices wont be save at 1.5GHz without the opp powerdomain + AVS
>> Class0 implementation.
>>
>
> Yes, correct. My AM5728 works with this opp, but AM5718 hangs when this
> frequency is enabled.

Right, and if you leave it on for too long without avs class0, you
might need a new silicon as well :(

If you'd like to help, I saw Dave's response, it will be good if you
can help us get the dependencies out of the way to enable 1.5G
cleanly.
-- 
---
Regards,
Nishanth Menon
