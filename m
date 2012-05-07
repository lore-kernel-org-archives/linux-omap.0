From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/13] ARM: OMAP5: Add the build support
Date: Mon, 7 May 2012 10:37:50 -0700
Message-ID: <20120507173749.GE5088@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-13-git-send-email-r.sricharan@ti.com>
 <20120504225857.GB5613@atomide.com>
 <CAJ7qFSeJc+F5xnW+P5r89yZEZXi8k-LqqnD8R1KEUONqravNBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:16847 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756667Ab2EGRhv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 13:37:51 -0400
Content-Disposition: inline
In-Reply-To: <CAJ7qFSeJc+F5xnW+P5r89yZEZXi8k-LqqnD8R1KEUONqravNBw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "R, Sricharan" <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com

* R, Sricharan <r.sricharan@ti.com> [120506 20:39]:
> >> +config MACH_OMAP5_SEVM
> >> + =C2=A0 =C2=A0 bool "OMAP5 sevm Board"
> >> + =C2=A0 =C2=A0 depends on ARCH_OMAP5
> >> +
> >> =C2=A0config OMAP3_EMU
> >> =C2=A0 =C2=A0 =C2=A0 bool "OMAP3 debugging peripherals"
> >> =C2=A0 =C2=A0 =C2=A0 depends on ARCH_OMAP3
> >
> > No need for it here either. Actually, I think this whole chunk
> > can be now left out since it's DT based?
> >he
>  ok, but the concern here was that without this macro
>  the print from compress and subsequently early
> prints appear broken.
>=20
> machine_is_omap5_sevm becomes zero without this config and
> machine_is_xxxx is used by the macro _DEBUG_LL_ENTRY
> uncompress.h.

Ah I see.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
