From: Felipe Balbi <balbi@ti.com>
Subject: Re: [beagleboard] EHCI softirq kernel panic
Date: Wed, 10 Aug 2011 01:20:13 +0300
Message-ID: <20110809222012.GB4008@legolas.emea.dhcp.ti.com>
References: <CAD=GYpZs8L4rKr_Bz1fnx=Lose4aE4=VWBc615FeRDhx0s=a3g@mail.gmail.com>
 <CA+T6QPkBwexw9OyxGDAQN2xgmQ64sv362FDBrRvSRXA+i4B2Aw@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:38924 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750984Ab1HIWUU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 18:20:20 -0400
Content-Disposition: inline
In-Reply-To: <CA+T6QPkBwexw9OyxGDAQN2xgmQ64sv362FDBrRvSRXA+i4B2Aw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Kridner <jkridner@beagleboard.org>
Cc: beagleboard@googlegroups.com, "Kridner, Jason" <jdk@ti.com>, "Kooi, Koen" <k-kooi@ti.com>, linux-omap@vger.kernel.org, Linux USB Mailing List <linux-usb@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 09, 2011 at 02:30:14PM -0400, Jason Kridner wrote:
> On Tue, Aug 9, 2011 at 1:51 PM, Joel A Fernandes <agnel.joel@gmail.com> w=
rote:
> > Anyone seen this before?
>=20
> A lot of the kernel developers don't frequent the beagleboard list.
> If you think it is a general kernel bug, I suspect you want to copy
> linux-omap.

and linux-usb, and Alan Stern as he's the EHCI maintainer and myself for
the OMAP USB part ;-)

