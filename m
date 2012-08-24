From: =?UTF-8?B?UmFwaGHDq2wgQXNzw6luYXQ=?= <raph@8d.com>
Subject: Re: [PATCH] OMAPDSS: Add timings for ChiMei G121S1-L01/L02 and G121X1-L01
 LCD displays
Date: Fri, 24 Aug 2012 09:50:22 -0400
Message-ID: <5037869E.9050604@8d.com>
References: <20120717140140.GC3850@renkinjitsu.usine.8d.com>   <1345023063.3494.20.camel@deskari> <502BBFBB.6090303@8d.com>  <1345546189.4085.52.camel@deskari> <50339B3A.3020005@8d.com> <1345797509.2614.10.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from roc.holo.8d.com ([64.254.227.115]:42002 "EHLO roc.holo.8d.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754172Ab2HXNu1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Aug 2012 09:50:27 -0400
In-Reply-To: <1345797509.2614.10.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

On 24/08/12 04:38 AM, Tomi Valkeinen wrote:
> On Tue, 2012-08-21 at 10:29 -0400, Rapha=C3=ABl Ass=C3=A9nat wrote:
>> On 21/08/12 06:49 AM, Tomi Valkeinen wrote:
>>> On Wed, 2012-08-15 at 11:26 -0400, Rapha=C3=ABl Ass=C3=A9nat wrote:
>>>
>>>>> +
>>>>> +	/* ChiMei G121S1-L01 */
>>>>> +	{
>>>>> +		{
>>>>
>>>> ...
>>>>
>>>>> +			.vsync_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
>>>>> +			.hsync_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
>>>>> +			.data_pclk_edge	=3D OMAPDSS_DRIVE_SIG_RISING_EDGE,
>>>>> +			.de_level	=3D OMAPDSS_SIG_ACTIVE_HIGH,
>>>>> +			.sync_pclk_edge	=3D OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
>>>>
>>>> Actually those 3 panels only use the DE signal. The hsync/vsync si=
gnals
>>>> are not used and on our system we mux them out to make sure they a=
re
>>>> kept low as recommended in the panel datasheets.
>>>>
>>>> Since vsync/hsync are not used, I think the vsync_level, hsync_lev=
el and
>>>> sync_pclk_edge entries could be removed. Otherwise the updated pat=
ch
>>>> works fine as is.
>>>
>>> Okay. How do panels like that work? How can they know where a new f=
rame
>>> starts?
>>
>> By DE being inactive for a different number of pixel clock cycles du=
ring
>> the vertical and horizontal blanking periods.
>=20
> Ok. Interesting architecture. I wonder what's the reason for a design
> like that...
>=20
>>> Actually, I now googled for those panels, and they are all LVDS pan=
els,
>>> not DPI panels. So the patch doesn't look correct at all.
>>>
>>> Do you have a DPI-to-LVDS converter chip on your board?
>>
>> Yes, we do. Depending on the board, we use a SN75LVDS83B or a SN65LV=
DS84.
>>
>> The reason for using this approach was that the panels covered by
>> this patch seemed not to be compatible with Flatlink 3G, which meant
>> driving them directly from the AM35xx SDI serial interface was not p=
ossible.
>> We unfortunately do not get to select which LVDS deserializer is
>> used at the panel side..
>=20
> Ok. I'm a bit reluctant to add the panels to panel-generic-dpi.c, as
> they are not DPI panels at all. Also, you should have drivers for the
> DPI-to-LVDS converters. However, this cannot be done properly with th=
e
> current DSS driver model, so I'm not sure what to do with your patch.

But internally, perhaps with the exception of the "DE only" operation,
all the same concepts apply. LVDS is just only one extra layer used to
transmit the parallel data more effectively (differential, less
conductors, etc).

Consider the case where an LVDS transmitter is used on the main board
in conjunction with a remote LVDS receiver on a board connected to
a "true" DPI panel as follows:

[OMAPDSS -> LVDS XMIT] -> [long cable] -> [LVDS RXCV -> DPI Panel]
|    parallel        |     lvds serial    |        parallel      |

Given the above use case, adding a new panel to panel-generic-dpi.c wou=
ld
be obvious since doing without LVDS and driving the panel directly may
still happen if a specific design does not benefit from the use of LVDS=
=2E

There are a few different conventions for LVDS transmission where the t=
otal
number of bits transmitted by pairs as well as the bit order varies. Th=
e
hardware designer selects a compatible pair of chips based on the numbe=
r of
color bits the panel supports and other factors. But no matter which ar=
e
selected and how they are wired, the LVDS layer remains transparent to =
the
graphics controller and the panel.

My situation is only different from the above by the fact that our pane=
ls
have an LVDS receiver built-in, which means the choice of transmitter i=
s
limited to what will be compatible and that a specific bit order (i.e.
wiring)
must be observed. This is why I tend to consider those LVDS panels simp=
ly
as DPI panels having a built-in LVDS receiver.


> If you had just one panel and DPI-to-LVDS chip, I'd suggest to create=
 a
> combined driver which handles both the chip and the panel. But you ha=
ve
> two chips and three panels...

I'm not sure what the chip driver would do. The LVDS layer is totally
transparent to the operation. Why would the kernel need to be aware of
which chip is used?

One thing that might be useful would be the ability to control the
enable pin, but this is not different from the enable pin on a level sh=
ifter
placed between the OMAP and a real DPI panel. At the moment, our usersp=
ace
software simply controls this using a GPIO.

Best regards,
Rapha=C3=ABl Ass=C3=A9nat
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
