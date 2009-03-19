From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH B 3/3] tidspbridge: decreate timeout to a saner value
Date: Thu, 19 Mar 2009 16:19:27 -0500
Message-ID: <496565EC904933469F292DDA3F1663E60287D62895@dlee06.ent.ti.com>
References: <1237339605-20697-1-git-send-email-felipe.contreras@gmail.com>
	 <1237339605-20697-2-git-send-email-felipe.contreras@gmail.com>
	 <1237339605-20697-3-git-send-email-felipe.contreras@gmail.com>
	 <1237339605-20697-4-git-send-email-felipe.contreras@gmail.com>
	 <496565EC904933469F292DDA3F1663E60287D6286E@dlee06.ent.ti.com>
 <94a0d4530903191404y14b5331eoaccb3f11c1846f9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38192 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757707AbZCSVTk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 17:19:40 -0400
In-Reply-To: <94a0d4530903191404y14b5331eoaccb3f11c1846f9d@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>


Yes, I applied this; in fact I have applied all the patches. If I incre=
ase the timeout there are no problems. The test I run creates 4 process=
 and each one does several a lot of calls to InputChnl and OutputChnl, =
so I think this test is using the mailbox a lot and would be better a b=
igger timeout. What do you think?

Regards,
=46ernando.
-----Original Message-----
=46rom: Felipe Contreras [mailto:felipe.contreras@gmail.com]=20
Sent: Thursday, March 19, 2009 3:04 PM
To: Guzman Lugo, Fernando
Cc: linux-omap@vger.kernel.org; Kanigeri, Hari; Hiroshi DOYU; Ameya Pal=
ande; Felipe Contreras
Subject: Re: [PATCH B 3/3] tidspbridge: decreate timeout to a saner val=
ue

On Thu, Mar 19, 2009 at 10:42 PM, Guzman Lugo, Fernando <x0095840@ti.co=
m> wrote:
>
>
> Hi Felipe,
>
> =A0 =A0 =A0 =A0I am seeing with this patch because of the timeout:
>
> DSP device detected !!
> DSPProcessor_Attach succeeded.
> dspbridge: timed out waiting for mailbox
> dspbridge: timed out waiting for mailbox
> dspbridge: timed out waiting for mailbox
> dspbridge: timed out waiting for mailbox
> dspbridge: timed out waiting for mailbox
> dspbridge: timed out waiting for mailbox
> dspbridge: timed out waiting for mailbox
> dspbridge: timed out waiting for mailbox
> dspbridge: timed out waiting for mailbox
> dspbridge: timed out waiting for mailbox
> dspbridge: timed out waiting for mailbox
> ...
>
> Did you see any issue when you change to 1ms? Maybe we can use a bigg=
er timeout.

Did you apply patch #1 of the B series?

I didn't see any timeout on my tests.

--=20
=46elipe Contreras

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
