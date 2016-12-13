From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: mfd: Remove TPS65217 interrupts
Date: Tue, 13 Dec 2016 15:09:23 -0600
Message-ID: <CAL_JsqJL-oh9FwXSH=R2Vr1J2TDD1LqHfFY2es88rsq4Jz7DjQ@mail.gmail.com>
References: <20161209062833.5768-1-woogyom.kim@gmail.com> <20161209062833.5768-3-woogyom.kim@gmail.com>
 <20161212172511.5nj7whzytpkmrk7z@rob-hp-laptop> <fe4985c0-d60a-2562-12a7-064404efd64c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fe4985c0-d60a-2562-12a7-064404efd64c@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milo Kim <woogyom.kim@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 12, 2016 at 5:24 PM, Milo Kim <woogyom.kim@gmail.com> wrote:
> On 12/13/2016 02:25 AM, Rob Herring wrote:
>>
>> On Fri, Dec 09, 2016 at 03:28:31PM +0900, Milo Kim wrote:
>>>
>>> Interrupt numbers are from the datasheet, so no need to keep them in
>>> the ABI. Use the number in the DT file.
>>
>> I don't see the purpose of ripping this out. The headers have always
>> been for convienence, not whether the values come from the datasheet or
>> not.
>
>
> My understanding is it's a same rule as other interrupt controllers.

Oh yes, that's true. We never use defines for interrupts. In that case:

Acked-by: Rob Herring <robh@kernel.org>

Rob
