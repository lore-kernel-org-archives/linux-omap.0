From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH 1/2] extcon: palmas: Added a new compatible type *ti,
 palmas-usb-vid*
Date: Thu, 15 Aug 2013 18:09:54 +0200
Message-ID: <520CFD52.4060103@baylibre.com>
References: <1376302675-15795-1-git-send-email-kishon@ti.com> <1376372241-15573-1-git-send-email-kishon@ti.com> <520A8555.10401@wwwdotorg.org> <520B14A1.8030809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <520B14A1.8030809@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, mark.rutland@arm.com, devicetree@vger.kernel.org, george.cherian@ti.com, linux@arm.linux.org.uk, ian.campbell@citrix.com, pawel.moll@arm.com, linux-doc@vger.kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com, balbi@ti.com, rob@landley.net, benoit.cousson@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Kishon,

On 14/08/2013 07:24, Kishon Vijay Abraham I wrote:
> Hi,
>
> On Wednesday 14 August 2013 12:43 AM, Stephen Warren wrote:
>> On 08/12/2013 11:37 PM, Kishon Vijay Abraham I wrote:
>>> The Palmas device contains only a USB VID detector, so added a
>>> compatible type *ti,palmas-usb-vid*. Dint remove the existing compatible
>>
>> s/Dint/Didn't/
>>
>>> diff --git a/Documentation/devicetree/bindings/extcon/extcon-twl.txt b/Documentation/devicetree/bindings/extcon/extcon-twl.txt
>>
>>>   PALMAS USB COMPARATOR
>>>   Required Properties:
>>> - - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb"
>>> + - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb" or
>>> +   "ti,palmas-usb-vid".
>>
>> So are ti,palmas-usb and ti,twl6035-usb full EHCI controllers then?
>
> No. I thought I shouldn't remove those if someone is already using those
> compatible value.

Well, I think we still have a short period of time where we can clean 
some badly defined bindings before it is really too late.

Both kernel and DTS are still in sync for the moment, so changing both 
at the same time should be safe.

Regards,
Benoit
