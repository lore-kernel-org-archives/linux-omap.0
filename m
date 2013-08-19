From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2] extcon: palmas: Modified the compatible type to *ti,
 palmas-usb-vid*
Date: Mon, 19 Aug 2013 14:59:07 +0530
Message-ID: <5211E563.6080200@ti.com>
References: <1376648448-27447-1-git-send-email-kishon@ti.com>
 <520EA5D6.3040409@wwwdotorg.org> <5211A7B3.4040906@ti.com>
 <5211DBB4.6090508@ti.com> <5211E45B.1010109@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5211E45B.1010109@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, george.cherian@ti.com, linux@arm.linux.org.uk, ian.campbell@citrix.com, pawel.moll@arm.com, Stephen Warren <swarren@wwwdotorg.org>, tony@atomide.com, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, myungjoo.ham@samsung.com, balbi@ti.com, rob@landley.net, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Monday 19 August 2013 02:54 PM, Chanwoo Choi wrote:
> On 08/19/2013 05:47 PM, Kishon Vijay Abraham I wrote:
>> On Monday 19 August 2013 10:35 AM, Kishon Vijay Abraham I wrote:
>>> Hi,
>>>
>>> On Saturday 17 August 2013 03:51 AM, Stephen Warren wrote:
>>>> On 08/16/2013 04:20 AM, Kishon Vijay Abraham I wrote:
>>>>> The Palmas device contains only a USB VID detector, so modified the
>>>>> compatible type to *ti,palmas-usb-vid*.
>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
>>>>
>>>>>  PALMAS USB COMPARATOR
>>>>>  Required Properties:
>>>>> - - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb"
>>>>> + - compatible : Should be "ti,palmas-usb-vid".
>>>>
>>>> Has the old value been published in a release kernel? If so, it makes
>>>
>>> No. This was merged only in 3.11-rc1. So I think we should take this version?
>>> Chanwoo can you take this patch?
>>
>> Ah.. the old values will be part of 3.11 kernel. So should we retain the old
>> values?
> 
> What is the meaning of old value? previous value related to extcon-twl.txt?

We were discussing on whether to have "ti,palmas-usb" or "ti,twl6035-usb" in
compatible value in addition to "ti,palmas-usb-vid". Stephen wanted the old
values ("ti,palmas-usb" or "ti,twl6035-usb") if it has been published in a
release kernel.
> 
> The extcon-twl.txt was included in 3.11 kernel

Right. Since it's part of 3.11 kernel, I think we should retain the old
compatible values.

Thanks
Kishon
