From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
Date: Tue, 11 Sep 2018 16:48:16 -0500
Message-ID: <85ab3bf4-21d4-dda9-a7c8-5ed68f15c611@ti.com>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-2-dmurphy@ti.com> <20180911200530.GA28290@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911200530.GA28290@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: robh+dt@kernel.org, jacek.anaszewski@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Pavel

On 09/11/2018 03:05 PM, Pavel Machek wrote:
> On Tue 2018-09-11 12:08:20, Dan Murphy wrote:
>> Remove support for the LM3697 LED device
>> from the ti-lmu.  The LM3697 will be supported
>> via a stand alone LED driver.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> 
> I'd really like to see better explanation here.
> 

I will update the commit message but....

How do I politely explain that the original implementation was wrong for certain devices?
How do I politely explain that this binding has information that does not exist?
Isn't code and documentation supposed to be pushed in stages together?
Like document the current supported source features and then submit patches to amend new
features or changes to the source.  I did that in this series
where I introduced the driver and when I added a feature I added the binding information.

Unfortunately Milo left TI before he had a chance to finish upstreaming.

Some issues with the current binding:
1) The documentation referenced in the ti-lmu.txt does not exist but the binding was accepted.
[1] ../leds/backlight/ti-lmu-backlight.txt
[2] ../leds/leds-lm3633.txt
[3] ../regulator/lm363x-regulator.txt

2) ramp-up-msec and ramp-down-msec are not explained or defined in this current binding.
Looks to be defined in the staged code though.

3) The ramp-up-msec and ramp-down-msec are not the right node parameters
the code shows ti,ramp-down-ms and ti,ramp-up-ms.  Looking at the clean up of the binding
in the staged commits the binding still does not match the code.

https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/commit/?h=droid4-pending-v4.19&id=d774c7e447ac911e73a1b3c775e6d89f0422218c

4) The ramp rates ranges are incorrect for the LM3697 it should be from 0 -> 117400 ms

5) The children compatibles are not defined in this binding but appear to be removed in the staged code.

6) address-cells and size-cells are missing from the binding

I am attempting to clean this up for all the dedicated LED drivers.
There is a lot of bloat with this driver to support a single LED driver that is a single function device.

This ti-lmu driver may be a great thing for the Droid 4 but from a customers
stand point that just wants to use just 1 of the dedicated LED drivers this driver is
overly complex and possibly hard to add code for differentiation.

> We have existing binding, for lm3697 and similar devices. With this
> series, different binding is introduced, without documented reason.
> 

I can update the commit message to indicate that this device is not a MFD
device and only is a SFD that needs to be supported by a dedicated driver.

> That's bad.

This ti-lmu binding is more misleading in the current state.

> 
> Now, maybe you are right and the hardware should be handled by
> drivers/leds, not drivers/mfd. But we should have solution for all the
> similar chips, and that still does not mean we have to modify the
> binding. (But maybe we want to move it to different
> directory). Bindings are supposed to describe hardware, not mirror
> structure of our drivers.

But this is not clean to have this device in the MFD bindings directory
when the support is in the LEDs directory.

I am working on creating driver for the other single function devices.
It will take some time.  I am waiting on the hardware to come in.

> 
> Unless there's something fatally wrong with the binding... but in such
> case we'd like to know what is wrong.
> 
> [And yes, I recognize current situation is ... not ideal and I'm
> willing to help. But I'm not sure this is step in right direction.]

It will take some time to get this all cleaned up.  But I am willing to
get this done.

Dan

> 
> Thanks,
> 								Pavel
> 
> 
>> ---
>>
>> v7 - New change for the series based on the comments in https://lore.kernel.org/patchwork/patch/982550/
>>
>>  .../devicetree/bindings/mfd/ti-lmu.txt        | 26 +------------------
>>  1 file changed, 1 insertion(+), 25 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
>> index c885cf89b8ce..920f910be4e9 100644
>> --- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
>> +++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
>> @@ -9,7 +9,6 @@ TI LMU driver supports lighting devices below.
>>    LM3632       Backlight and regulator
>>    LM3633       Backlight, LED and fault monitor
>>    LM3695       Backlight
>> -  LM3697       Backlight and fault monitor
>>  
>>  Required properties:
>>    - compatible: Should be one of:
>> @@ -18,11 +17,10 @@ Required properties:
>>                  "ti,lm3632"
>>                  "ti,lm3633"
>>                  "ti,lm3695"
>> -                "ti,lm3697"
>>    - reg: I2C slave address.
>>           0x11 for LM3632
>>           0x29 for LM3631
>> -         0x36 for LM3633, LM3697
>> +         0x36 for LM3633
>>           0x38 for LM3532
>>           0x63 for LM3695
>>  
>> @@ -38,7 +36,6 @@ Optional nodes:
>>      Required properties:
>>        - compatible: Should be one of:
>>                      "ti,lm3633-fault-monitor"
>> -                    "ti,lm3697-fault-monitor"
>>    - leds: LED properties for LM3633. Please refer to [2].
>>    - regulators: Regulator properties for LM3631 and LM3632.
>>                  Please refer to [3].
>> @@ -220,24 +217,3 @@ lm3695@63 {
>>  		};
>>  	};
>>  };
>> -
>> -lm3697@36 {
>> -	compatible = "ti,lm3697";
>> -	reg = <0x36>;
>> -
>> -	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
>> -
>> -	backlight {
>> -		compatible = "ti,lm3697-backlight";
>> -
>> -		lcd {
>> -			led-sources = <0 1 2>;
>> -			ramp-up-msec = <200>;
>> -			ramp-down-msec = <200>;
>> -		};
>> -	};
>> -
>> -	fault-monitor {
>> -		compatible = "ti,lm3697-fault-monitor";
>> -	};
>> -};
> 


-- 
------------------
Dan Murphy
