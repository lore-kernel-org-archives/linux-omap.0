From: Matthieu Poullet <matthieu.poullet@gmail.com>
Subject: Re: git repository that was used to build TI Dev Kit =?utf-8?b?MDFfMDBfMDA=?= android kernel sources
Date: Mon, 28 Feb 2011 09:10:42 +0000 (UTC)
Message-ID: <loom.20110228T100904-885@post.gmane.org>
References: <88190879-4EBA-48AE-AFFD-31152C5B9D94@mac.com> <loom.20110226T165438-178@post.gmane.org> <2D309E71-7539-4310-B08A-DE2CB9D7DD23@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:51046 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752995Ab1B1JKy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 04:10:54 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1Ptz81-0008DO-5d
	for linux-omap@vger.kernel.org; Mon, 28 Feb 2011 10:10:53 +0100
Received: from proxye.avm.de ([212.42.244.241])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 10:10:53 +0100
Received: from matthieu.poullet by proxye.avm.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 10:10:53 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Elvis Dowson <elvis.dowson <at> mac.com> writes:

>=20
> Hi Matthieu,
>                           Thanks for the reply.
>=20
> On Feb 26, 2011, at 8:00 PM, Matthieu Poullet wrote:
>=20
> >
http://software-dl.ti.com/dsps/dsps_public_sw/sdo_tii/TI_Android_DevKit=
/01_00_00/index_FDS.html
> >>=20
> >>=20
> >
http://software-dl.ti.com/dsps/dsps_public_sw/sdo_tii/TI_Android_DevKit=
/01_00_00/exports/Sources.tar.gz
> >=20
> > Hi,
> >=20
> > these DevKits are based on the Rowboat project:
> > http://code.google.com/p/rowboat/
> >=20
> > Sources are available here:
> > http://gitorious.org/rowboat
>=20
> The rowboat-eclair-2.6.32 branch doesn't have a commit tag correspond=
ing to
the DevKit 01_00_00 release
>=20
> http://gitorious.org/rowboat/kernel/commits/rowboat-eclair-2.6.32
>=20
> However, looking at the platform manifest, I was able to get the comm=
it id for
this release: 6bee57941d45c55ceecc5364590cb1c4ebeda053
>=20
> http://gitorious.org/rowboat/manifest/blobs/master/TI-Android-Eclair-=
DevKit-V1.xml
>=20
> #01:  I found a bunch of differences between the source snapshot and =
the
rowboat-eclair-2.6.32 branch head
> 2 months ago, and wasn't sure which git repository the dev kit source
snapshots were being generated from.
>=20
> If you look at the release notes
>=20
> http://processors.wiki.ti.com/index.php/TI-Android-=C3=89clair-DevKit=
-V1_ReleaseNotes
>=20
> the commit id mentioned in the release notes is :
b263debb4bd3565f4550bd27cf4bb78ae44ef8c3
>=20
> and that in the platform manifest is : 6bee57941d45c55ceecc5364590cb1=
c4ebeda053
>=20
> #02: Another mis-match is that the release notes mention that the ker=
nel
branch used is
> android-eclair-2.6.32 and that used in the actual platform manifest f=
or DevKit
v1 is android-eclair
> (which is probably 2.6.29, I guess).
>=20
> http://gitorious.org/rowboat/manifest/blobs/master/TI-Android-Eclair-=
DevKit-V1.xml
>=20
> Best regards,
>=20
> Elvis Dowson
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

Hi Elvis,

I work on a custom-board with a custom kernel, so I haven't worked with=
 the
standard Eclair stuff since October.
The best place to ask is, I think, the Rowboat mailing list, not this l=
ist:
http://groups.google.com/group/rowboat

and/or to ping people on IRC (#rowboat on freenode), e.g. Khasim Syed M=
ohammed.

=46YI here are the Release threads:

TI Android Eclair DevKit V1.0 Release thread:
http://groups.google.com/group/rowboat/browse_thread/thread/6c61b3d06ae=
e3860/73322b710d25ee0c
TI Android Eclair DevKit V2.0 Release thread:
http://groups.google.com/group/rowboat/browse_thread/thread/d0eeaa2f423=
c661a/5b5ac2039637f99c
TI Android Eclair DevKit V2.2 Release thread:
http://groups.google.com/group/rowboat/browse_thread/thread/38e5370b8a0=
7cfe6/46258591b47ea46d

Regards,
Matthieu,


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
