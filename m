From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [RFC/PATCH 00/14] dt: omap hwmod-dt binding and omap3 i2c1 dt support
Date: Wed, 10 Aug 2011 11:00:00 +0530
Message-ID: <CAC63_iTaeZ4Gh2V4t=fJB5BUzyfybeuaDXisgApagW0T5r2v0A@mail.gmail.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
	<4E421687.1060409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:42272 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750963Ab1HJFaD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Aug 2011 01:30:03 -0400
Received: by mail-bw0-f52.google.com with SMTP id zs2so229284bkb.11
        for <linux-omap@vger.kernel.org>; Tue, 09 Aug 2011 22:30:01 -0700 (PDT)
In-Reply-To: <4E421687.1060409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Aug 10, 2011 at 10:56 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> On 8/9/2011 7:40 PM, G, Manjunath Kondaiah wrote:
>>
>> This is in continuation of patch series posted at:
>> http://lwn.net/Articles/451917/
>>
>> Patches from Kevin Hilman and others are consolidated along with this
>> series since it will be part of ongoing work of decoupling pdev from
>> omap_device.
>> [There is latest version posted which will be rebased later]
>>
>> Apart from the above, the major feature included in this series is
>> dt-hwmod binding and preparing omap hwmod framework for adapting omap
>> drivers to support omap dt after aligning with Grant Likely
>> <grant.likely@secretlab.ca>
>>
>> However, current hwmod-dt binding will be replaced with notifiers in
>> generic board file and hwmod device pointer will be scanned and attached
>> in notifier call.
>>
>> Used 3.0 stable kernel version for this patch series since latest mainline
>> was broken for beagle boot last week.
>>
>> git://git.secretlab.ca/git/linux-2.6.git
>> Branch: devicetree/test-3.0
>
> Is there a reason why these are based on devicetree/test-3.0 and
> not devicetree/test?

devicetree/test was broken last week since grant has pulled latest
mainline changes hence selected stable version.

-M

[...]
