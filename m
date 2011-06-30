From: Gregoire Gentil <gregoire@alwaysinnovating.com>
Subject: Re: Beagleboard -XM and 32GB microSD card oddities
Date: Thu, 30 Jun 2011 07:43:58 -0700
Message-ID: <1309445038.308.10.camel@gregoire-laptop>
References: <4E0C4703.9000207@blueyonder.co.uk>
Reply-To: gregoire@alwaysinnovating.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55611 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab1F3OoD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jun 2011 10:44:03 -0400
Received: by iyb12 with SMTP id 12so1967657iyb.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Jun 2011 07:44:03 -0700 (PDT)
In-Reply-To: <4E0C4703.9000207@blueyonder.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sboyce@blueyonder.co.uk
Cc: Beagle Board <beagleboard@googlegroups.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Is your card labeled SDHC or SDXC? Can you give the specs of your card?
Have you tried on Pandaboard?=20

Gr=C3=A9goire

On Thu, 2011-06-30 at 10:50 +0100, Sid Boyce wrote:
> I'm not really looking for a solution, just supplying some informatio=
n=20
> in case anyone is contemplating a >16GB card.
>=20
> Using Ubuntu 11.04 ARM or x86_64, I cannot create an ext4 partition t=
hat=20
> will mount. Doing fsck.ext4 appears to fix the filesystem, but rerunn=
ing=20
> fsck.ext4 a second time gives the same errors.
>=20
> Only BTRFS works.
>=20
> A BTRFS partition can be created without a problem. I then use rsync =
to=20
> copy across all the data from the 16GB (ext4) partition and it mounts=
=20
> without errors. After the rsync I create the excluded directories pro=
c,=20
> sys, tmp, media.
>=20
> I get a kernel oops (2.6.39-x1) on boot up of the 32GB card.
> I'm still trying to figure why I'm getting the oops that I don't have=
 on=20
> the original 16GB card.
> Regards
> Sid.


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
