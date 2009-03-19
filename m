From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH B 3/3] tidspbridge: decreate timeout to a saner value
Date: Thu, 19 Mar 2009 23:04:05 +0200
Message-ID: <94a0d4530903191404y14b5331eoaccb3f11c1846f9d@mail.gmail.com>
References: <1237339605-20697-1-git-send-email-felipe.contreras@gmail.com>
	 <1237339605-20697-2-git-send-email-felipe.contreras@gmail.com>
	 <1237339605-20697-3-git-send-email-felipe.contreras@gmail.com>
	 <1237339605-20697-4-git-send-email-felipe.contreras@gmail.com>
	 <496565EC904933469F292DDA3F1663E60287D6286E@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:49502 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274AbZCSVEI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 17:04:08 -0400
Received: by fg-out-1718.google.com with SMTP id 16so135308fgg.17
        for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2009 14:04:05 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E60287D6286E@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

On Thu, Mar 19, 2009 at 10:42 PM, Guzman Lugo, Fernando <x0095840@ti.co=
m> wrote:
>
>
> Hi Felipe,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0I am seeing with this patch because of the=
 timeout:
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
