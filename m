From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP2+: hwmod: remove unused voltagedomain pointer from kerneldoc
Date: Sat, 10 Dec 2011 10:28:16 +0100
Message-ID: <CAORVsuVLF1pDCCo+kMdGwiCh2RUYgABvA9uxbH89meRtzLM3_g@mail.gmail.com>
References: <1323454481-26782-1-git-send-email-j-pihet@ti.com>
	<874nx9mle4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51987 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab1LJJ2R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Dec 2011 04:28:17 -0500
Received: by vbbfc26 with SMTP id fc26so2852956vbb.19
        for <linux-omap@vger.kernel.org>; Sat, 10 Dec 2011 01:28:16 -0800 (PST)
In-Reply-To: <874nx9mle4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

On Fri, Dec 9, 2011 at 11:26 PM, Kevin Hilman <khilman@ti.com> wrote:
> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Commit fa17f20f (OMAP2+: hwmod: remove unused voltagedomain pointer)
>> did remove the voltdm field from the struct omap_hwmod.
>> Remove it from the kerneldoc as well.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>
> Acked-by: Kevin Hilman <khilman@ti.com>
>
> Jean, please re-post with linux-arm-kernel in Cc. =A0Paul can then pi=
ck
> it up and queue it.
Ok re-send with your ack added.

Thanks,
Jean

>
> Thanks,
>
> Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
