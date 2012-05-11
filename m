From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 14/14] OMAPDSS: HDMI: Implement DSS driver interface
 for audio
Date: Fri, 11 May 2012 15:51:33 +0300
Message-ID: <1336740693.8751.78.camel@deskari>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
	    <1336095848-6923-15-git-send-email-ricardo.neri@ti.com>
	   <1336390986.2667.8.camel@deskari> <4FA9B289.5000101@ti.com>
	  <1336552081.3962.15.camel@deskari> <4FAB403E.6010000@ti.com>
	 <1336636449.5182.26.camel@deskari> <4FAC71E0.2060808@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-BBTw8gDnC50RQbyvup7o"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:51766 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757321Ab2EKMvk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 May 2012 08:51:40 -0400
Received: by lahc1 with SMTP id c1so2028828lah.32
        for <linux-omap@vger.kernel.org>; Fri, 11 May 2012 05:51:37 -0700 (PDT)
In-Reply-To: <4FAC71E0.2060808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: mythripk@ti.com, s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--=-BBTw8gDnC50RQbyvup7o
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-05-10 at 20:56 -0500, Ricardo Neri wrote:

> Sorry, some hunks where missing in the patch that I submitted yesterday.
>=20
> I just pushed a branch containing the whole most up-to-date series here:
>=20
> git://gitorious.org/omap-audio/linux-audio.git=20
> ricardon/topic/dss_audio-for-tomi
>=20
> This includes the implementation of the DSS audio interface for HDMI=20
> covering the improved locking strategy [1][2], plus the missing hunks in=
=20
> my yesterday's patch, plus handling of mode changes you pointed out.
>=20
> Please let me know if you want me to resubmit the whole patch series so=
=20
> that you can comment if you need to.

Thanks, I think this is fine. I had to rebase your branch as you had
some extra patches there also. There were also a few conflicts with
latest dss stuff, but nothing serious.

I pushed the branch with latest dss and your branch to:

git://gitorious.org/linux-omap-dss2/linux.git test

With a quick test video works ok, but I didn't test audio.

 Tomi


--=-BBTw8gDnC50RQbyvup7o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPrQtVAAoJEPo9qoy8lh71SzIP/RyDaK9UYsOOpKHa/9f5g6V1
7mFkMHbX8hAiSF1E3sr7u8R0jshXOQzV/fL8RJ2UpgW73wDQQiGUt8yrTXdYlCca
LrbMWbSSnX3Yo4fLMIF/zCeyAa+UkR5AQKRYaU3xW/faYxR8NkDezBQ5bKX7s8lj
QRhR5EEg9MwGNL6D2SvtRDTSyd9aOyQFZE5WLopB3+2qDOCzu7cmrFSYZHIMltYD
hEt/5H85TH2epD7HRtt3aVOt446O4zRxjR00/zZkflAvvoGVeJmSIinx00IKjONa
iFfP671yFI5JIZig0gP/+kYKlP8AdG1Lg7U0SnEkG/b2TRMWRTnqzq7KF8UIzW1m
RqPUfq7fjf3wKNLgcRcG/6h+NtPatbnmjDYJ7AtUhza7nllCG9pT11H8xGJ7JuWC
LK2x8POQR6KTvBhSWd3hGRnPXy5qynyQh3leLNQMWWsDl90Q0v0N5R5bGp2wz2JX
7t/qOKx6hM2wSwLFBTnbh7c/dHY36nL1PiqL8W3CdK7Yao5uFOqItzstL/+VheHw
1+pE5WZCiNNCigfHTuLJJMbT/ED0sWgxoBSF7bQDZ0ZinAqwkwvq3IRQLLGfydBY
0q7KuklZwcE06OsMKNi/i1gFCYSGb5vkod01+td83DYEZDuQZcEQ8nhey0Ii4lx4
xE0yc5NuYubFvbVj3q1b
=4kfZ
-----END PGP SIGNATURE-----

--=-BBTw8gDnC50RQbyvup7o--

