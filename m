From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: Issues with PM Branch
Date: Wed, 29 Apr 2009 09:25:30 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C01069283F6@dlee02.ent.ti.com>
References: <cb8016980904280917r453eee32tb582a212a6f529e5@mail.gmail.com>
	 <8763gopdrp.fsf@deeprootsystems.com>
 <cb8016980904282345m31a1b041jacaf70338c80467d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56700 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbZD2OZh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Apr 2009 10:25:37 -0400
In-Reply-To: <cb8016980904282345m31a1b041jacaf70338c80467d@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abraham Arce <abraham.arce.moreno@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Abraham Arce
>=20
> > The non-USB related hang looks like the problem when using smartref=
lex
> > without SRF. =A0If you disable smartreflex, or use smartreflex with=
 SRF
> > you should boot past that hang.
> >
> > For MUSB, it has not yet been validated on the PM branch.
>=20
> Thanks Kevin... I have disabled SmartReflex, it is booting now but
> after some time of interaction, console will become unresponsive,
> commands won't be executed
>=20
>  # ps -aux
>  ^C
>=20
> Is there any setting I should set up before in menuconfig? sysfs?
>=20
You may want to check with a ramdisk first -> just to ensure you are no=
t mixing up any NFS server timeouts

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
