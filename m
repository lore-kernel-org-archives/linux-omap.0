From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: omap3-overo: Add support for pwm-leds
Date: Thu, 24 Jan 2013 22:14:37 +0100
Message-ID: <5101A43D.7080108@epfl.ch>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
 <1358963812-19947-2-git-send-email-florian.vaussard@epfl.ch>
 <5101510C.9050407@ti.com> <51015663.8080109@epfl.ch>
 <5101570A.1030303@ti.com> <5101663C.7020301@epfl.ch> <51016A84.20703@ti.com>
Reply-To: florian.vaussard-p8DiymsW2f8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51016A84.20703-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi

>>
>>>> I am working on a patch for pwm-twl-led to defer using a workqueue right now.
>>>
>>> Great!
>>> The only thing I worry about is the latency we are going to get with the
>>> workqueue.
>>>
>>
>> If the latency becomes critical, we can create our own workqueue.
>
> Hrm, when we handled the led via gpio-leds it was also going through the same
> path at the end, via i2c to twl4030.
> I think the fix for this is going to be needed in the pwm core level. Just
> need to look at the gpio code to have similar handling of might_sleep interfaces.
>

You are right. But then the pwm core must provide a way to know if the 
pwm access function are callable
from atomic context or not (the gpio framework provides gpio_cansleep()).
This implies a good amount of changes to the pwm framework, and 
currently we are the only driver using
non-atomic access.

I will take a closer look to the complexity of this solution tomorrow.

Florian
