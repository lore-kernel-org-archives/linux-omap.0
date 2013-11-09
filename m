From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: doc: Document missing binding for ti-sdma
 controller
Date: Sat, 9 Nov 2013 17:23:50 +0530
Message-ID: <527E224E.5020405@ti.com>
References: <1383907129-7325-1-git-send-email-r.sricharan@ti.com> <1383907129-7325-2-git-send-email-r.sricharan@ti.com> <CAL_JsqLT0zOMDEQD5gkvTN2KYD2D--=pM6xgwQqPQOmkgcQBVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLT0zOMDEQD5gkvTN2KYD2D--=pM6xgwQqPQOmkgcQBVg@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-doc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Hi Rob,

On Saturday 09 November 2013 03:24 AM, Rob Herring wrote:
> On Fri, Nov 8, 2013 at 4:38 AM, Sricharan R <r.sricharan@ti.com> wrote:
>> The binding and support for system DMA module present in OMAP2+ Socs
>> and DRA7 with dma-engine is already present. So adding the missing
>> documentation for the same.
>>
>> Cc: Benoit Cousson <bcousson@baylibre.com>
>> Signed-off-by: Sricharan R <r.sricharan@ti.com>
>> ---
>>  Documentation/devicetree/bindings/dma/ti-sdma.txt |   28 +++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/dma/ti-sdma.txt
>>
>> diff --git a/Documentation/devicetree/bindings/dma/ti-sdma.txt b/Documentation/devicetree/bindings/dma/ti-sdma.txt
>> new file mode 100644
>> index 0000000..7fb2342
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/ti-sdma.txt
>> @@ -0,0 +1,28 @@
>> +TI SDMA
>> +
>> +Required Properties:
>> +- compatible : Should be "ti,omap2420-sdma", "ti,omap2430-sdma" for OMAP2
>> +               Should be "ti,omap3430-sdma", "ti,omap3630-sdma" for OMAP3
>> +               Should be "ti,omap4430-sdma" for OMAP4, OMAP5 and DRA7
>> +- reg: Memory map for accessing module
>> +- interrupts: Interrupt request number from the dma controller to
> s/dma/DMA/
>
>> +             interrupt controller
>> +- dma-cells: Should be set to <1>
>> +- dma-channels: Total number of logical DMA channels supported by the
>> +               controller
>> +- dma-requests: Total number of dma request signals supported by the
> s/dma/DMA/
 Ok, will correct case.
>> +               controller
> These should have the # included.
 Sorry, i do not follow this ?

Regards,
 Sricharan

