From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 0/7 v6] OMAP3: clean up ASM sleep code
Date: Mon, 20 Dec 2010 09:29:05 +0100
Message-ID: <AANLkTikX9qY0OUfS6w9UvELCGLM4F1oUVLKYwGq7fZgm@mail.gmail.com>
References: <1292687087-22983-1-git-send-email-j-pihet@ti.com>
	<4D0D3C24.4020503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43560 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102Ab0LTI3H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 03:29:07 -0500
Received: by qwa26 with SMTP id 26so2531421qwa.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 00:29:06 -0800 (PST)
In-Reply-To: <4D0D3C24.4020503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

Hi Nishant,

On Sat, Dec 18, 2010 at 11:56 PM, Nishanth Menon <nm@ti.com> wrote:
> jean.pihet@newoldbits.com had written, on 12/18/2010 09:44 AM, the
> following:
>>
>> Applies on top of Nishant's latest idle path errata fixes step 2,
>> cf. http://marc.info/?l=3Dlinux-omap&m=3D129139584919242&w=3D2
>>
>> Jean Pihet (7):
>> =A0OMAP3: remove unused code from the ASM sleep code
>> =A0OMAP2+: use global values for the SRAM PA addresses
>> =A0OMAP3: remove hardcoded values from the ASM sleep code
>> =A0OMAP3: re-organize the ASM sleep code
>> =A0OMAP3: rework of the ASM sleep code execution paths
>> =A0OMAP3: add comments for low power code errata
>> =A0OMAP3: ASM sleep code format rework
>>
>
> just FYI - tested the series v6 as well with:
> SDP3430 and SDP3630 with script:
> http://elinux.org/OMAP_Power_Management#Quick_verification_of_suspend=
-idle_functionality
>
> Tested against v4 of my series. I have ensured that your series still
> applies cleanly on top of my new series.

Thanks for that!

Let me check and ack your latest v4 patches.

>
> --
> Regards,
> Nishanth Menon
>
>

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
