From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/2] OMAP2+: IOMMU: change OMAP2+ error message to
 dev_dbg()
Date: Tue, 15 Feb 2011 15:59:48 +0200
Message-ID: <20110215155948.32b564d5.jhnikula@gmail.com>
References: <1297776033-8579-1-git-send-email-dacohen@gmail.com>
	<1297776033-8579-2-git-send-email-dacohen@gmail.com>
	<4D5A81D8.2080800@ru.mvista.com>
	<AANLkTinQX59iyX1La=99Urgh5_JF0iZacBDqQz1VQfhi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58370 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab1BON72 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 08:59:28 -0500
Received: by eye27 with SMTP id 27so69898eye.19
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 05:59:27 -0800 (PST)
In-Reply-To: <AANLkTinQX59iyX1La=99Urgh5_JF0iZacBDqQz1VQfhi@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, tony@atomide.com, linux-omap@vger.kernel.org, Hiroshi.DOYU@nokia.com, linux-arm-kernel@lists.infradead.org

On Tue, 15 Feb 2011 15:44:27 +0200
David Cohen <dacohen@gmail.com> wrote:

> >> @@ -163,13 +163,13 @@ static u32 omap2_iommu_fault_isr(struct iomm=
u *obj,
> >> u32 *ra)
> >> =A0 =A0 =A0 =A0da =3D iommu_read_reg(obj, MMU_FAULT_AD);
> >> =A0 =A0 =A0 =A0*ra =3D da;
> >>
> >> - =A0 =A0 =A0 dev_err(obj->dev, "%s:\tda:%08x ", __func__, da);
> >> + =A0 =A0 =A0 dev_dbg(obj->dev, "%s:\tda:%08x ", __func__, da);
> >
> > =A0 Note that dev_dbg() will only print something if either DEBUG o=
r
> > CONFIG_DYNAMIC_DEBUG are defined...
>=20
> That's my plan.
>=20
So it's sure that a developer won't need these error dumps when
receiving an error report? I.e. IOMMU upper level errors give enough
information to start doing own debugging?

Just my 2 cents.

--=20
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
