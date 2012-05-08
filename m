From: Ming Lei <ming.lei@canonical.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Wed, 9 May 2012 06:12:15 +0800
Message-ID: <CACVXFVOVFPnvWxtqYPPz2drY3AjPWxJHqF5ZCiEdmEqOrdr4Qw@mail.gmail.com>
References: <20120403092524.GD17741@mudshark.cambridge.arm.com>
	<CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
	<20120403094749.GH17741@mudshark.cambridge.arm.com>
	<CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
	<20120403123444.GL17741@mudshark.cambridge.arm.com>
	<878vicsxef.fsf@ti.com>
	<20120403160706.GP17741@mudshark.cambridge.arm.com>
	<87ehs4pfw4.fsf@ti.com>
	<alpine.DEB.2.00.1204031727380.8000@utopia.booyaka.com>
	<20120404111524.GF32505@mudshark.cambridge.arm.com>
	<20120426180719.GC20186@mudshark.cambridge.arm.com>
	<4FA45580.8070802@ti.com>
	<87ipg76hfm.fsf@ti.com>
	<4FA8284C.7080803@ti.com>
	<87k40nzi3i.fsf@ti.com>
	<4FA8FCFF.40105@ti.com>
	<CAORVsuWMhVQkQAmsyrprvW-0hK4y=RgGayn0p8WhyksScauBQQ@mail.gmail.com>
	<4FA9138D.8010604@ti.com>
	<CAORVsuWQ6o64Jhpox0ZvjYAfzDJkXCc6XYX2a6o_cOdNyFdA0g@mail.gmail.com>
	<87aa1isrg2.fsf@ti.com>
	<4FA927B1.4020108@ti.com>
	<87wr4mr6io.fsf@ti.com>
	<4FA9794A.7030607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45736 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387Ab2EHWMT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 18:12:19 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1SRsdm-0003jX-18
	for linux-omap@vger.kernel.org; Tue, 08 May 2012 22:12:18 +0000
Received: by dady13 with SMTP id y13so3203203dad.19
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 15:12:16 -0700 (PDT)
In-Reply-To: <4FA9794A.7030607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Will Deacon <will.deacon@arm.com>, Jean Pihet <jean.pihet@newoldbits.com>, Maynard Johnson <maynardj@us.ibm.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, Lik Lik <lik88888@gmail.com>, "eranian@gmail.com" <eranian@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, May 9, 2012 at 3:51 AM, Jon Hunter <jon-hunter@ti.com> wrote:
>
>
> I had to make a couple mods to Ming's patches but I do have something
> working now that _should_ not break PM. However, per my previous email
> (in response to Benoit's) I am struggling with the definition of the
> CLKDM_CAN_XXXXXX_AUTO flags to know the correct way to fix this.
>
> I was going to send out my patches, but I wanted to get some more
> feedback on this first.

I can test your patch once I return home from business trip next week.


Thanks,
--
Ming Lei
