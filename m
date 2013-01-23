From: kishon <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 0/6] USB: Add support for multiple PHYs of same type
Date: Wed, 23 Jan 2013 10:49:15 +0530
Message-ID: <50FF72D3.2060301@ti.com>
References: <1358848694-20145-1-git-send-email-kishon@ti.com>
 <2D906ABA-71F2-4843-9DBE-F82527A1240A@dominion.thruhere.net>
 <50FEB3FD.3050001@ti.com> <50FEBB61.9000707@ti.com>
 <B9531499-0746-44DA-BDBB-999D4CA31E63@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <B9531499-0746-44DA-BDBB-999D4CA31E63-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
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
To: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org List" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 22 January 2013 10:32 PM, Koen Kooi wrote:
>
> Op 22 jan. 2013, om 17:16 heeft kishon <kishon-l0cyMroinI0@public.gmane.org> het volgende geschreven:
>
>> Hi,
>>
>> On Tuesday 22 January 2013 09:15 PM, kishon wrote:
>>> On Tuesday 22 January 2013 09:11 PM, Koen Kooi wrote:
>>>>
>>>> Op 22 jan. 2013, om 10:58 heeft Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>>>> het volgende geschreven:
>>>>
>>>>> This patch series adds support for adding multiple PHY's (of same type).
>>>>> The binding information has to be present in the PHY library (otg.c) in
>>>>> order for it to return the appropriate PHY whenever the USB controller
>>>>> request for the PHY. So added a new API usb_bind_phy() to pass the
>>>>> binding
>>>>> information. This API should be called by platform specific
>>>>> initialization
>>>>> code.
>>>>>
>>>>> So the binding should be done something like
>>>>> usb_bind_phy("musb-hdrc.0.auto", 0, "omap-usb2.1.auto"); specifying
>>>>> the USB
>>>>> controller device name, index, and the PHY device name.
>>>>> I have done this binding for OMAP platforms, but it should be done for
>>>>> all the platforms.
>>>>>
>>>>> After this design, the phy can be got by passing the USB controller
>>>>> device
>>>>> pointer and the index.
>>>>>
>>>>> Developed this patch series on
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git xceiv
>>>>> after applying "usb: musb: add driver for control module" patch series
>>>>> and "ARM: dts: omap: add dt data for MUSB"
>>>>>
>>>>> Did basic enumeration testing in omap4 panda and omap3 beagle.
>>>>
>>>> With this patchset USB completely breaks on am33xx beaglebone, is that
>>>> intended?
>>> Not really.
>>> Does am33xx makes use of omap2430.c? Which PHY does am33xx uses?
>>
>> I figured out it uses drivers/usb/musb/musb_dsps.c (So it doesn't use omap2430.c). I think it uses TWL4030_USB (TPS659x0) as PHY.
>
> Actually it uses nop-phy as a phy, which is missing from arch/arm/boot/dts/am33xx.dtsi, so mainline is already broken. But adding the nop-phy to the DT is easy enough to patch in locally.

Cool. You can add your patch after applying this series then. (I'll post 
a new version addressing the comments in this series.)

Thanks
Kishon
