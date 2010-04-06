From: Laine Walker-Avina <lwalkera@ieee.org>
Subject: Re: [PATCH 1/5] OMAP: Add in helper macros for the SDRAM timings
Date: Tue, 6 Apr 2010 10:26:48 -0700
Message-ID: <l2ndfb660301004061026g5e1371b8of8cf1df83e687e2f@mail.gmail.com>
References: <1270572668-2336-1-git-send-email-lwalkera@ieee.org>
	 <1270572668-2336-2-git-send-email-lwalkera@ieee.org>
	 <20100406171713.GA24981@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36337 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755845Ab0DFR0t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 13:26:49 -0400
Received: by vws13 with SMTP id 13so49055vws.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Apr 2010 10:26:49 -0700 (PDT)
In-Reply-To: <20100406171713.GA24981@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Apr 6, 2010 at 10:17 AM, Felipe Balbi <felipe.balbi@nokia.com> =
wrote:
>> +/* Helper macros and defines for the omap_sdrc_params registers */
>> +#define ACTIM_TRFC(a) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(((a) & 0x1=
f)<<27)
>
> you need to add more spacing in all these macros, something like:
>
> #define ACTIM_TRFC(a) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (((a) & 0x1f=
) << 27)
>
> similar to all others.
>
> --
> balbi
>

I'll do it, however checkpatch.pl didn't flag that as a warning.
--=20
Laine Walker-Avina
=46irmware Engineer
PASCO scientific
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
