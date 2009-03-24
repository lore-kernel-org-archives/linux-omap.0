From: Ameya Palande <2ameya@gmail.com>
Subject: Re: [PATCH] [OMAPZOOM]DSPBRIDGE bug in Bridge exit cleanup
Date: Tue, 24 Mar 2009 12:04:54 +0200
Message-ID: <269694c00903240304y69f43451lb260951167fe64af@mail.gmail.com>
References: <Acmr6BM18BJBh1pxS8i5e+utnLzXGw==>
	 <8F7AF80515AF0D4D93307E594F3CB40E2342BE9F@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:48070 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434AbZCXKE5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 06:04:57 -0400
Received: by fxm2 with SMTP id 2so2182867fxm.37
        for <linux-omap@vger.kernel.org>; Tue, 24 Mar 2009 03:04:54 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E2342BE9F@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Hari,

On Mon, Mar 23, 2009 at 8:49 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wr=
ote:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRV_RemoveProc=
Context((struct DRV_OBJECT *)hDrvObject,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pCtxtclosed, (=
void *)pCtxtclosed->pid);

I am trying to understand this patch.
I see that pCtxtclosed is passed to DRV_RemoveProcContext() function
but it is not used anywhere inside it. I was expecting to see a
statement there which should free its memory.

Any pointers?

Cheers,
Ameya.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
