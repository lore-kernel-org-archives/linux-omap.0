From: "Poddar, Sourav" <sourav.poddar@ti.com>
Subject: Re: [PATCH 02/14] ARM: bitops: switch set/clear/change bitops to use ldrex/strex
Date: Mon, 24 Jan 2011 14:27:24 +0530
Message-ID: <AANLkTinnQLsa4mOV+SLYxeRrwZdc8N36SW9pK6ne+6TQ@mail.gmail.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<E1Peue4-0003SN-Gk@rmk-PC.arm.linux.org.uk>
	<20110123001636.GA20841@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101222323190.8580@xanadu.home>
	<20110123093526.GA26120@n2100.arm.linux.org.uk>
	<AANLkTi=tpnNXm8w9-VFi72nYvXRQV5-jE7Qn9NNk1wLW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:33175 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751214Ab1AXI5Z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 03:57:25 -0500
Received: by mail-ww0-f44.google.com with SMTP id 36so4086144wwa.25
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 00:57:24 -0800 (PST)
In-Reply-To: <AANLkTi=tpnNXm8w9-VFi72nYvXRQV5-jE7Qn9NNk1wLW@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Mon, Jan 24, 2011 at 2:08 PM, Poddar, Sourav <sourav.poddar@ti.com> =
wrote:
> On Sun, Jan 23, 2011 at 3:05 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Sat, Jan 22, 2011 at 11:44:59PM -0500, Nicolas Pitre wrote:
>>> At least another person did post results:
>>>
>>> http://mid.gmane.org/20110117094602.GA2622@pulham.picochip.com
>>> http://mid.gmane.org/20110117110308.GC2622@pulham.picochip.com
>>
>> Slightly different patch - there were three revisions. =A0I can't at=
tach
>> a tested-by given to a different patch to this one.
>>
>>> > That means omap2plus_defconfig .38 mainline kernels
>>> > (including -stable) will remain potentially dangerous when run on
>>> > SMP capable hardware.
>>>
>>> I must admit that this series looks a bit large for stable IMHO. =A0=
I
>>> think that the fix for stable should limit itself only to prevent S=
MP
>>> from being selected if anything else than CPU_32v6K is selected.
>>
>> The first three are the bare minimum required for -stable.
>>
>

 Boot tested the 14 patch series =A0with CONFIG_SWP_EMULATE enabled, on
 the following boards :


  1. Omap2420 SDP

  2. Omap2430 SDP

  3. Omap3430 SDP

  4. Omap4 Blaze

  Tested-by: Sourav Poddar <sourav.poddar@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
