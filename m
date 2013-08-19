From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2] extcon: palmas: Modified the compatible type to *ti,palmas-usb-vid*
Date: Mon, 19 Aug 2013 15:56:18 +0530
Message-ID: <5211F2CA.8090206@ti.com>
References: <1376648448-27447-1-git-send-email-kishon@ti.com> <520EA5D6.3040409@wwwdotorg.org> <5211A7B3.4040906@ti.com> <5211DBB4.6090508@ti.com> <5211E45B.1010109@samsung.com> <5211E563.6080200@ti.com> <5211F191.7010303@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5211F191.7010303@baylibre.com>
Sender: linux-doc-owner@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, tony@atomide.com, myungjoo.ham@samsung.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob@landley.net, george.cherian@ti.com, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On Monday 19 August 2013 03:51 PM, Benoit Cousson wrote:
> Hi Kishon,
> 
> On 19/08/2013 11:29, Kishon Vijay Abraham I wrote:
>> On Monday 19 August 2013 02:54 PM, Chanwoo Choi wrote:
>>> On 08/19/2013 05:47 PM, Kishon Vijay Abraham I wrote:
>>>> On Monday 19 August 2013 10:35 AM, Kishon Vijay Abraham I wrote:
>>>>> Hi,
>>>>>
>>>>> On Saturday 17 August 2013 03:51 AM, Stephen Warren wrote:
>>>>>> On 08/16/2013 04:20 AM, Kishon Vijay Abraham I wrote:
>>>>>>> The Palmas device contains only a USB VID detector, so modified the
>>>>>>> compatible type to *ti,palmas-usb-vid*.
>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
>>>>>>> b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
> 
> That file is not yet in 3.11. Only the twl is there.
> Is this one a rename of the twl one?

yes Benoit. This is the commit
http://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git/commit/?h=extcon-next&id=80d644b297dc26c5126858555044edef76f4ffe8

Thanks
Kishon
