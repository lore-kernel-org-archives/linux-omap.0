From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] input: misc: Add generic input driver to read encoded
 GPIO lines
Date: Wed, 17 Aug 2016 12:12:24 +0530
Message-ID: <f069755c-8312-c58a-2a52-9c56648299d8@ti.com>
References: <20160812045229.29241-1-vigneshr@ti.com>
 <20160812045229.29241-2-vigneshr@ti.com>
 <20160812185947.GA14685@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20160812185947.GA14685@rob-hp-laptop>
Sender: linux-input-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>, S Twiss <stwiss.opensource@diasemi.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, Moritz Fischer <moritz.fischer@ettus.com>, Daniel Hung-yu Wu <hywu@google.com>, Grant Grundler <grundler@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org



On Saturday 13 August 2016 12:29 AM, Rob Herring wrote:
> On Fri, Aug 12, 2016 at 10:22:28AM +0530, Vignesh R wrote:
>> Add a driver to read group of GPIO lines and provide its status as a
>> numerical value as input event to the system. This will help in
>> intefacing devices, that can be connected over GPIOs, that provide input
>> to the system by driving GPIO lines connected to them like a rotary dial
>> or a switch.
>>
>> For example, a rotary switch can be connected to four GPIO lines. The
>> status of the GPIO lines reflect the actual position of the rotary
>> switch dial. For example, if dial points to 9, then the four GPIO lines
>> connected to the switch will read HLLH(0b'1001 = 9). This value
>> can be reported as an ABS_* event to the input subsystem.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  .../devicetree/bindings/input/gpio-decoder.txt     |  23 ++++
>>  drivers/input/misc/Kconfig                         |  12 ++
>>  drivers/input/misc/Makefile                        |   1 +
>>  drivers/input/misc/gpio_decoder.c                  | 128 +++++++++++++++++++++
>>  4 files changed, 164 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/input/gpio-decoder.txt
>>  create mode 100644 drivers/input/misc/gpio_decoder.c
>>
>> diff --git a/Documentation/devicetree/bindings/input/gpio-decoder.txt b/Documentation/devicetree/bindings/input/gpio-decoder.txt
>> new file mode 100644
>> index 000000000000..efd947f52cb3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/gpio-decoder.txt
>> @@ -0,0 +1,23 @@
>> +* GPIO Decoder DT bindings
>> +
>> +Required Properties:
>> +- compatible: should be "gpio-decoder"
>> +- gpios: a spec of gpios (atleast two) to be decoded to a number with
>> +  first entry representing the MSB.
>> +
>> +Optional Properties:
>> +- gpio-decoder,max-value: Maximum possible value that can be reported by
> 
> Just "decoder-max-value".

Agreed. I will wait for any comments for the driver part, before sending
the next version.

> 
> With that, the binding looks fine to me:
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

Thanks!

-- 
Regards
Vignesh
