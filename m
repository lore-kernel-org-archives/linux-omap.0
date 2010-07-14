From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: ARM defconfig files
Date: Wed, 14 Jul 2010 12:13:07 +0300
Message-ID: <AANLkTimttp-YgYADPU5scbcSeb-7lb5d7Cf-_g_-0uJ7@mail.gmail.com>
References: <alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org>
	<201007121605.32462.davidb@codeaurora.org>
	<AANLkTimho3rcoCZZ2PlC3B3KIZZhsEiTnTk-__n1q_Dy@mail.gmail.com>
	<201007121634.04427.davidb@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201007121634.04427.davidb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brown <davidb@codeaurora.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Walker <dwalker@codeaurora.org>, Kevin Hilman <khilman@deeprootsystems.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Eric Miao <eric.miao@canonical.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 13, 2010 at 2:34 AM, David Brown <davidb@codeaurora.org> wr=
ote:
> It seems a bit brute force, probably not something I can make part of
> our regular build process, but I can definitely run it before sending
> patches out.
>
> I wonder if there's a more efficient way of doing it that doesn't
> involve invoking make for each line of the file. =C2=A0It at least
> shouldn't be necessary to actually build the kernel each time.

Yes, I think there's a more efficient way to do it, but it would
require the SAT resolver, or something like that.

--=20
=46elipe Contreras
