From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] omap: iommu-add functionality to get TLB miss
	interrupt
Date: Wed, 19 May 2010 12:42:53 +0300
Message-ID: <AANLkTinu5ruDJQnhGeRLni9riRnPZH514qKZ3g5jdU1G@mail.gmail.com>
References: <1274137950-18759-3-git-send-email-h-kanigeri2@ti.com>
	 <20100518.091130.260105572.Hiroshi.DOYU@nokia.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E4BC6CD62@dlee03.ent.ti.com>
	 <20100519.122751.71107025.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55659 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671Ab0ESJmz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 05:42:55 -0400
Received: by fxm10 with SMTP id 10so2099143fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 19 May 2010 02:42:53 -0700 (PDT)
In-Reply-To: <20100519.122751.71107025.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: h-kanigeri2@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, grgupta@ti.com

On Wed, May 19, 2010 at 12:27 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>=
 wrote:
> From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> Subject: RE: [PATCH 2/2] omap: iommu-add functionality to get TLB mis=
s interrupt
> Date: Tue, 18 May 2010 19:03:55 +0200
>
>>> > diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/p=
lat-
>>> omap/include/plat/iommu.h
>>> > index 0752af9..52a3852 100644
>>> > --- a/arch/arm/plat-omap/include/plat/iommu.h
>>> > +++ b/arch/arm/plat-omap/include/plat/iommu.h
>>> > @@ -80,6 +80,7 @@ struct iommu_functions {
>>> >
>>> > =C2=A0 =C2=A0int (*enable)(struct iommu *obj);
>>> > =C2=A0 =C2=A0void (*disable)(struct iommu *obj);
>>> > + =C2=A0void (*disable_twl)(struct iommu *obj);
>>> > =C2=A0 =C2=A0u32 (*fault_isr)(struct iommu *obj, u32 *ra);
>>> >
>>> > =C2=A0 =C2=A0void (*tlb_read_cr)(struct iommu *obj, struct cr_reg=
s *cr);
>>> > @@ -143,6 +144,7 @@ extern void iotlb_cr_to_e(struct cr_regs *cr,=
 struct
>
> Just one thought, isn't the following a little bit flexible?
>
> - =C2=A0 =C2=A0 =C2=A0 void (*disable_twl)(struct iommu *obj);
> + =C2=A0 =C2=A0 =C2=A0 void (*set_twl)(struct iommu *obj, int on);

Yeah, that would be better.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
