From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: add checking 128 byte alignment for dsp
	cache line size
Date: Mon, 11 May 2009 23:30:42 +0300
Message-ID: <94a0d4530905111330k47a8c28fkc78002e75ddd3e31@mail.gmail.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E2AF66245@dlee03.ent.ti.com>
	 <20090511.184705.116375196.Hiroshi.DOYU@nokia.com>
	 <94a0d4530905110931i3b81b991x9b7686c5bda25ff8@mail.gmail.com>
	 <20090511.203528.258116329.Hiroshi.DOYU@nokia.com>
	 <94a0d4530905111054x138375e3p5e2b6d08c9b31120@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2AF66543@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:21402 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755171AbZEKUam convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2009 16:30:42 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1005131fgg.17
        for <linux-omap@vger.kernel.org>; Mon, 11 May 2009 13:30:42 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E2AF66543@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, May 11, 2009 at 9:26 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wr=
ote:
> To summarize the discussion.
>
> We need to have the check for 128 bytes alignment (upper and lower). =
The 2 places that this can be done are in flush function or in Map func=
tion.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- I prefer the check is done in Map functi=
on as Felipe mentioned this function is bound to be called by MM compon=
ents as opposed to Flush function. Also, another reason is the flush fu=
nction in Bridge driver is going to be removed eventually.
>
> The open issue is the impact on the OMX components. Once if we finali=
ze that there is no impact on the existing OMX components or we have a =
plan to take this into account we can enforce this check.

=46irst of all the check is not required on input buffers, enforcing it
will make memory copy unavoidable on certain situations. That is not
good.

Also, it will break OMX components. The fix is trivial (use
posix_memalign for example) but code will need to be changed.

The easiest solution IMHO is to add a new ioctl which has other advanta=
ges.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
