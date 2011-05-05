From: Colin Cross <ccross@google.com>
Subject: Re: Common clock and dvfs
Date: Wed, 4 May 2011 23:50:52 -0700
Message-ID: <BANLkTimfN-1J8LifEzsnJ-GFfp0GXGDm+A@mail.gmail.com>
References: <4DC07F10.6010305@ti.com>
	<4DC230E0.7090909@ti.com>
	<BANLkTi=gP80iiJTECUoc+36z_1J68ALJNA@mail.gmail.com>
	<alpine.DEB.2.00.1105050026420.30136@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:37466 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab1EEGvQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 02:51:16 -0400
Received: from hpaq6.eem.corp.google.com (hpaq6.eem.corp.google.com [172.25.149.6])
	by smtp-out.google.com with ESMTP id p456otVk014450
	for <linux-omap@vger.kernel.org>; Wed, 4 May 2011 23:50:55 -0700
Received: from gwb17 (gwb17.prod.google.com [10.200.2.17])
	by hpaq6.eem.corp.google.com with ESMTP id p456oq0r015053
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 4 May 2011 23:50:53 -0700
Received: by gwb17 with SMTP id 17so778618gwb.29
        for <linux-omap@vger.kernel.org>; Wed, 04 May 2011 23:50:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1105050026420.30136@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Hilman, Kevin" <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Turquette, Mike" <mturquette@ti.com>, Thomas Gleixner <tglx@linutronix.de>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Mark Brown <broonie@sirena.org.uk>

On Wed, May 4, 2011 at 11:35 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 4 May 2011, Colin Cross wrote:
>
>> Imagine a chip where a clock can feed devices A, B, and C. =A0If the
>> devices are always clocked at the same rate, and can't gate their
>> clocks, the minimum voltage that can be applied to a rail is
>> determined ONLY by the rate of the clock.
>
> That's not so -- although admittedly it's a side issue, and not
> particularly related to DVFS.
>
> For example, the device may have some external I/O lines which need t=
o be
> at least some minimum voltage level for the externally-connected devi=
ce to
> function. =A0This minimum voltage level can be unrelated to the devic=
e's
> clock frequency.

True, that was an oversimplificaiton. I meant the minimum voltage that
scales with clock frequencies only depends on the clock frequency, not
the device.  Devices do need to be able to specify a higher minimum
voltage, and the regulator api needs to handle it.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
