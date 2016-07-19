From: "R, Vignesh" <vigneshr@ti.com>
Subject: Re: [RFC PATCH 1/2] Input: rotary-encoder- Add support for absolute
 encoder
Date: Tue, 19 Jul 2016 18:34:40 +0530
Message-ID: <70fe4260-ffec-e069-25c6-bcc93ccbfb0a@ti.com>
References: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
 <1463648641-6931-2-git-send-email-vigneshr@ti.com>
 <20160520163404.GC14951@dtor-ws> <5742CB03.8010805@ti.com>
 <574565ED.3060205@ti.com> <576283AF.9090107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <576283AF.9090107@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jonathan Corbet <corbet@lwn.net>, Johan Hovold <johan@kernel.org>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Masanari Iida <standby24x7@gmail.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, S Twiss <stwiss.opensource@diasemi.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Moritz Fischer <moritz.fischer@ettus.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Timo Teras <timo.teras@iki.fi>, Guido Martinez <guido@vanguardiasur.com.ar>, Clifton Barnes <clifton.a.barnes@gmail.com>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kern>
List-Id: linux-omap@vger.kernel.org

Dmitry,

On 6/16/2016 4:17 PM, Vignesh R wrote:
[...]
>>> On 5/20/2016 10:04 PM, Dmitry Torokhov wrote:
>>>> On Thu, May 19, 2016 at 02:34:00PM +0530, Vignesh R wrote:
>>>>> There are rotary-encoders where GPIO lines reflect the actual position
>>>>> of the rotary encoder dial. For example, if dial points to 9, then four
>>>>> GPIO lines connected to the rotary encoder will read HLLH(1001b = 9).
>>>>> Add support for such rotary-encoder.
>>>>> The driver relies on rotary-encoder,absolute-encoder DT property to
>>>>> detect such encoders.
>>>>> Since, GPIO IRQs are not necessary to work with
>>>>> such encoders, optional polling mode support is added using
>>>>> input_poll_dev skeleton. This is can be used by enabling
>>>>> CONFIG_INPUT_GPIO_ROTARY_ENCODER_POLL_MODE_SUPPORT.
>>>>
>>>> Does this really belong to a rotary encoder and not a new driver that
>>>> simply translates gpio-encoded value into ABS* event?
>>>>
>>>
>>> Currently rotary encoder driver only supports incremental/step counting
>>> rotary devices. However, the device that is there on am335x-ice is an
>>> absolute encoder but, IMO, nevertheless a kind of rotary encoder. The
>>> only difference is that there is no need to count steps and the absolute
>>> position value is always available as binary encoded state of connected
>>> GPIOs.
>>> The hardware on am335x-ice is a mechanical rotary encoder switch
>>> connected over 4 GPIOs. It is same as binary encoder described at [1]
>>> (except there are 4 GPIO lines), so this lead me to add support in
>>> rotary-encoder.
>>>
>>> [1]https://en.wikipedia.org/wiki/Rotary_encoder#Standard_binary_encoding
>>>
>>
>> Could you please comment on how would you like to support above
>> described encoder: As a new driver or with existing driver with new
>> compatible/mode setting via DT or as suggest by Uwe in another reply?
>> IMHO, supporting using existing driver with new mode/compatible string
>> looks a better option as the hardware is a kind of rotary-encoder.
>>

Could you please suggest the right solution here? Do you think new
driver is need to support above described absolute encoder h/w? It would
be great to have your input now, so that I can work on the new set of
patches and submit them for v4.9 merge window as soon as v4.8 merge
window closes?

Regards
Vignesh
