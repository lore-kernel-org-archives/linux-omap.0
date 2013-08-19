From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2] extcon: palmas: Modified the compatible type to *ti,palmas-usb-vid*
Date: Mon, 19 Aug 2013 10:11:45 -0600
Message-ID: <521243C1.3070701@wwwdotorg.org>
References: <1376648448-27447-1-git-send-email-kishon@ti.com> <520EA5D6.3040409@wwwdotorg.org> <5211A7B3.4040906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5211A7B3.4040906@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: cw00.choi@samsung.com, bcousson@baylibre.com, tony@atomide.com, myungjoo.ham@samsung.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob@landley.net, george.cherian@ti.com, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On 08/18/2013 11:05 PM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Saturday 17 August 2013 03:51 AM, Stephen Warren wrote:
>> On 08/16/2013 04:20 AM, Kishon Vijay Abraham I wrote:
>>> The Palmas device contains only a USB VID detector, so modified the
>>> compatible type to *ti,palmas-usb-vid*.
>>
>>> diff --git a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
>>
>>>  PALMAS USB COMPARATOR
>>>  Required Properties:
>>> - - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb"
>>> + - compatible : Should be "ti,palmas-usb-vid".
>>
>> Has the old value been published in a release kernel? If so, it makes
> 
> No. This was merged only in 3.11-rc1. So I think we should take this version?
> Chanwoo can you take this patch?

So anything in 3.11-rc1 will make it into 3.11 final, and hence has
already been published, and hence should be an ABI. This current patch
is only going into 3.12, so really should be amended not to break the ABI.
