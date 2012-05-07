From: Ming Lei <ming.lei@canonical.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Tue, 8 May 2012 01:27:48 +0800
Message-ID: <CACVXFVODqzz+1gOc0PvzpnCAeF9UL=qJG5Zjg9KD9hkNTEy3AA@mail.gmail.com>
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
	<871un4q2ku.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:39950 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072Ab2EGR1w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 13:27:52 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1SRRiw-0003d1-Ow
	for linux-omap@vger.kernel.org; Mon, 07 May 2012 17:27:50 +0000
Received: by pbbrp8 with SMTP id rp8so6934478pbb.19
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 10:27:49 -0700 (PDT)
In-Reply-To: <871un4q2ku.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Will Deacon <will.deacon@arm.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Maynard Johnson <maynardj@us.ibm.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, Lik Lik <lik88888@gmail.com>, "eranian@gmail.com" <eranian@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, May 1, 2012 at 6:25 AM, Kevin Hilman <khilman@ti.com> wrote:

> Unfortunately, digging in the code isn't going to help much.
>
> We've been trying to get our heads around some undocumented reset
> behavior for the various debug IPs in OMAP.
>
> After a little digging and clarification from HW designers, it appear=
s
> that if we allow the EMU clockdomain to idle, a full reset of the deb=
ug
> IPs is done. =A0That means there are two solutions to this problem:
>
> 1) don't ever alow EMU clockdomain to idle.
> 2) modify CTI driver to re-init for every use.
>
> Obviously (1) is the easiet, and hacks for that have already been
> posted, but that has pretty significant impacts on power savings. =A0=
(2)
> is the right solution to merge upstream, but needs writing.
>
> For (2), using runtime PM methods in the driver would be the simplest
> here since the ->runtime_resume method will be called every time the
> device is about to be used.

The previous patch has supported runtime pm on omap4 pmu[1], but still
didn't fix the problem. Could you comment on the patch and point out
the proper way to support pmu runtime for fixing the problem?


[1], http://marc.info/?l=3Dlinux-arm-kernel&m=3D131946777028358&w=3D2

Thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
