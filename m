From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v4] extcon: palmas: Added a new compatible type *ti,
 palmas-usb-vid*
Date: Mon, 26 Aug 2013 17:33:19 +0530
Message-ID: <521B4407.2090600@ti.com>
References: <1377160283-26934-1-git-send-email-kishon@ti.com>
 <5216798E.8070900@wwwdotorg.org> <52174755.8030506@ti.com>
 <5217B54E.8070009@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5217B54E.8070009@wwwdotorg.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, george.cherian@ti.com, linux@arm.linux.org.uk, ian.campbell@citrix.com, pawel.moll@arm.com, linux-doc@vger.kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com, balbi@ti.com, rob@landley.net, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Saturday 24 August 2013 12:47 AM, Stephen Warren wrote:
> On 08/23/2013 05:28 AM, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Friday 23 August 2013 02:20 AM, Stephen Warren wrote:
>>> On 08/22/2013 02:31 AM, Kishon Vijay Abraham I wrote:
>>>> The Palmas device contains only a USB VBUS-ID detector, so added a
>>>> compatible type *ti,palmas-usb-vid*. Didn't remove the existing compatible
>>>> types for backward compatibility.
>>>
>>>> diff --git a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
>>>
>>>>  PALMAS USB COMPARATOR
>>>>  Required Properties:
>>>> - - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb"
>>>> + - compatible : Should be "ti,palmas-usb-vid". "ti,twl6035-usb" and
>>>> +   "ti,palmas-usb" is deprecated and is kept for backward compatibility.
>>>
>>> So this defines one new value and deprecates the two old values.
>>
>> yeah.
>>>
>>> Why isn't a new "ti,twl6035-usb-vid" entry useful? Don't you still need
>>
>> yeah, it should be added too.
>>> SoC-specific compatible values so the driver can enable any SoC-specific
>>> bug-fixes/workarounds later if needed?
>>
>> hmm.. Palmas is external to SoC. So not sure if adding SoC specific compatible
>> values is such a good idea.
> 
> In this case, but SoC, I meant the Palmas chip rather than the
> application processor. Is twl6035 a name for Palmas or something else?

yeah, tw6035 is a name for palmas.

Thanks
Kishon
