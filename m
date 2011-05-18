From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap:pm: Fix boot-time errors with debugfs disabled
Date: Wed, 18 May 2011 14:46:54 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024CFDC853@dbde02.ent.ti.com>
References: <1305221790-4944-1-git-send-email-premi@ti.com>
 <BANLkTim+3M3Z0C3GTtTQrb2cqk5eSAsR+w@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024CE66D34@dbde02.ent.ti.com>
 <BANLkTinxvCNdr7qQTWjRZ2KceSvanGQ0Sg@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024CFDC82C@dbde02.ent.ti.com>
 <BANLkTik5ZQLzyNqS6CRuJrActm9O7r7LEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57220 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576Ab1ERJRC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 05:17:02 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4I9GwxM005158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 04:17:00 -0500
In-Reply-To: <BANLkTik5ZQLzyNqS6CRuJrActm9O7r7LEA@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Menon, Nishanth=20
> Sent: Wednesday, May 18, 2011 2:36 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] omap:pm: Fix boot-time errors with=20
> debugfs disabled
>=20
> On Wed, May 18, 2011 at 04:00, Premi, Sanjeev <premi@ti.com> wrote:
> >> While cleaning up voltdm_c set earlier this week, I think=20
> your changes
> >> apply better there.
> >> btw, I could incorporate a bit of your code into my patch,=20
> esp the one
> >> Tony commented on=20
> http://marc.info/?l=3Dlinux-omap&m=3D130570559515977&w=3D2
> ok this part got rejected pending regulator framework for scalable
> voltage domains..
>=20
> >> but, overall, on the topic of SR, either:
> >> a) =A0move SR autocomp into sysfs (and dump the rest of the=20
> debugfs - it
> >> is useful for validation, but does'nt really provide=20
> additional info)
> >> - given that it used to reside in=20
> /sys/power/sr_vddx_autocomp and then
> >> moved to debugfs, I am not sure if this is the right path
> >> b) move SR autocomp into a board defined configuration.. more
> >> intrusive, but folks would really want to enable SR as an option a=
t
> >> times from userspace - many distros and devices do this=20
> (e.g. N900)..
> >
> > [sp] I am not sure what you are suggesting. Can't we take=20
> in the patch and
> > =A0 =A0 then do the movements? ... the ones that doesn't seem=20
> to be implemented
> > =A0 =A0 so far (based on your comments).
> depends on what Kevin thinks is the future of voltdm(in terms of whic=
h
> .4x target) - might be good to focus our attention into a single
> branch and cleanit up for upstream.. I am personally not sure what
> should autocomp's future should be - I think option of having boards
> be able to define it - maybe as part of regulator framework + debugfs
> cleanup similar(as voltdm_c has removed I believe all of voltage
> debugfs - so your patch can be much smaller and effective there)..

[sp] Reworking the patch for different branch is fine.
     But what about the pm branch today.

>=20
> Regards,
> Nishanth Menon
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
