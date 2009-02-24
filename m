From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2][OMAPZOOM] DSPBRIDGE: Change address resources to void
	__iomem *
Date: Wed, 25 Feb 2009 00:43:10 +0200
Message-ID: <94a0d4530902241443t777987bdsd850055f1783847e@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E602877515DC@dlee06.ent.ti.com>
	 <94a0d4530902241414v74f6ef1do378a51c55a40fbfd@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E6028775160C@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f167.google.com ([209.85.220.167]:61749 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974AbZBXWnO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 17:43:14 -0500
Received: by fxm11 with SMTP id 11so3234334fxm.13
        for <linux-omap@vger.kernel.org>; Tue, 24 Feb 2009 14:43:10 -0800 (PST)
In-Reply-To: <496565EC904933469F292DDA3F1663E6028775160C@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Feb 25, 2009 at 12:28 AM, Guzman Lugo, Fernando <x0095840@ti.co=
m> wrote:
>
>>Why wasn't dwMemBase updated too?
>>
>><snip/>
>>
>>A step in the right direction. Thanks.
>
>
> Hi Felipe,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0In this moment the array dwMemBase is used=
 to store iomem addresses but also the element two stores a kernel addr=
ess.
>
>
> MEM_FreePhysMem((void *)pResources->dwMemBase[1], pResources->dwMemPh=
ys[1],
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
hm_size);
>
> But we are seeing how to resolve this, and we will send this patch wh=
en it is ready.

Then I guess you should leave the '=3D0' instead of changing
'=3D(u32)NULL', that can wait for the next patch.

What about dwDipiBase?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
