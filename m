From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Wed, 11 Apr 2012 20:23:04 +0300
Message-ID: <CANOLnONfRGgSvS7ZLpee6m17=FEjX47-m8RvPt7RzGZ=f1FT2w@mail.gmail.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<4F859C5D.3090400@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64907 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760771Ab2DKRXF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 13:23:05 -0400
Received: by iagz16 with SMTP id z16so1527717iag.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 10:23:04 -0700 (PDT)
In-Reply-To: <4F859C5D.3090400@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

On Wed, Apr 11, 2012 at 5:59 PM, Gary Thomas <gary@mlbassoc.com> wrote:
> I'd like to try building without CONFIG_PM, but when I disabled this,=
 my
> kernel fails to come up. =C2=A0Can someone point me to the magic to b=
uild without
> CONFIG_PM, or possibly send me a working config file?

You probably need this patch:
http://marc.info/?l=3Dlinux-omap&m=3D133374930011086&w=3D2
If it still won't boot, you'll need to enable earlyprintk both in
=2Econfig and as kernel argument to see where it dies.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
