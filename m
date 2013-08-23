From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v4] extcon: palmas: Added a new compatible type *ti,palmas-usb-vid*
Date: Fri, 23 Aug 2013 13:17:34 -0600
Message-ID: <5217B54E.8070009@wwwdotorg.org>
References: <1377160283-26934-1-git-send-email-kishon@ti.com> <5216798E.8070900@wwwdotorg.org> <52174755.8030506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <52174755.8030506@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: bcousson@baylibre.com, tony@atomide.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob@landley.net, george.cherian@ti.com, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On 08/23/2013 05:28 AM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Friday 23 August 2013 02:20 AM, Stephen Warren wrote:
>> On 08/22/2013 02:31 AM, Kishon Vijay Abraham I wrote:
>>> The Palmas device contains only a USB VBUS-ID detector, so added a
>>> compatible type *ti,palmas-usb-vid*. Didn't remove the existing compatible
>>> types for backward compatibility.
>>
>>> diff --git a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
>>
>>>  PALMAS USB COMPARATOR
>>>  Required Properties:
>>> - - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb"
>>> + - compatible : Should be "ti,palmas-usb-vid". "ti,twl6035-usb" and
>>> +   "ti,palmas-usb" is deprecated and is kept for backward compatibility.
>>
>> So this defines one new value and deprecates the two old values.
> 
> yeah.
>>
>> Why isn't a new "ti,twl6035-usb-vid" entry useful? Don't you still need
> 
> yeah, it should be added too.
>> SoC-specific compatible values so the driver can enable any SoC-specific
>> bug-fixes/workarounds later if needed?
> 
> hmm.. Palmas is external to SoC. So not sure if adding SoC specific compatible
> values is such a good idea.

In this case, but SoC, I meant the Palmas chip rather than the
application processor. Is twl6035 a name for Palmas or something else?

