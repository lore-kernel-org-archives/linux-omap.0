From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] DSPBRIDGE: cleanup for PROC_FlushMemory/PROC_InvalidateMemory
Date: Wed, 22 Jul 2009 16:52:47 +0300
Message-ID: <94a0d4530907220652y4330fb5du81d40957d4e271c0@mail.gmail.com>
References: <1248250970-417-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:48224 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755546AbZGVNws convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jul 2009 09:52:48 -0400
Received: by fg-out-1718.google.com with SMTP id e12so908264fga.17
        for <linux-omap@vger.kernel.org>; Wed, 22 Jul 2009 06:52:47 -0700 (PDT)
In-Reply-To: <1248250970-417-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, ameya.palande@nokia.com, omar.ramirez@ti.com, x0095840@ti.com, h-kanigeri2@ti.com

On Wed, Jul 22, 2009 at 11:22 AM, Hiroshi DOYU<Hiroshi.DOYU@nokia.com> =
wrote:
> Both functions are almost same structure except its flag passed to
> MEM_FlushCache().
>
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
> =C2=A0drivers/dsp/bridge/rmgr/proc.c | =C2=A0 82 ++++++++++++++++++--=
-------------------
> =C2=A01 files changed, 38 insertions(+), 44 deletions(-)

> + =C2=A0 =C2=A0 =C2=A0 enum DSP_FLUSHTYPE mtype =3D PROC_WRITEBACK_IN=
VALIDATE_MEM;
> +
> + =C2=A0 =C2=A0 =C2=A0 return proc_memory_sync(hProcessor, pMpuAddr, =
ulSize, ulFlags, mtype);
> +}

What's wrong with sending the type directly?
return proc_memory_sync(hProcessor, pMpuAddr, ulSize, ulFlags,
PROC_WRITEBACK_INVALIDATE_MEM);

> + =C2=A0 =C2=A0 =C2=A0 enum DSP_FLUSHTYPE mtype =3D PROC_INVALIDATE_M=
EM;
> +
> + =C2=A0 =C2=A0 =C2=A0 return proc_memory_sync(hProcessor, pMpuAddr, =
ulSize, 0, mtype);
> =C2=A0}

ditto

And while we are at it, why only PROC_WRITEBACK_INVALIDATE_MEM and
PROC_INVALIDATE_MEM? How shall user-space issue a call for
PROC_WRITEBACK_MEM?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
