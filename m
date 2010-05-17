From: "Jansson, Cris" <cjansson@ti.com>
Subject: RE: [PATCH 02/14] dspbridge: deh: trivial cleanups
Date: Mon, 17 May 2010 16:52:35 -0500
Message-ID: <B321760590390941B64F0F8AB59ED2508FA242B2@dlee01.ent.ti.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
	 <1274024765-21076-3-git-send-email-felipe.contreras@gmail.com>
	 <496565EC904933469F292DDA3F1663E602CB6CB3CC@dlee06.ent.ti.com>
	 <B321760590390941B64F0F8AB59ED2508FA24042@dlee01.ent.ti.com>
 <AANLkTikuXt1KgmJ2uzCL_X5pJfFeODLBtJdFAxwAcaOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35213 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755784Ab0EQVwj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 17:52:39 -0400
In-Reply-To: <AANLkTikuXt1KgmJ2uzCL_X5pJfFeODLBtJdFAxwAcaOw@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Liu, Stanley" <stanley_liu@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

The safe thing to do is disable the timer after the DSP has completed t=
he dump.  During the dump processing, the DSP will clear the timer inte=
rrupt. I don't know what would happen if the timer were disabled prior =
to that.

Best Regards,
=20
Cris

-----Original Message-----
=46rom: Felipe Contreras [mailto:felipe.contreras@gmail.com]=20
Sent: Monday, May 17, 2010 4:14 PM
To: Jansson, Cris
Cc: Guzman Lugo, Fernando; linux-omap; Liu, Stanley; Ramirez Luna, Omar
Subject: Re: [PATCH 02/14] dspbridge: deh: trivial cleanups

Hi Cris,

On Mon, May 17, 2010 at 10:39 PM, Jansson, Cris <cjansson@ti.com> wrote=
:
> Thanks for forwarding the thread.
>
> In wait_for_timer(), should return be used inside the loop? =A0It wil=
l result in omap_dm_timer_disable(timer) not being called. =A0I believe=
 it should be called in all outcomes.

Yes, that's a mistake I already acknowledged. The question is: can we
disable the timer _before_ the DSP has finished dumping the stack?

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
