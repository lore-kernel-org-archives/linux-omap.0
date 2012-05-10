From: Kevin Hilman <khilman@ti.com>
Subject: Re: oprofile and ARM A9 hardware counter
Date: Thu, 10 May 2012 07:12:21 -0700
Message-ID: <874nronn0a.fsf@ti.com>
References: <20120403092524.GD17741@mudshark.cambridge.arm.com>
	<20120403094749.GH17741@mudshark.cambridge.arm.com>
	<CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
	<20120403123444.GL17741@mudshark.cambridge.arm.com>
	<878vicsxef.fsf@ti.com>
	<20120403160706.GP17741@mudshark.cambridge.arm.com>
	<87ehs4pfw4.fsf@ti.com>
	<alpine.DEB.2.00.1204031727380.8000@utopia.booyaka.com>
	<20120404111524.GF32505@mudshark.cambridge.arm.com>
	<20120426180719.GC20186@mudshark.cambridge.arm.com>
	<4FA45580.8070802@ti.com> <87ipg76hfm.fsf@ti.com>
	<4FA8284C.7080803@ti.com> <87k40nzi3i.fsf@ti.com>
	<4FA8FCFF.40105@ti.com> <4FA9588E.9020906@ti.com>
	<87sjfal65t.fsf@ti.com> <4FAA4DB9.8060504@ti.com>
	<4FAAB1A3.9040806@ti.com> <4FAAC549.6010206@ti.com>
	<4FAAE564.6040708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:33032 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932130Ab2EJOM3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 10:12:29 -0400
Received: by pbbrp2 with SMTP id rp2so2205406pbb.0
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 07:12:27 -0700 (PDT)
In-Reply-To: <4FAAE564.6040708@ti.com> (Jon Hunter's message of "Wed, 9 May
	2012 16:45:08 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Maynard Johnson <maynardj@us.ibm.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "oprofile-list@lists.sourceforge.net" <oprofile-list@lists.sourceforge.net>, Lik Lik <lik88888@gmail.com>, "eranian@gmail.com" <eranian@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Jon Hunter <jon-hunter@ti.com> writes:

[...]

> I have posted my latest series here [1] based upon that from Will [2]
> which attempts to fix the EMU CD based upon the inputs from this thread.
> It is working on my omap4460 panda. 

There are some differences between 4430 and 4460 here.  Can you test on
4430 as well?

Kevin
