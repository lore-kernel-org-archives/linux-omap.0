From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/1] ARM: only call smp_send_stop() on SMP
Date: Sun, 24 Jun 2012 12:21:19 +0200
Message-ID: <CABxcv=n4MSQ=9S-iaVjO3wZ5+CoonYt28Fss+69byD83C0FzNg@mail.gmail.com>
References: <1340511667-4976-1-git-send-email-javier@dowhile0.org>
	<20120624085943.GC19226@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60017 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454Ab2FXKVU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 24 Jun 2012 06:21:20 -0400
Received: by obbuo13 with SMTP id uo13so4761389obb.19
        for <linux-omap@vger.kernel.org>; Sun, 24 Jun 2012 03:21:19 -0700 (PDT)
In-Reply-To: <20120624085943.GC19226@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Will Deacon <will.deacon@arm.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Sun, Jun 24, 2012 at 10:59 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> See this thread:
>
> http://lists.arm.linux.org.uk/lurker/thread/20120523.200015.2fdfd505.=
en.html
>
> There are times when I wonder why I bother replying to email on maili=
ng
> lists. =C2=A0No patch ever came from my responses on this subject. =C2=
=A0Not going
> to repeat it again. =C2=A0Fed up.
>
> On Sun, Jun 24, 2012 at 06:21:07AM +0200, Javier Martinez Canillas wr=
ote:

Hi Russell,

I didn't know that this was discussed before sorry.

I'll send a v2 of the patch that uses your suggested approach.

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
