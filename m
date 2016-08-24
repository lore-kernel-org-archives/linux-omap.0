From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v3 0/2] AM335x-ICE: Add support for rotary switch
Date: Wed, 24 Aug 2016 14:45:17 +0530
Message-ID: <5294e820-4946-a196-549f-76a349b6606d@ti.com>
References: <20160824075859.30979-1-vigneshr@ti.com>
 <c5385d42-14e4-d5ca-370e-5b04e37d873d@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c5385d42-14e4-d5ca-370e-5b04e37d873d@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Daniel Hung-yu Wu <hywu@google.com>, Grant Grundler <grundler@chromium.org>, S Twiss <stwiss.opensource@diasemi.com>, Moritz Fischer <moritz.fischer@ettus.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, John Stultz <john.stultz@linaro.org>, "Andrew F . Davis" <afd@ti.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wednesday 24 August 2016 02:05 PM, Daniel Mack wrote:
> Hi,
> 
> On 08/24/2016 09:58 AM, Vignesh R wrote:
>> This series adds support for rotary-switch on AM335x-ICE that is
>> connected to TI PCA9536 I2C GPIO expander.
>> First patch adds new generic driver to read status of group of GPIO
>> lines and report the value as an input event. The second patch adds DT
>> entries for the same.
>>
>> v2: https://lkml.org/lkml/2016/8/23/111
>> v1: https://lkml.org/lkml/2016/8/12/7
> 
> Is there a reason why the rotary-encoder driver cannot handle this?
> Commit 7dde4e74744 ("Input: rotary-encoder - support more than 2 gpios
> as input") added support for that mode AFAIU.
> 

Rotary encoder driver handles incremental encoders only and does not
support absolute encoders. The rotary switch on am335x-ice is different
from the incremental encoders in the
sense that GPIO line status directly reflect the position(number)
pointed by the dial of the encoder. So, there is no need to count steps
or know the direction of rotation as it does not matter.

I did try to enhance rotary-encoder driver to support absolute
encoder[1] but the comment there was to write new driver that simply
translates gpio-encoded value into ABS* event. Indeed, the new driver
looks more simple and can handle more such hardwares.

[1] https://lkml.org/lkml/2016/5/19/98


-- 
Regards
Vignesh
