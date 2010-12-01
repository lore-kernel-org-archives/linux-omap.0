From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v5] OMAP2+: PM: omap device: API's for handling
 mstandby mode
Date: Wed, 1 Dec 2010 17:09:17 +0530
Message-ID: <20101201113917.GA16584@GLPP-machine>
References: <1290596051-12989-1-git-send-email-manjugk@ti.com>
 <AANLkTikvNNhNLYz9r5J5viajcRWW1zDrsfpTOK038k+C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:44584 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754677Ab0LALix (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Dec 2010 06:38:53 -0500
Received: by ywo32 with SMTP id 32so348707ywo.35
        for <linux-omap@vger.kernel.org>; Wed, 01 Dec 2010 03:38:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikvNNhNLYz9r5J5viajcRWW1zDrsfpTOK038k+C@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

* ABRAHAM, KISHON VIJAY <kishon@ti.com> [2010-12-01 14:22:46 +0530]:

> On Wed, Nov 24, 2010 at 4:24 PM, G, Manjunath Kondaiah <manjugk@ti.co=
m> wrote:
> > Certain errata in OMAP2+ processors will require forcing
> > master standby to "no standby" mode before completing on going
> > operation. Without this, the results will be unpredictable.
> >
[...]
> > +
> > + =A0 =A0 =A0 oh =3D *od->hwmods;
>=20
>      I Guess you are missing oh++ in the following loop.

Thanks for catching this. I will fix it.

-Manjunath
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
