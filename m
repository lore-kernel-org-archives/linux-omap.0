From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Passing mem=1G to kernel on Panda, system is unstable.
Date: Fri, 14 Jan 2011 22:52:17 +0530
Message-ID: <36befcf1947882da51ace32cbfb0b922@mail.gmail.com>
References: <AANLkTin+ZjUoD9i+JxV7wW2+U6oEp42PdP5R4gdtzy=F@mail.gmail.com>
 <alpine.DEB.2.00.1101121649560.5731@utopia.booyaka.com> <AANLkTi=X-yUNvSkn-qNrAGSUoy_sNy9FzkeCzFECsBZF@mail.gmail.com>
 <alpine.DEB.2.00.1101132240220.28621@utopia.booyaka.com> <AANLkTimoSGkQV8suHD0-KFBq1wZc-VkzZ8ziZ81QaL9V@mail.gmail.com>
 <AANLkTimmnUq19qmBgAetA-+pkrCxwwfwA-kaBtAOqVeu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:33844 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752019Ab1ANRWT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Jan 2011 12:22:19 -0500
Received: by mail-gy0-f177.google.com with SMTP id 4so1239362gyg.36
        for <linux-omap@vger.kernel.org>; Fri, 14 Jan 2011 09:22:18 -0800 (PST)
In-Reply-To: <AANLkTimmnUq19qmBgAetA-+pkrCxwwfwA-kaBtAOqVeu@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Jan <s-jan@ti.com>, Bryan Wu <bryan.wu@canonical.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

Seb,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Jan, Sebastien
> Sent: Friday, January 14, 2011 10:41 PM
> To: Bryan Wu
> Cc: Paul Walmsley; linux-omap@vger.kernel.org; Ricardo Salveti de
> Araujo
> Subject: Re: Passing mem=3D1G to kernel on Panda, system is unstable.
>
> On Fri, Jan 14, 2011 at 11:09 AM, Bryan Wu <bryan.wu@canonical.com>
> wrote:
> > On Fri, Jan 14, 2011 at 1:41 PM, Paul Walmsley <paul@pwsan.com>
> wrote:
> >> On Thu, 13 Jan 2011, Bryan Wu wrote:
> >>
> >>> On Thu, Jan 13, 2011 at 7:50 AM, Paul Walmsley <paul@pwsan.com>
> wrote:
> >>> > On Wed, 12 Jan 2011, Bryan Wu wrote:
> >>> >
> >>> > Does the problem also happen if you boot with 'nosmp' on the
> kernel
> >>> > command line?
> >>>
> >>> Yeah, I think so, since Sebastien reported that 'nosmp' doesn't
> work either.
> >>
> >> Will try to find time to give this a shot. =A0You might want to tr=
y
> a build
> >> without CONFIG_SMP set to see if it helps.
> >>
> > Thanks a lot, man. Sebastien and I will try to disable CONFIG_SMP
> with
> > mainline kernel on Panda.
>
> I just tested with the 2.6.37 mainline kernel and Bryan config, and
> can reproduce the issue with CONFIG_SMP disabled.
Can you try the patch I sent on the list as well ?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
