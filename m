From: "Kozaruk, Oleksandr" <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v8 0/2] TWL6030, TWL6032 GPADC driver
Date: Fri, 16 Aug 2013 06:39:35 +0000
Message-ID: <2A7ABDFCE21540479A5AEB0244A684D5E3EE9C@DNCE04.ent.ti.com>
References: <1374758813-6539-1-git-send-email-oleksandr.kozaruk@ti.com>
 <20130815091216.GB28366@e106331-lin.cambridge.arm.com>
 <520CB566.2050201@kernel.org>
 <20130815125906.GA32421@e106331-lin.cambridge.arm.com>,<520D16EC.90604@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <520D16EC.90604-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Nayak, Rajendra" <rnayak-l0cyMroinI0@public.gmane.org>, "Ujfalusi, Peter" <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, "ABRAHAM, KISHON VIJAY" <kishon-l0cyMroinI0@public.gmane.org>, "jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org" <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org" <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>, "Kim, Milo" <Milo.Kim-l0cyMroinI0@public.gmane.org>, "Krishnamoorthy, Balaji T" <balajitk-l0cyMroinI0@public.gmane.org>, "gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kerne>
List-Id: linux-omap@vger.kernel.org

>On 08/15/13 13:59, Mark Rutland wrote:
>> On Thu, Aug 15, 2013 at 12:03:02PM +0100, Jonathan Cameron wrote:
>>>
>>>>> The changes to the original driver:
>>>>> - device tree adaptation;
>>>>
>>>> I couldn't see a binding document in this series or in mainline. Have I
>>>> looked in the wrong places?
>>>
>>> Nothing explicit supplied, but does it need one given it is doing only
>>> iio bindings (bindings/iio/iio-bindings.txt)
>>> plus twl child bindings
>>> (bindings/mfd/twl-family.txt)
>>
>> Every binding needs to be documented.
>>
>>>
>>> If it does, I guess absolutely everything does, then fair enough!
>>> I guess that would make sense as there is no way for someone writing
>>> a device tree to know that there is nothing else to be specified.
>>
>> Yup, that's why. Also, Linux isn't necessarily the only consumer, and
>> other consumers shouldn't need to read Linux code to figure out how a
>> particular binding is supposed to look.
>>
>Fair enough. Thanks for clearing that up.
>
>Oleksandr, could you send a follow up patch adding the required documentation?
>(mostly a cut and paste job from similar elements by the look of it).
>

Hello,

Is this good enough?

>From 211e81ff4a146d9ec27443696a429e795c58dc30 Mon Sep 17 00:00:00 2001
From: Oleksandr Kozaruk <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>
Date: Thu, 15 Aug 2013 16:14:11 +0300
Subject: [PATCH] iio: adc: Add bindigs documentation for twl6030 GPADC

Add required documentation for twl6030 GPADC device tree
bindings.

Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/iio/adc/twl6030-gpadc.txt          | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/twl6030-gpadc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/twl6030-gpadc.txt b/Documentation/devicetree/bindings/iio/adc/twl6030-gpadc.txt
new file mode 100644
index 0000000..6829420
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/twl6030-gpadc.txt
@@ -0,0 +1,14 @@
+Texas Instruments twl6030/twl6032 GPADC device driver
+
+Required properties:
+       - compatible: must be "ti,twl6030-gpadc" for TWL6030 or
+         "ti,twl6032-gpadc" for TWL6032
+       - interrupts: interrupt number associated with it
+       - #io-channel-cells: must be <1> - multiple IIO outputs
+
+Example:
+       adc {
+               compatible = "ti,twl6030-gpadc";
+               interrupts = <3>;
+               #io-channel-cells = <1>;
+       };

-- 
1.8.1.2
