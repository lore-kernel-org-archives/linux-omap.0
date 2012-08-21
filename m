From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 4/5] ARM: OMAP4: Add L2 Cache Controller in Device Tree
Date: Tue, 21 Aug 2012 16:02:38 +0530
Message-ID: <CAMQu2gy46sVEBH0hvaXrwOLMfcKH+fwyExFmwzAPzxQKoYwhhA@mail.gmail.com>
References: <1344855623-14879-1-git-send-email-santosh.shilimkar@ti.com>
 <1344855623-14879-5-git-send-email-santosh.shilimkar@ti.com>
 <503240EF.4050805@ti.com> <CAMQu2gxgSasF4mmEFiZq-gsZfQwYn07DKyVGBVPWqjYkTSTu6g@mail.gmail.com>
 <CAMQu2gyL4-j9QSKMpNi5QQFsLqex8Q=bW9uNQtsewXVyrTumOQ@mail.gmail.com> <20120821102455.GM10347@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:53121 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755086Ab2HUKc7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 06:32:59 -0400
Received: by iaky10 with SMTP id y10so3908066iak.34
        for <linux-omap@vger.kernel.org>; Tue, 21 Aug 2012 03:32:58 -0700 (PDT)
In-Reply-To: <20120821102455.GM10347@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.or, tony@atomide.com

On Tue, Aug 21, 2012 at 3:54 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Tue, Aug 21, 2012 at 03:11:51PM +0530, Shilimkar, Santosh wrote:
>> On Mon, Aug 20, 2012 at 9:21 PM, Shilimkar, Santosh
>> <santosh.shilimkar@ti.com> wrote:
>> > On Mon, Aug 20, 2012 at 7:21 PM, Benoit Cousson <b-cousson@ti.com> wrote:
>> >> Hi Santosh,
>> >>
>> >> On 08/13/2012 01:00 PM, Santosh Shilimkar wrote:
>> >>> This provides PL310 Level 2 Cache Controller Device Tree
>> >>> support for OMAP4 based devices.
>> >>>
>> >>> Cc: Benoit Cousson <b-cousson@ti.com>
>> >>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> >>> ---
>> >>>  arch/arm/boot/dts/omap4.dtsi       |    7 +++++++
>> >>>  arch/arm/mach-omap2/omap4-common.c |    6 +++++-
>> >>>  2 files changed, 12 insertions(+), 1 deletion(-)
>> >>>
>> >>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> >>> index 6717c71..cf1efb6 100644
>> >>> --- a/arch/arm/boot/dts/omap4.dtsi
>> >>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> >>> @@ -36,6 +36,13 @@
>> >>>               };
>> >>>       };
>> >>>
>> >>
>> >>> +     L2: l2-cache-controller {
>> >>
>> >> The reg offset is missing: l2-cache-controller@48242000
>> >>
>> >>> +             compatible = "arm,pl310-cache";
>> >>> +             reg = <0x48242000 0x1000>;
>> >>> +             cache-unified;
>> >>> +             cache-level = <2>;
>> >>> +     };
>> >>> +
>> >>
>> >> In theory, the L2 cache should be referenced from the CPUs.
>> >>
>> > Agree.
>> >
>> I have added the reference for the L2 controller in CPUs.
>> Other information like L1 cache size etc can be added in cpu
>> DT node with another patch.
>>
>> Updated patch below. Have also updated git branch
>> accordingly.
>>
>> Regards
>> Santosh
>>
>> From 91d6cb4f999061c8cfc844a3916ee3384f2e488a Mon Sep 17 00:00:00 2001
>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Date: Wed, 4 Jul 2012 17:57:34 +0530
>> Subject: [PATCH 1/2 v2] ARM: OMAP4: Add L2 Cache Controller in Device Tree
>>
>> This provides PL310 Level 2 Cache Controller Device Tree
>> support for OMAP4 based devices.
>>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> nice work :-)
>
> FWIW this looks good to me:
>
> Acked-by: Felipe Balbi <balbi@ti.com>
>
Thanks.

> just one thing, will a similar patch for omap3 be sent ?
>
OMAP3 has an integrated L2 cache controller so there
won't any additional DT node for L2.

OMAP3 CPU DT node can be updated with l1/l2 cache
size etc related information though.

Regards
Santosh
