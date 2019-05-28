From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCHv6 0/4] omapdrm: DSI command mode panel support
Date: Tue, 28 May 2019 15:21:40 +0530
Message-ID: <00eb938e-00be-0601-8a60-9736fa5eeb5c@ti.com>
References: <20190523200756.25314-1-sebastian.reichel@collabora.com>
 <60c45d23-de2f-d94a-c3d7-146a2bee538f@ti.com>
 <20190527112122.GJ5447@atomide.com>
 <e507c415-38de-86fe-9265-4b0aed0d7224@ti.com>
 <20190528093952.GM5447@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190528093952.GM5447@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org



On 28/05/19 3:09 PM, Tony Lindgren wrote:
> Hi,
> 
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [190528 09:19]:
>> On 27/05/2019 14:21, Tony Lindgren wrote:
>>
>>>> Looks good to me. For some reason I can't boot 5.2-rc2 (on x15) so I haven't
>>>> been able to test yet. I'll pick the series up in any case, and I'll test it
>>>> when I get the kernel booting.
>>>
>>> Great good to have these merged finally :)
>>>
>>> Hmm I wonder if some x15 models are affected by the SoC variant
>>> changes queued in my fixes branch?
>>
>> This is what I see with earlycon, on linux-omap fixes branch. I think this looks
>> similar to what I saw with dra76 _without_ the fixes.
> 
> OK sounds like we need to use some different SoC specific .dtsi file,
> is this maybe x15 rev c?
> 
> You can detect which modules fail based on the module base address
> for revision register seen with the following debug patch. Then
> those need to be tagged with status = "disabled" at the module
> level in the SoC specific dtsi file.


Tomi,

My first suspect would be rtc.

diff --git a/arch/arm/boot/dts/am5728.dtsi b/arch/arm/boot/dts/am5728.dtsi
index 82e5427ef6a9..17b1b1b4db92 100644
--- a/arch/arm/boot/dts/am5728.dtsi
+++ b/arch/arm/boot/dts/am5728.dtsi
@@ -31,3 +31,7 @@
  &atl_tm {
         status = "disabled";
  };
+
+&rtctarget {
+       status = "disabled";
+};

Regards,
Keerthy
> 
> Regards,
> 
> Tony
> 
> 8< --------------
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -2069,6 +2069,8 @@ static int sysc_probe(struct platform_device *pdev)
>   	struct sysc *ddata;
>   	int error;
>   
> +	dev_info(&pdev->dev, "probing device\n");
> +
>   	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
>   	if (!ddata)
>   		return -ENOMEM;
> 
