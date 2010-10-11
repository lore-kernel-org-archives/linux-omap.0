From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] OMAP: control: add functions for DSP boot
 address/mode control
Date: Mon, 11 Oct 2010 23:47:08 +0300
Message-ID: <AANLkTimnQJxS_6PrgECeQFwEkNU=4-f5=bStWS-AtDcs@mail.gmail.com>
References: <20101011203659.24425.2381.stgit@twilight.localdomain>
	<20101011203710.24425.94685.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64128 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756055Ab0JKUrL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 16:47:11 -0400
Received: by bwz15 with SMTP id 15so1966921bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 11 Oct 2010 13:47:09 -0700 (PDT)
In-Reply-To: <20101011203710.24425.94685.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: fernando.lugo@ti.com, linux-omap@vger.kernel.org

On Mon, Oct 11, 2010 at 11:37 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Add two functions for OMAP2430/OMAP3 IVA2 DSP boot control. =C2=A0The=
se
> registers wound up in the System Control Module. =C2=A0Other kernel c=
ode
> that wishes to control the DSP's boot process should now use these
> functions to do so; subsequent patches implement this in the two
> in-tree users of these functions.
>
> This patch is functionally untested; that is for the DSP/Bridge
> programmers to do.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> =C2=A0arch/arm/mach-omap2/control.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 51 ++++++++++++++++++++++++++
> =C2=A0arch/arm/mach-omap2/control.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 16 +++++---
> =C2=A0arch/arm/plat-omap/include/plat/iva2_dsp.h | =C2=A0 56 ++++++++=
++++++++++++++++++++
> =C2=A03 files changed, 116 insertions(+), 7 deletions(-)
> =C2=A0create mode 100644 arch/arm/plat-omap/include/plat/iva2_dsp.h

This doesn't seem to be aligned with staging-next, that's where
tidspbridge is supposed to reside. I proposed this patch to be applied
to linux-omap, but I guess it didn't seem necessary at the time:
http://article.gmane.org/gmane.linux.kernel/1044209

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
