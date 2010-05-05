From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
Date: Wed, 5 May 2010 11:31:35 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E351861@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1269263380-12995-1-git-send-email-hvaibhav@ti.com>
 <1271410679.2690.290.camel@tubuntu.research.nokia.com>
 <19F8576C6E063C45BE387C64729E7394044E1371C6@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E7394044E1EB360@dbde02.ent.ti.com>
 <1271848174.2433.49.camel@tubuntu.research.nokia.com>
 <19F8576C6E063C45BE387C64729E7394044E3516FE@dbde02.ent.ti.com>
 <20100504134507.GJ8310@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49303 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755382Ab0EEGBm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 02:01:42 -0400
In-Reply-To: <20100504134507.GJ8310@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Ville Syrj=E4l=E4 [mailto:ville.syrjala@nokia.com]
> Sent: Tuesday, May 04, 2010 7:15 PM
> To: Hiremath, Vaibhav
> Cc: Valkeinen Tomi (Nokia-D/Helsinki); linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP: DSS2: GFX FIFO UNDERFLOW issue fixed
>=20
> On Tue, May 04, 2010 at 03:23:10PM +0200, ext Hiremath, Vaibhav wrote=
:
> >
<snip>
> > I found the bug which is causing tearing effect, I tested it here w=
ith
> both, mine and your applications and for me it is working fine.
> >
> > Can you please check at your end?
> > (Sorry for the attachment)
>=20
> You should really avoid that. I can't quote the patch.
[Hiremath, Vaibhav] I completely understand, actually the intention of =
this patch is to test so avoided "git send-email".

>=20
> What are those CW<->CCW swaps that you do in the patch?
[Hiremath, Vaibhav] Did you observed how the rotation comes on the scre=
en? Does it rotate the image clockwise of anti-clockwise direction?

This is required to get clockwise rotation.

>=20
> Also I think the ioremap stuff is a bit broken since AFAICS it will
> leave the old angle still mapped when you rotate to another angle.
>=20
[Hiremath, Vaibhav] Why do you say that? Are you referring to changing =
rotation from sysfs here?

I hope you understand the change here, we are now mapping the write buf=
fer to user space and overlay DMA is configured to 0 degree address map=
=2E So when you change the only rotation without writing anything to bu=
ffer (mapping is important here, since it will map newly configured rot=
ated view) the display will stay intact.

I have tested with both SYSFS and FBIO_PUTVSCREENINFO ioctl, the only d=
ifference in behavior is you have to write it buffer to see rotated ima=
ge.

Thanks,
Vaibhav

> --
> Ville Syrj=E4l=E4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
