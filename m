From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/2] extcon: palmas: Added a new compatible type *ti,palmas-usb-vid*
Date: Wed, 14 Aug 2013 10:08:25 -0600
Message-ID: <520BAB79.3000202@wwwdotorg.org>
References: <1376302675-15795-1-git-send-email-kishon@ti.com> <1376372241-15573-1-git-send-email-kishon@ti.com> <520A8555.10401@wwwdotorg.org> <520B14A1.8030809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <520B14A1.8030809@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: benoit.cousson@linaro.org, tony@atomide.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob@landley.net, george.cherian@ti.com, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On 08/13/2013 11:24 PM, Kishon Vijay Abraham I wrote:
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
>>>  PALMAS USB COMPARATOR
>>>  Required Properties:
>>> - - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb"
>>> + - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb" or
>>> +   "ti,palmas-usb-vid".
>>
>> So are ti,palmas-usb and ti,twl6035-usb full EHCI controllers then?
> 
> No. I thought I shouldn't remove those if someone is already using those
> compatible value.

Sigh. Perhaps it's best to be consistent with the existing bad naming
then:-(

