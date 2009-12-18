From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCHv2 18/18] DSPBRIDGE: Compilation fixes 2.6.31
Date: Fri, 18 Dec 2009 19:48:46 +0200
Message-ID: <94a0d4530912180948r527cdb15w7ec241b2f6ad1fbb@mail.gmail.com>
References: <1261016163-11091-1-git-send-email-omar.ramirez@ti.com>
	 <1261016163-11091-11-git-send-email-omar.ramirez@ti.com>
	 <1261016163-11091-12-git-send-email-omar.ramirez@ti.com>
	 <1261016163-11091-13-git-send-email-omar.ramirez@ti.com>
	 <1261016163-11091-14-git-send-email-omar.ramirez@ti.com>
	 <1261016163-11091-15-git-send-email-omar.ramirez@ti.com>
	 <1261016163-11091-16-git-send-email-omar.ramirez@ti.com>
	 <1261016163-11091-17-git-send-email-omar.ramirez@ti.com>
	 <1261016163-11091-18-git-send-email-omar.ramirez@ti.com>
	 <1261016163-11091-19-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:49255 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355AbZLRRsr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 12:48:47 -0500
Received: by iwn1 with SMTP id 1so2320022iwn.33
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 09:48:46 -0800 (PST)
In-Reply-To: <1261016163-11091-19-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>

On Thu, Dec 17, 2009 at 4:16 AM, Omar Ramirez Luna <omar.ramirez@ti.com=
> wrote:
> Compilation fixes 2.6.31
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0board-sdp3430.h not found
> =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_handle undefined because of DVFS flag

In fact, these are not specific to 2.6.31. The changes are good to
have even on 2.6.28; they would get rid of warnings on certain
configurations.

So I'm sending a proposal that's a bit different: first I clean the PM
idefs, then I remove unused headers. The end result is almost the
same: the code compiles on 2.6.31 :)

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
