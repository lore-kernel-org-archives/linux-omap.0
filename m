From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/3] arm/dts: add wdt node for omap3 and omap4
Date: Wed, 30 May 2012 09:42:45 -0500
Message-ID: <4FC631E5.9080000@ti.com>
References: <1337942552-28218-1-git-send-email-jgq516@gmail.com>
 <1337942552-28218-2-git-send-email-jgq516@gmail.com>
 <4FC50CCD.7090404@ti.com> <4FC591C9.2050004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4FC591C9.2050004@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Xiao Jiang <jgq516@gmail.com>
Cc: linux@arm.linux.org.uk, b-cousson@ti.com, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, wim@iguana.be, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 05/29/2012 10:19 PM, Xiao Jiang wrote:
> Jon Hunter wrote:
>> On 05/25/2012 05:42 AM, jgq516@gmail.com wrote:
>>  
>>> From: Xiao Jiang <jgq516@gmail.com>
>>>
>>> Add wdt node to support dt.
>>>
>>> Signed-off-by: Xiao Jiang <jgq516@gmail.com>
>>> ---
>>>  arch/arm/boot/dts/omap3.dtsi |    5 +++++
>>>  arch/arm/boot/dts/omap4.dtsi |    5 +++++
>>>  2 files changed, 10 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
>>> index 99474fa..039df5c 100644
>>> --- a/arch/arm/boot/dts/omap3.dtsi
>>> +++ b/arch/arm/boot/dts/omap3.dtsi
>>> @@ -215,5 +215,10 @@
>>>              compatible = "ti,omap3-hsmmc";
>>>              ti,hwmods = "mmc3";
>>>          };
>>> +
>>> +        wdt: wdt@48314000{
>>>     
>>
>> Minor comment, may be call this wdt2 as this is watchdog timer 2. Also
>> ass a space between the address and the "{".
>>
>>   
> Ok, will change it to "wdt2: wdt@48314000 {".
>>> +            compatible = "ti,omap3-wdt";
>>> +            ti,hwmods = "wd_timer2";
>>> +        };
>>>      };
>>>  };
>>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>>> index 359c497..d01403d 100644
>>> --- a/arch/arm/boot/dts/omap4.dtsi
>>> +++ b/arch/arm/boot/dts/omap4.dtsi
>>> @@ -272,5 +272,10 @@
>>>              ti,hwmods = "mmc5";
>>>              ti,needs-special-reset;
>>>          };
>>> +
>>> +        wdt: wdt@4a314000{
>>>     
>>
>> Same as above.
>>
>>   
> Ditto.
>>> +            compatible = "ti,omap4-wdt";
>>> +            ti,hwmods = "wd_timer2";
>>> +        };
>>>      };
>>>  };
>>>     
>>
>> Also we should add some documentation to describe the binding. Here it
>> is very simple, but nonetheless we should have something as we have for
>> gpio [1].
>>
>>   
> Thanks for reminding, how about below patch?
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
> b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
> new file mode 100644
> index 0000000..4272d06
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
> @@ -0,0 +1,15 @@
> +TI Watchdog Timer (WDT) Controller for OMAP
> +
> +Required properties:
> +- compatible:
> +  - "ti,omap2-wdt" for OMAP2
> +  - "ti,omap3-wdt" for OMAP3
> +  - "ti,omap4-wdt" for OMAP4
> +- ti,hwmods: Name of the hwmod associated to the WDT
> +
> +Examples:
> +
> +wdt2: wdt@73f98000 {
> +       compatible = "ti,omap4-wdt";
> +       ti,hwmods = "wd_timer2";
> +};

Yes looks good. Thanks! Minor nit-pick in the example I would just copy
the omap4 node completely with the actual omap4 address :-)

Cheers
Jon
