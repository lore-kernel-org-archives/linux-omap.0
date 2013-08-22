From: George Cherian <george.cherian@ti.com>
Subject: Re: [PATCH 1/2] extcon: extcon-dra7xx: Add extcon driver for USB
 ID detection
Date: Thu, 22 Aug 2013 10:44:31 +0530
Message-ID: <52159E37.90501@ti.com>
References: <1376648029-30659-1-git-send-email-george.cherian@ti.com> <1376648029-30659-2-git-send-email-george.cherian@ti.com> <52127284.6030506@wwwdotorg.org> <521312CC.8060003@ti.com> <52139F0F.6090507@wwwdotorg.org> <5214BB6C.3060903@ti.com> <5214FA64.3040902@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5214FA64.3040902@wwwdotorg.org>
Sender: linux-doc-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: balbi@ti.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, grant.likely@linaro.org, rob@landley.net, ian.campbell@citrix.com, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

On 8/21/2013 11:05 PM, Stephen Warren wrote:
> On 08/21/2013 07:06 AM, George Cherian wrote:
>> Hi Stephen,
>>
>> On 8/20/2013 10:23 PM, Stephen Warren wrote:
>>>>> ID pins are connected to pcf8575, and the pcf8575's interrupt line is
>>>>> inturn connected to
>>>>> gpio bank6 pin 11, we use this gpio interrupt to detect the ID pin
>>>> change.
>>> In that case, the PCF8575 node needs to be a GPIO controller and an IRQ
>>> controller, as does the driver for the PCF8575. This binding should have
>>> a single entry in the gpios property, and the driver can call
>>> gpio_to_irq() on that so it knows which IRQ to request.
>> You meant some thing like this?
>>
>>         pcf_usb: pcf8575@21 {
>>                  compatible = "ti,pcf8575";
>>                  reg = <0x21>;
>>                  gpio-controller;
>>                  #gpio-cells = <2>;
>>                  interrupt-parent = <&gpio6>;
>>                  interrupts = <11 2>;
>>                  interrupt-controller;
>>                  #interrupt-cells = <2>;
>>       };
>>
>>       usb_vid_gpio {
>>                  compatible = "ti,dra7xx-usb";
>>                  gpios = <&pcf_usb 1 0>;
>>       };
> Yes.
>
> Except that the compatible value for the usb_vid_gpio node still looks
> wrong, since I think that node isn't anything to do with any particular SoC.

Yes will fix that too in v2.


-- 
-George

