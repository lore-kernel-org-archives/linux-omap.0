From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [RFC][PATCH 3/9] OMAP4460: HWMOD: DO not reset GPIO1 during HWMOD init
Date: Sat, 28 May 2011 20:11:53 -0500
Message-ID: <BANLkTikG6FALym4gbQOrm1AjniL9DF2JHQ@mail.gmail.com>
References: <1306375016-707-1-git-send-email-nm@ti.com> <1306375016-707-4-git-send-email-nm@ti.com>
 <87oc2p82q0.fsf@ti.com> <4DDF4E4D.6060008@ti.com> <87oc2ox7bm.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:32979 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753461Ab1E2BMP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 28 May 2011 21:12:15 -0400
Received: by wyb32 with SMTP id 32so2590725wyb.2
        for <linux-omap@vger.kernel.org>; Sat, 28 May 2011 18:12:13 -0700 (PDT)
In-Reply-To: <87oc2ox7bm.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Sonasath, Moiz" <m-sonasath@ti.com>

On Fri, May 27, 2011 at 14:38, Kevin Hilman <khilman@ti.com> wrote:
>
> "Cousson, Benoit" <b-cousson@ti.com> writes:
>
> [...]
>
> > In general we do not want to reset nor idle an IP that was potentia=
lly
> > already properly configured by bootloader or early Linux boot code.
>
> Actually, the opposite is true.
>
> The kernel should not make any assumptions about what the bootloader =
has
> or has not done. =A0We need to have a kernel that can boot from any
> bootloader (or none, like using kexec) and be able to start from a kn=
own
> hardware state.
>
> Any use of HWMOD_INIT_NO_IDLE, HWMOD_INIT_NO_RESET should be a rare
> exception and well documented.

Looking deeper to find the rootcause, I see this:
a) TI provides a reference schematics design that is usually copied on
to most of the platforms - e.g. blaze and panda etc.. this may not be
the norm, but tends to be same except for intrepid board designers who
like to go into unexplored areas.
b) in this case, I tracked the issue down. Here is what is happening
(given NDA restrictions as the datasheet of the PMIC is not pubic yet,
I am being vague here. Apologies on the same :():

This PMIC has one voltage output which drives MPU - just like the
1vsel per rail as we had in TWL series, here we have an option of
storing n values in n vsel registers and selecting one of them. the
selection is based on x pins that may be driven by the MPU.

In this particular case, one of the pins is connected to OMAP GPIO1
block allowing PMIC to set the voltage from one of two options inside
the PMIC -  This could have been used like we'd have done in OMAP2
days with VMODE pin.

However, in our TI's x-loader case it sets it to 1, and since hwmod
reset happens here, it gets set to 0, selecting a much lower voltage
than what is needed for functioning causing system to hangup. Now,
with this reference design, many things are possible - folks following
TI x-loader might pull the pin high, could pull the pin low or even go
and ground the pin and free up the GPIO itself.

now we have two cases:
a) folks who follow TI's recommendations verbatim
b) intrepid folks who like doing their own things.

What should the default kernel look like here? I think I agree - it
should be board files that is usually tied to a particular bootloader
(exception being devel boards like Beagle, Panda, Blaze etc where
people do develop bootloaders as well..). I agree with kevin here -
this should be done by board file.


Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
