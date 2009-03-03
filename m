From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [OMAPZOOM][PATCH 5/5] DSPBRIDGE: Remove unnecessary checks in
	HW_MBOX_IsFull
Date: Tue, 3 Mar 2009 20:16:26 +0200
Message-ID: <94a0d4530903031016x7a6750caxa4d2b539e13d84d@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E60287B84DFA@dlee06.ent.ti.com>
	 <94a0d4530903022322mad6ff40v806c3be7f897939f@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E60287B84F0E@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:61088 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbZCCSQ3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 13:16:29 -0500
Received: by fg-out-1718.google.com with SMTP id 16so112507fgg.17
        for <linux-omap@vger.kernel.org>; Tue, 03 Mar 2009 10:16:26 -0800 (PST)
In-Reply-To: <496565EC904933469F292DDA3F1663E60287B84F0E@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Aguilar Pena, Leed" <leed.aguilar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Mar 3, 2009 at 6:34 PM, Guzman Lugo, Fernando <x0095840@ti.com>=
 wrote:
>
> Hi Felipe,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0This patch is base on your patch about inc=
rease the performance waiting less and checking more the mail box.

Exactly, but that's not what the commit message says.

Besides, you are are doing multiple things in the same patch, which is
the same mistake I did in the original patch that Hiroshi pointed out:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg09875.html

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
