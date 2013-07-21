From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: Need help for DT GPIO probing
Date: Sun, 21 Jul 2013 06:54:46 +0200
Message-ID: <CAAwP0s3S8r_UPBZykxVoTrkLOWDMcBUaYLNziK+e7aLq9m6kig@mail.gmail.com>
References: <CACpRUmig-J7tgipRFC5h09+4fHiOWpHpc3ELuTnujE1_gQCZrw@mail.gmail.com>
	<CACRpkdYXK6Phg4H5UviLSsJPsCOjykHRe3EnKpMphdFdOdnZUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:59916 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab3GUEyr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Jul 2013 00:54:47 -0400
In-Reply-To: <CACRpkdYXK6Phg4H5UviLSsJPsCOjykHRe3EnKpMphdFdOdnZUA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Soumya Sutar <soumyasutar@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, ext Tony Lindgren <tony@atomide.com>, ext Kevin Hilman <khilman@deeprootsystems.com>

Hi Soumya

On Saturday, July 20, 2013, Linus Walleij wrote:
>
> On Fri, Jul 12, 2013 at 4:05 PM, Soumya Sutar <soumyasutar@gmail.com>=
 wrote:
>
> > Hi Linus,
> >
> > I am facing DT GPIO probing problem same as below link.
> > http://us.generation-nt.com/answer/gpio-crashed-when-not-using-help=
-208346861.html
> >
> > Could you know any patch is available for this issues or still we n=
eed to
> > use gpio_request() in driver.
>

Yes, Linus W has already queued some patches for gpio-omap on the
for-next branch of his linux-gpio tree [1] that solves this issue.

Take a look to commit b4419e1a ("gpio/omap: auto request GPIO as input
if used as IRQ via DT") although this patch depends on others so you
should merge the whole branch to make it work.

Linus, are you still planing to send this patches as fixes for the
v3.11 -rc cycle or did you decide to wait for v3.12?

>
> Please ask questions like this on the mailing lists and include
> the OMAP GPIO maintainers (Santosh & Kevin).
>
> And the answer is yes, all GPIO lines you are using need to
> be requested by the driver.
>
> Yours,
> Linus Walleij
> --

Thanks a lot and best regards,
Javier

[1]: =C2=A0https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-gp=
io.git/log/?h=3Dfor-next
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
