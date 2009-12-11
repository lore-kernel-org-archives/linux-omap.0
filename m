From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] [OMAP] gpio: Simultaneously requested rising and falling
	edge
Date: Fri, 11 Dec 2009 11:43:33 -0800
Message-ID: <6cb013310912111143q4825b65eged6afedeb4da23f9@mail.gmail.com>
References: <1260503994-27823-1-git-send-email-darkstar6262@gmail.com>
	<873a3hmr4k.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:50941 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761133AbZLKTnq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 14:43:46 -0500
Received: by pwj9 with SMTP id 9so784114pwj.21
        for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 11:43:53 -0800 (PST)
In-Reply-To: <873a3hmr4k.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Fri, Dec 11, 2009 at 8:07 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Cory Maccarrone <darkstar6262@gmail.com> writes:
>
>
> I think this needs a little more description. =C2=A0In particular you
> should describe that this toggle happens on *every* interrupt, and
> why.
>
> Also, it's not exactly a noop for non-OMAP1. =C2=A0More on this below=
=2E..
>
> ...
>
> Not exactly a noop. =C2=A0This function is called for non-OMAP1 as we=
ll...
>
>
> ...and will write a zero to offset zero of the GPIO bank regs
> (GPIO_REVISION reg). =C2=A0While ths is a read-only reg and *should* =
have
> no effect, the point is that this function should not be called for
> non-OMAP1.
>
>
> Rather than check the flags on every interrupt, it may be better to
> create a per-bank mask for GPIOs that need this treatment.
>
> The code that sets that flag could be conditional on OMAP1 and also o=
n
> whether both edges are set.
>

Thanks for the feedback.  This is the first time I've dealt with this
code and I wanna make sure I get it right.  I'll take another look at
it and see what I can do.

Thanks
Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
