From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 1/2] OMAP4: HDMI: Add OMAP device for HDMI audio CPU DAI
Date: Mon, 23 May 2011 22:39:38 -0500
Message-ID: <1306208378.1897.302.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
References: <1305602079-3852-1-git-send-email-ricardo.neri@ti.com>
	 <1305602079-3852-2-git-send-email-ricardo.neri@ti.com>
	 <4DD2CDED.6090605@gmail.com> <201105180841.20224.peter.ujfalusi@ti.com>
	 <4DD3FCC2.3020908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34966 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757011Ab1EXDlJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 May 2011 23:41:09 -0400
In-Reply-To: <4DD3FCC2.3020908@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Calfee <stevecalfee@gmail.com>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "paul@pwsan.com" <paul@pwsan.com>

Hi Steve,

Le mercredi 18 mai 2011 =C3=A0 12:07 -0500, Steve Calfee a =C3=A9crit :
> On 05/17/11 22:41, Peter Ujfalusi wrote:
> > On Tuesday 17 May 2011 22:35:09 Steve Calfee wrote:
> >> I think the generally accepted method of doing stuff like this is =
to
> >> have the ifdeffery in a header file where a inline code segment is
> >> defined if it applies to the processor being built. If the code do=
es not
> >> apply to the model being built, a null #define is used, which does=
 not
> >> take any space.
> >=20
> > We have for example omap2plus_defconfig, which include support for =
wide range=20
> > of OMAP based devices, with different CPUs (OMAP2/3/4).
> > So we need to have runtime distinction of the CPU we are running (s=
ince we run=20
> > the same kernel binary on OMAP2/3/4).
> >=20
>=20
> Hi Peter,
>=20
> I am not trying to start a flame war here, especially not with you
> really helpful people.
>=20
> The preferred header contained ifdeffery does not exclude the
> possibility of having multiple options selected, even at run time. It
> also can prevent multi cpu code bloat if it is not wanted.
> Alternatively, X86 distributions such as Ubuntu already deal with
> multiple arches (within the base arch intel/amd), using initrd type
> startups.
>=20
> Also the current "cpu_is" stuff is not very scalable, when TI gets to
> Omap42, or even slightly smaller such as Omap5, the untidiness of the
> current technique will become even more of a problem.
>=20
> Regards, Steve

Thanks for your comments. Even though the use of cpu_is_ may not be the
best approach, it is used extensively in OMAP code. Do you think that
this situation needs to be fixed before accepting the patches for these
two devices?

Also, in the case of OMAP, runtime CPU identification is needed, for th=
e
reason Peter mentions. It is hard for me to see how it can be
implemented using #ifdef only. Do you think that runtime CPU
identification should be moved to the header containing the ifdeferry?
Individual functions for different domains (audio, video, etc.) would
still need to check at runtime if their devices are required. Perhaps
having a single omap2plus_defconfig for all OMAP2/3/4/x/y/... devices i=
s
no longer convenient as more and more OMAP families arrive. What do you
think?

Regarding using a initrd, that applies only for loadable modules, but
not for built-in modules, correct?

BR,
Ricardo


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
