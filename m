From: =?UTF-8?B?xYF1a2FzeiBHw7NyYWxjenlr?= <lukasz.goralczyk@gmail.com>
Subject: Re: [BUG] omap1 fails to boot on clock propagation
Date: Tue, 29 Jan 2013 20:46:23 +0100
Message-ID: <CAP2z3mmjvTJ3FHQ_nuRdUd9di=0bZXd49KB0=Ck3eT-OAUModw@mail.gmail.com>
References: <CAP2z3mkGdmSUPZcwTATGvnKrMmkgjwMUGNaTZk17R=X2xMy2AQ@mail.gmail.com>
	<5107FFB8.4050008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:42237 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab3A2TyJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jan 2013 14:54:09 -0500
Received: by mail-we0-f173.google.com with SMTP id r5so599710wey.32
        for <linux-omap@vger.kernel.org>; Tue, 29 Jan 2013 11:54:07 -0800 (PST)
In-Reply-To: <5107FFB8.4050008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org

2013/1/29 Jon Hunter <jon-hunter@ti.com>
>
> On 01/29/2013 03:53 AM, =C5=81ukasz G=C3=B3ralczyk wrote:
> > Hello,
> >
> > Some background:
> > Recently I've ported Linux to some custom omap1 based (5940 or 1510=
)
> > hardware. I've had some initial problems, but after a "dirty" fix I
> > have a running kernel and I can boot using NFS.
>
> Do you mean 5910? I am not familiar with a 5940.

Yes, I hesitated for a moment if it was ...10 or ...40, it's *5910*.

> > Problem:
> > On the very beginning kernel boot process stopped on clock propagat=
ion
> > routine (simple freeze, no crash info, nothing). After investigatio=
n I
> > have found that one memory read is at fault in function
> > omap1_ckctl_recalc_dsp_domain() in clock.c file:
> >
> > dsor =3D 1 << (3 & (__raw_readw(DSP_CKCTL) >> clk->rate_offset));
> >
> > My fix was to exchange read operation with default value of DSP_CKC=
TL register:
> >
> > dsor =3D 1 << (3 & (0x009000090 >> clk->rate_offset));
> >
> > Since this fix I haven't dug deeper into this problem, but it keeps=
 me
> > thinking how to fix it properly. Any suggestions what might be the
> > root cause of this?
>
> Well looking at the code, in order to access the DSP_CKCTL register y=
ou
> need to enable the api_ck first ...
>
> omap1_clk_enable(api_ck_p);
> dsor =3D 1 << (3 & (__raw_readw(DSP_CKCTL) >> clk->rate_offset));
> omap1_clk_disable(api_ck_p);
>
> Therefore, I would check if the api_ck is actually being turned on, o=
n
> your platform. For example ...
>
> omap1_clk_enable(api_ck_p);
> pr_info("ARM_IDLECT2 =3D 0x%x\n", __raw_readw(ARM_IDLECT2));
> omap1_clk_disable(api_ck_p);
>
> Bit 6 in the ARM_IDLECT2 should be set if the api_ck is enabled.

Thanks, now I'll know where to look.

Lukasz.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
