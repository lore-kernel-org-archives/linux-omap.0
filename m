From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2 06/19] ARM: OMAP4: PM: Add SAR backup support towards
 device OFF
Date: Thu, 17 May 2012 12:32:00 +0530
Message-ID: <CAMQu2gznJ0q-Eqevh9dWn+vw69to91kfFG6hYDvTbGj3zwT0FQ@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-7-git-send-email-t-kristo@ti.com> <87aa177my3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:52603 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755144Ab2EQHCW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 May 2012 03:02:22 -0400
Received: by qaeb19 with SMTP id b19so5283652qae.4
        for <linux-omap@vger.kernel.org>; Thu, 17 May 2012 00:02:21 -0700 (PDT)
In-Reply-To: <87aa177my3.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Thu, May 17, 2012 at 4:28 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tero Kristo <t-kristo@ti.com> writes:
>
>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>
>> The SAR RAM is maintained during Device OFF mode.
>
> so why is this patch bothering to save and restore it?
>
SAR RAM is maintained(not powered down) but somebody needs to
feel the contents which will be preserved :-)

> -ECONFUSED
>
>> The register layout
>> is fixed in SAR ROM. SAR is split into 4 banks with different
>> privilege accesses based on device type
>>
>> =A0---------------------------------------------------------------
>> =A0Access mode =A0 =A0 =A0 =A0 =A0Bank =A0 =A0Address Range
>> =A0---------------------------------------------------------------
>> =A0HS/GP : Public =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 =A0 =A0 =A0 0x4A32_6=
000 - 0x4A32_6FFF (4kB)
>> =A0HS/GP : Public =A0 =A0 =A0 =A0 =A0 =A0 =A0 2 =A0 =A0 =A0 0x4A32_7=
000 - 0x4A32_73FF (1kB)
>>
>> =A0HS/EMU : Secured
>> =A0GP : Public =A0 =A0 =A0 =A0 =A03 =A0 =A0 =A0 0x4A32_8000 - 0x4A32=
_87FF (2kB)
>>
>> =A0HS/GP :Secure
>> =A0write once. =A0 =A0 =A0 =A0 =A04 =A0 =A0 =A0 0x4A32_9000 - 0x4A32=
_93FF (1kB)
>> =A0---------------------------------------------------------------
>>
>> The save process is done entirely by software and restore is done by
>> hardware using the auto-restore feature. The restore feature is enab=
led
>> by default and cannot be disabled. The software must save the data
>> to be restored in a dedicated location in SAR RAM.
>
> Some general comments:
>
> - can the cluster PM notifier be used for the save path?
>
Nope. This is for device OFF only case. CPU Cluster state as such
has no dependency.

> - This patch adds lots of data that is immediately removed by the nex=
t
> =A0patch. =A0Probably the two just need to be combined.
>
iormap() hunk from this patch can be completely dropped since
it is getting fixed in next patch. Other infrastructure is maintained.

> - BUG_ON() should not be used unless there is absolutely no recovery
> =A0path, since it casues a full kernel panic. =A0 Instead, some error
> =A0recovery should be added.
>
WARN_ON should suffice.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
