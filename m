From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: ARM defconfig files
Date: Mon, 12 Jul 2010 16:18:01 -0700
Message-ID: <AANLkTimho3rcoCZZ2PlC3B3KIZZhsEiTnTk-__n1q_Dy@mail.gmail.com>
References: <alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org>
	<AANLkTinxUqzxClVDTyruJ6kzFTganXUGJJHJ5wRi9Iak@mail.gmail.com>
	<20100712185029.GB14425@pengutronix.de>
	<201007121605.32462.davidb@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37820 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755569Ab0GLXSi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Jul 2010 19:18:38 -0400
In-Reply-To: <201007121605.32462.davidb@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brown <davidb@codeaurora.org>
Cc: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Walker <dwalker@codeaurora.org>, Kevin Hilman <khilman@deeprootsystems.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Eric Miao <eric.miao@canonical.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>

2010/7/12 David Brown <davidb@codeaurora.org>:
>
> Do you have scripts or tools that you did this with, or is a manual
> process. =A0We're about to add several new (ARM) targets, and it'd be
> nice to be able to make small defconfigs for those targets as well.

Uwe posted it earlier in this thread as an attachement, and I put the
python script into the merge commit message too. And we should
probably put it somewhere in scripts too, and/or make a 'make' target
to create the small config files.

I pushed it all out, and tagged it as -rc5.

                 Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
