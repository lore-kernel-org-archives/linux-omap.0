From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC][PATCH 3/9] OMAP4460: HWMOD: DO not reset GPIO1 during HWMOD init
Date: Fri, 27 May 2011 07:59:23 -0700
Message-ID: <87vcww5gvo.fsf@ti.com>
References: <1306375016-707-1-git-send-email-nm@ti.com>
	<1306375016-707-4-git-send-email-nm@ti.com> <87oc2p82q0.fsf@ti.com>
	<4DDF4E4D.6060008@ti.com>
	<BANLkTi=dHknRn5KJSh3_bG-o19BUg2AjrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:42080 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751525Ab1E0O70 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 10:59:26 -0400
Received: by mail-pv0-f179.google.com with SMTP id 33so830117pvf.10
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 07:59:25 -0700 (PDT)
In-Reply-To: <BANLkTi=dHknRn5KJSh3_bG-o19BUg2AjrA@mail.gmail.com> (Govindraj's
	message of "Fri, 27 May 2011 12:56:30 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Sonasath, Moiz" <m-sonasath@ti.com>

Govindraj <govindraj.ti@gmail.com> writes:

> On Fri, May 27, 2011 at 12:40 PM, Cousson, Benoit <b-cousson@ti.com> =
wrote:
>
>     On 5/27/2011 1:24 AM, Hilman, Kevin wrote:
>
>         Nishanth Menon<nm@ti.com> =C2=A0writes:
>
>
>             From: Moiz Sonasath<m-sonasath@ti.com>
>
>             For OMAP4460, GPIO-7 of bank1 is used for controling
>             the TPS modes, hence GPIO1 should not be reset
>             during init as reset will cause the TPS voltage to
>             drop to 0.9 V.
>
>
>         ouch. =C2=A0I knew one of these days something like this was =
going to happen
>         with GPIO resets.
>
>
>     BTW, don't we have the same kind of issue with the debug UART? I =
remember
>     that you had to do some hacks at some point to change these hwmod=
 flags in
>     the UART code.
>
>
> Yes. we use below flags.
>
> uart->oh->flags |=3D HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET;
>

This is a hack (written by me) because the UART driver is not runtime P=
M
adapted.  When UART driver is runtime PM adapted, this will not be
needed.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
