From: Milo Kim <woogyom.kim@gmail.com>
Subject: Re: [PATCH v2 5/8] dt-bindings: mfd: Provide human readable defines
 for TPS65217 interrupts
Date: Mon, 21 Nov 2016 22:05:21 +0900
Message-ID: <c04af1ac-b692-f3df-47b0-72c5263374bf@gmail.com>
References: <20161028123702.21849-1-woogyom.kim@gmail.com>
 <20161028123702.21849-6-woogyom.kim@gmail.com>
 <20161118145353.GE2301@dell.home> <20161118151051.GV4082@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161118151051.GV4082@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
Cc: bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>
List-Id: linux-omap@vger.kernel.org

On 11/19/2016 12:10 AM, Tony Lindgren wrote:
>>> +#define TPS65217_IRQ_USB	0
>>> > > +#define TPS65217_IRQ_AC		1
>>> > > +#define TPS65217_IRQ_PB		2
>> >
>> > What are "AC" and "PB".  Seeing as these are meant to be "human
>> > readable", let's make them more human friendly.
> Good idea. Milo, please do an incremental single follow-up patch as
> I already have applied this and the dts changes using it.

Thanks for catching this. Let me send a patch soon.

Best regards,
Milo
