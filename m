From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: The state of AM33xx power management.
Date: Fri, 29 Nov 2013 16:50:25 -0300
Message-ID: <20131129195024.GB7884@localhost>
References: <52973F65.8060005@cobham.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:44181 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752419Ab3K2TuZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Nov 2013 14:50:25 -0500
Content-Disposition: inline
In-Reply-To: <52973F65.8060005@cobham.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Murphy <brian.murphy@cobham.com>
Cc: linux-omap@vger.kernel.org, vaibhav.bedia@ti.com

(Ccing Vaibhav, who worked on this, iirc)

On Thu, Nov 28, 2013 at 02:04:37PM +0100, Brian Murphy wrote:
> Hi Folks,
>=20
> even though I have seen some references to power management on AM33xx
> class devices recently on this list it seems to me that just about th=
e=20
> only omap
> device without suspend/resume support in Torvalds kernel source is AM=
33xx.
> Correct me if I am wrong.
>=20
> I have looked at integrating this code:
>=20
> https://github.com/dgerlach/linux-pm.git
>=20
> and have had it running (after a fashion) on a slightly older kernel =
but=20
> the patches
> fail to apply to the newest kernels.
>=20
> Is there a secret (or not so secret, but unknown to me) place which=20
> contains the equivalent
> of the patches above but rebased and cleaned up relative to a newer k=
ernel?
>=20
> I am willing to to whatever work is necessary to get this done and up=
stream
> but I don't want to work in a different direction to others working o=
n=20
> the same problem.
>=20
> How best should I proceed?
>=20
> regards
> Brian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