> > Trying to boot 3.0.0 with OE patches from an SD Card, and with a
> > network cable connected results in the following traceback.
> > Not connecting a network cable makes the errors go away.
> >
> > [ =A0 83.386779] Process gtk-update-icon (pid: 351, stack limit =3D 0xd=
d95c2f0)
> > [ =A0 83.393798] Stack: (0xdd95dfb0 to 0xdd95e000)
> > [ =A0 83.398345] dfa0: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 007f9225
> > 007ba664 000000bf 2fffffff
> > [ =A0 83.406890] dfc0: 00ff2f2f 00ff0000 00ff0000 00ff0000 00ff0000
> > 00ff0000 00000000 00799225
> > [ =A0 83.415435] dfe0: 00ff0000 be9f8780 000000ff 4027e084 20000010
> > ffffffff 00000000 00000000
> > [ =A0 83.423980] Code: bad PC value
> > [ =A0 83.427490] ---[ end trace 4ae88755f08e391e ]---
> > [ =A0 83.434570] S98configure[58]: Segmentation fault
> > [ =A0 83.840148] S98configure[58]: Segmentation fault
> > [ =A0 83.867004] S98configure[58]: gtk-update-icon-cache: Failed to open
> > file /usr/share/icons/gnome/.icon-theme.cache : File exists
> > [ =A0 89.605407] S98configure[58]: gtk-update-icon-cache: Failed to open
> > file /usr/share/icons/HighContrastLargePrint/.icon-theme.cache : File
> > exists
> > [ =A0 89.932525] S98configure[58]: gtk-update-icon-cache: Failed to open
> > file /usr/share/icons/Mist/.icon-theme.cache : File exists
> > [ =A0 89.967773] S98configure[58]: gtk-update-icon-cache: Failed to open
> > file /usr/share/icons/gnome/.icon-theme.cache : File exists
> > [ =A0 91.477386] S98configure[58]: gtk-update-icon-cache: Failed to open
> > file /usr/share/icons/HighContrastLargePrint/.icon-theme.cache : File
> > exists
> > [ =A0 91.788269] S98configure[58]: gtk-update-icon-cache: Failed to open
> > file /usr/share/icons/Mist/.icon-theme.cache : File exists
> > [ =A0 91.822631] S98configure[58]: gtk-update-icon-cache: Failed to open
> > file /usr/share/icons/gnome/.icon-theme.cache : File exists
> > [ =A0 94.313598] S98configure[58]: gtk-update-icon-cache: Failed to open
> > file /usr/share/icons/HighContrastLargePrint/.icon-theme.cache : File
> > exists
> > [ =A0 95.381011] S98configure[58]: gtk-update-icon-cache: Failed to open
> > file /usr/share/icons/Mist/.icon-theme.cache : File exists
> > [ =A0 95.415405] S98configure[58]: gtk-update-icon-cache: Failed to open
> > file /usr/share/icons/gnome/.icon-theme.cache : File exists
> > [ =A0 99.084899] Unable to handle kernel NULL pointer dereference at
> > virtual address 00000000
> > [ =A0 99.093383] pgd =3D c0004000
> > [ =A0 99.096191] [00000000] *pgd=3D00000000
> > [ =A0 99.099945] Internal error: Oops: 17 [#2]
> > [ =A0 99.104125] Modules linked in: ipv6
> > [ =A0 99.107788] CPU: 0 =A0 =A0Tainted: G =A0 =A0 =A0D =A0 =A0 =A0(3.0.=
0+ #1)
> > [ =A0 99.113342] PC is at ehci_quiesce+0xc/0x94
> > [ =A0 99.117614] LR is at ehci_stop+0x34/0x8c
> > [ =A0 99.121734] pc : [<c0325ce4>] =A0 =A0lr : [<c0328bfc>] =A0 =A0psr:=
 200001d3
> > [ =A0 99.121734] sp : c064de70 =A0ip : 00000108 =A0fp : c06b8624
> > [ =A0 99.133728] r10: c064dec0 =A0r9 : 00000000 =A0r8 : dee08504
> > [ =A0 99.139190] r7 : c0328b94 =A0r6 : 00000100 =A0r5 : dee08504 =A0r4 =
: dee08608
> > [ =A0 99.145996] r3 : 00000000 =A0r2 : dee086ec =A0r1 : dee086b8 =A0r0 =
: dee08608
> > [ =A0 99.152832] Flags: nzCv =A0IRQs off =A0FIQs off =A0Mode SVC_32 =A0=
ISA ARM
> > Segment kernel
> > [ =A0 99.160644] Control: 10c5387d =A0Table: 9d804019 =A0DAC: 00000015
> > [ =A0 99.166656] Process swapper (pid: 0, stack limit =3D 0xc064c2f0)
> > [ =A0 99.172760] Stack: (0xc064de70 to 0xc064e000)
> > [ =A0 99.177307] de60: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 dee08608
> > dee086b8 dee08608 dee08504
> > [ =A0 99.185852] de80: 00000100 c0328bfc 00000001 a0000153 dee08504
> > c007a3d4 00200200 60000153
> > [ =A0 99.194396] dea0: dee08504 c007a3d4 00200200 c06b87a0 c064c000
> > c007a3d4 c064c000 00000003
> > [ =A0 99.202941] dec0: c064dec0 c064dec0 0000000a 00000001 c06b8628
> > c064c000 00000100 c06b8600
> > [ =A0 99.211517] dee0: 0000000a c0075ec0 0000a246 c0677bdc 00000000
> > 00000001 00000003 00000025
> > [ =A0 99.220062] df00: 00000000 c0654258 00000003 00000003 413fc082
> > 00000000 00000000 c0076290
> > [ =A0 99.228607] df20: 00000025 c0040064 60000053 ffffffff fa200000
> > c0044ff8 00051f4d 00000000
> > [ =A0 99.237152] df40: 00051f4d 00000000 c06a662c c0654258 c0654258
> > 00000003 00000003 413fc082
> > [ =A0 99.245697] df60: 00000000 00000000 00000000 c064df80 c0054dcc
> > c0054dd8 60000053 ffffffff
> > [ =A0 99.254272] df80: 00000000 00051f4d 00000063 04aae30b 00000063
> > 04a5c3be 00000001 00000000
> > [ =A0 99.262817] dfa0: c0654248 c0654258 c06d7a6c c0377404 c064c000
> > c0652254 c06a5d04 c065224c
> > [ =A0 99.271362] dfc0: 80004059 c0045f40 c064e9b4 c003341c c0ae1140
> > c0008868 c00082c8 0000060a
> > [ =A0 99.279907] dfe0: 80000100 c003341c 10c53c7d c064e060 c0033418
> > 8000803c 00000000 00000000
> > [ =A0 99.288482] [<c0325ce4>] (ehci_quiesce+0xc/0x94) from [<c0328bfc>]
> > (ehci_stop+0x34/0x8c)
> > [ =A0 99.296936] [<c0328bfc>] (ehci_stop+0x34/0x8c) from [<c007a3d4>]
> > (run_timer_softirq+0x15c/0x1f8)
> > [ =A0 99.306121] [<c007a3d4>] (run_timer_softirq+0x15c/0x1f8) from
> > [<c064dec0>] (0xc064dec0)
> > [ =A0 99.314483] Code: c05d7f9a e92d4073 e1a04000 e5903004 (e5933000)
> > [ =A0 99.320892] ---[ end trace 4ae88755f08e391f ]---
> > [ =A0 99.325714] Kernel panic - not syncing: Fatal exception in interru=
pt
> >
> >
> > Regards,
> > Joel
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "Beagle Board" group.
> > To post to this group, send email to beagleboard@googlegroups.com.
> > To unsubscribe from this group, send email to beagleboard+unsubscribe@g=
ooglegroups.com.
> > For more options, visit this group at http://groups.google.com/group/be=
agleboard?hl=3Den.
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOQbKcAAoJEAv8Txj19kN1gmEH/1/fi5q4Xk7aCu4l0z9MxVOL
g2CYLo8Rx8S4peRuv6UVqXhAlUHhzildk8eI11ZuPG223FSZdwn56I4oTqbvW7O+
WHSsJ0TeKzzCLbbPOrUAG+8SrrX3OFnd4JDkQCw2Y2+KTFYKKJ4DS8QlwbyE187p
osXrHKEOpQ1x7kCAJduImpFBIf6Ubs8SEIycNs2IRVLymH315A5fFOXB3jfBf+lE
itr6INqYyeZNqvl38kK6+4E/Net6FdkiK2OGEONpK7e/0D0oqkTP1siFwWabGoG+
yYptyy1iSsj3a0XoDuGPTXGb0G/oe4LHNYMCljaTPDJ4b/z4AnjklbufufiajxM=
=tN1I
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
