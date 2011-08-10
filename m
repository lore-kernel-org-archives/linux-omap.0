From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [RFC/PATCH 00/14] dt: omap hwmod-dt binding and omap3 i2c1 dt support
Date: Wed, 10 Aug 2011 11:58:56 +0530
Message-ID: <CAC63_iQ=Sv3hJ4PMsFaYDDD9sqbiLshODwGr-ST6GyKUdAyJnw@mail.gmail.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
	<4E421687.1060409@ti.com>
	<CAC63_iTaeZ4Gh2V4t=fJB5BUzyfybeuaDXisgApagW0T5r2v0A@mail.gmail.com>
	<4E42198C.8030202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:46977 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751121Ab1HJG26 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Aug 2011 02:28:58 -0400
Received: by bkbzu5 with SMTP id zu5so203992bkb.23
        for <linux-omap@vger.kernel.org>; Tue, 09 Aug 2011 23:28:56 -0700 (PDT)
In-Reply-To: <4E42198C.8030202@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Aug 10, 2011 at 11:09 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> On 8/10/2011 11:00 AM, G, Manjunath Kondaiah wrote:
>>
>> On Wed, Aug 10, 2011 at 10:56 AM, Rajendra Nayak<rnayak@ti.com> =A0w=
rote:
>>>
>>> On 8/9/2011 7:40 PM, G, Manjunath Kondaiah wrote:
>>>>
>>>> This is in continuation of patch series posted at:
>>>> http://lwn.net/Articles/451917/
>>>>
>>>> Patches from Kevin Hilman and others are consolidated along with t=
his
>>>> series since it will be part of ongoing work of decoupling pdev fr=
om
>>>> omap_device.
>>>> [There is latest version posted which will be rebased later]
>>>>
>>>> Apart from the above, the major feature included in this series is
>>>> dt-hwmod binding and preparing omap hwmod framework for adapting o=
map
>>>> drivers to support omap dt after aligning with Grant Likely
>>>> <grant.likely@secretlab.ca>
>>>>
>>>> However, current hwmod-dt binding will be replaced with notifiers =
in
>>>> generic board file and hwmod device pointer will be scanned and at=
tached
>>>> in notifier call.
>>>>
>>>> Used 3.0 stable kernel version for this patch series since latest
>>>> mainline
>>>> was broken for beagle boot last week.
>>>>
>>>> git://git.secretlab.ca/git/linux-2.6.git
>>>> Branch: devicetree/test-3.0
>>>
>>> Is there a reason why these are based on devicetree/test-3.0 and
>>> not devicetree/test?
>>
>> devicetree/test was broken last week since grant has pulled latest
>> mainline changes hence selected stable version.
>
> Ok, atleast mainline is fixed now.

These changes are for v3.2 merge window and it will be rebased later
after the review.

-M
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
