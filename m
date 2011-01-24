From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH 02/14] ARM: bitops: switch set/clear/change bitops to use ldrex/strex
Date: Mon, 24 Jan 2011 19:17:54 +0530
Message-ID: <AANLkTikmwDkdiAPoCx+Oz7qhTbpuOTHeam9gSi=WesSa@mail.gmail.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peue4-0003SN-Gk@rmk-PC.arm.linux.org.uk>
	<20110123001636.GA20841@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101222323190.8580@xanadu.home>
	<20110123093526.GA26120@n2100.arm.linux.org.uk>
	<AANLkTi=tpnNXm8w9-VFi72nYvXRQV5-jE7Qn9NNk1wLW@mail.gmail.com>
	<AANLkTinnQLsa4mOV+SLYxeRrwZdc8N36SW9pK6ne+6TQ@mail.gmail.com>
	<20110124102849.GA18459@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:45090 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752556Ab1AXNr4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 08:47:56 -0500
Received: by mail-ww0-f50.google.com with SMTP id 26so4003361wwf.7
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 05:47:55 -0800 (PST)
In-Reply-To: <20110124102849.GA18459@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, Jan 24, 2011 at 3:58 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 24, 2011 at 02:27:24PM +0530, Poddar, Sourav wrote:
>> On Mon, Jan 24, 2011 at 2:08 PM, Poddar, Sourav <sourav.poddar@ti.co=
m> wrote:
>> > On Sun, Jan 23, 2011 at 3:05 PM, Russell King - ARM Linux
>> > <linux@arm.linux.org.uk> wrote:
>> >> On Sat, Jan 22, 2011 at 11:44:59PM -0500, Nicolas Pitre wrote:
>> >>> At least another person did post results:
>> >>>
>> >>> http://mid.gmane.org/20110117094602.GA2622@pulham.picochip.com
>> >>> http://mid.gmane.org/20110117110308.GC2622@pulham.picochip.com
>> >>
>> >> Slightly different patch - there were three revisions. =A0I can't=
 attach
>> >> a tested-by given to a different patch to this one.
>> >>
>> >>> > That means omap2plus_defconfig .38 mainline kernels
>> >>> > (including -stable) will remain potentially dangerous when run=
 on
>> >>> > SMP capable hardware.
>> >>>
>> >>> I must admit that this series looks a bit large for stable IMHO.=
 =A0I
>> >>> think that the fix for stable should limit itself only to preven=
t SMP
>> >>> from being selected if anything else than CPU_32v6K is selected.
>> >>
>> >> The first three are the bare minimum required for -stable.
>> >>
>> >
>>
>> =A0Boot tested the 14 patch series =A0with CONFIG_SWP_EMULATE enable=
d, on
>> =A0the following boards :
>>
>>
>> =A0 1. Omap2420 SDP
>>
>> =A0 2. Omap2430 SDP
>>
>> =A0 3. Omap3430 SDP
>>
>> =A0 4. Omap4 Blaze
>>
>> =A0 Tested-by: Sourav Poddar <sourav.poddar@ti.com>
>
> Thanks. =A0It's also important to ascertain which filesystems were te=
sted -
> could you let me know please?
>

It is a custom filesystem on BusyBox v1.17.2.
Please let me know if you need some other
information.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
