From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 02/14] dspbridge: deh: trivial cleanups
Date: Tue, 18 May 2010 00:13:57 +0300
Message-ID: <AANLkTikuXt1KgmJ2uzCL_X5pJfFeODLBtJdFAxwAcaOw@mail.gmail.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
	 <1274024765-21076-3-git-send-email-felipe.contreras@gmail.com>
	 <496565EC904933469F292DDA3F1663E602CB6CB3CC@dlee06.ent.ti.com>
	 <B321760590390941B64F0F8AB59ED2508FA24042@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:63492 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab0EQVOA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 17:14:00 -0400
Received: by ewy8 with SMTP id 8so2121506ewy.28
        for <linux-omap@vger.kernel.org>; Mon, 17 May 2010 14:13:58 -0700 (PDT)
In-Reply-To: <B321760590390941B64F0F8AB59ED2508FA24042@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Jansson, Cris" <cjansson@ti.com>
Cc: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Liu, Stanley" <stanley_liu@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

Hi Cris,

On Mon, May 17, 2010 at 10:39 PM, Jansson, Cris <cjansson@ti.com> wrote=
:
> Thanks for forwarding the thread.
>
> In wait_for_timer(), should return be used inside the loop? =C2=A0It =
will result in omap_dm_timer_disable(timer) not being called. =C2=A0I b=
elieve it should be called in all outcomes.

Yes, that's a mistake I already acknowledged. The question is: can we
disable the timer _before_ the DSP has finished dumping the stack?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
