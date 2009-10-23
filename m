From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: RE: [PATCH 01/17] PM: fix suspend control for IVA2
Date: Fri, 23 Oct 2009 08:22:05 +0300
Message-ID: <1256275325.29885.213.camel@localhost>
References: <> <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
	 <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
	 <alpine.DEB.2.00.0910220419550.17644@utopia.booyaka.com>
	 <13B9B4C6EF24D648824FF11BE8967162039B459EE8@dlee02.ent.ti.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:18153 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbZJWFWM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 01:22:12 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162039B459EE8@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tero Kristo <tero.kristo@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "Ghongdemath, Girish" <girishsg@ti.com>, "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

On Thu, 2009-10-22 at 16:21 -0500, Woodruff, Richard wrote:
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Paul Walmsley
> > Sent: Thursday, October 22, 2009 5:24 AM
>=20
> > > IVA2 controls its target power state individually, thus suspend s=
hould not
> > > touch IVA2. Without this patch DSP suspend always fails.
> >
> > We don't allow other device drivers to touch PRCM bits, so we shoul=
d
> > probably should remove all PRCM register accesses from the DSPBridg=
e code,
> > so all power control should go through the ARM.
> >
> > Is there a reason why the ARM code can't handle the DSP powerdomain=
?
>=20
> Sharing with DSP is something which probably could use some improveme=
nt.
>=20
> Today DSP self-manages its domain.  Its (bios) micro-kernel makes dec=
isions to optimize its domain. The ARM can't really micro-manage the DS=
P as he doesn't even want to know at the detail level what the DSP is u=
p to at every instant.
>=20
> - During idle time cpuidle should just be checking dsp status to see =
if its current state gets in the way of a low c-state.
>=20
> - bridge does register with suspend frame work so he should do the ri=
ght thing when in the system.
>=20
> * problem is when bridge isn't there what to do.  This is especially =
after an unload of the bridge.

Just a side note reminder: bridge does not exist in the real world.

[dedekind@sauron linux-omap-2.6]\$ ls drivers/dsp/bridge
ls: cannot access drivers/dsp/bridge: No such file or directory

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
