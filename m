From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH v3 0/3] Adding DT support for TI HECC module
Date: Fri, 17 Feb 2017 10:23:33 +0100
Message-ID: <CAGm1_kvN_SiFS69aKRsJ-Hm9bjgVskYiONh_bTUGLhRozrKF_A@mail.gmail.com>
References: <1487170125-10815-1-git-send-email-yegorslists@googlemail.com>
 <7c8fb14d-835b-d1d0-ca4f-4d184b711ae0@pengutronix.de> <CAGm1_kuQ1skHayOKu16JdZ3Bah+=CqzZJ5e6j2VDj3WW5No2vw@mail.gmail.com>
 <b6c8bfbe-1748-ee2c-2129-96e1bce9b324@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <b6c8bfbe-1748-ee2c-2129-96e1bce9b324@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, robh+dt@kernel.org, Tony Lindgren <tony@atomide.com>, Andrey Skvortsov <andrej.skvortzov@gmail.com>, hs@denx.de, Anton Glukhov <anton.a.glukhov@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 17, 2017 at 9:51 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 02/17/2017 09:50 AM, Yegor Yefremov wrote:
>> On Fri, Feb 17, 2017 at 9:46 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>> On 02/15/2017 03:48 PM, yegorslists@googlemail.com wrote:
>>>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>>>
>>>> This is an attempt to revive DT support for TI HECC that was started in 2015 [1].
>>>>
>>>> Changes v2 -> v3:
>>>>   - rename compatible property to "ti,am3517-hecc" (though there is a stipped
>>>>     device named 3505, EMAC driver already uses am3517-emac name, so keep this
>>>>     property consistent)
>>>>   - use reg-names to specify different HECC I/O mapping (suggested by Tony Lindgren)
>>>>   - provide fallback offsets and sizes for board files
>>>
>>> Are there any board files using te_hecc intree? I don't see any on the
>>> first glance. What about making the driver DT only?
>>
>> Good idea. I aslo wanted to ask this. So this means we could
>> completely get rid of include/linux/can/platform/ti_hecc.h?
>
> If there isn't any in-tree user, thes yes.

Btw. what should we do about "@transceiver_switch: platform specific
callback fn for transceiver control"? Model it via something like
this:

enable-gpios = <&gpio6 15 GPIO_ACTIVE_HIGH>; /* gpio 175 */

Yegor
