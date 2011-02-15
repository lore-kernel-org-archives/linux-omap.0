From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH 1/2] OMAP2+: IOMMU: change OMAP2+ error message to dev_dbg()
Date: Tue, 15 Feb 2011 16:50:29 +0200
Message-ID: <AANLkTin=4z0o6=J9f-1mszvGrpaRMgCMk=Ckh5+9j6EQ@mail.gmail.com>
References: <1297776033-8579-1-git-send-email-dacohen@gmail.com>
	<1297776033-8579-2-git-send-email-dacohen@gmail.com>
	<4D5A81D8.2080800@ru.mvista.com>
	<20110215142923.GC11199@n2100.arm.linux.org.uk>
	<AANLkTin++DGAGT9-nahy1Qm7ASbGm=JjNuPZWZ6XUbcX@mail.gmail.com>
	<20110215144457.GD11199@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:42130 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab1BOOua convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 09:50:30 -0500
Received: by wwi17 with SMTP id 17so3156256wwi.1
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 06:50:29 -0800 (PST)
In-Reply-To: <20110215144457.GD11199@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, tony@atomide.com, linux-omap@vger.kernel.org, Hiroshi.DOYU@nokia.com, linux-arm-kernel@lists.infradead.org

On Tue, Feb 15, 2011 at 4:44 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 15, 2011 at 04:36:26PM +0200, David Cohen wrote:
>> But pr_cont() would be wrong in case of DEBUG isn't set, isn't it?
>
> Yes. =C2=A0One other solution you could do is:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char buf[80], *p =3D buf;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0buf[0] =3D '\0';
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < ARRAY_SIZE(err_msg); i++=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (stat & (1 =
<< i))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0p +=3D scnprintf(p, sizeof(buf) - (p - buf),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"=
 %s", err_msg[i]);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(obj->dev, "%s: da:%08x%s\n", __fun=
c__, da, buf);
>
> which means that you're then printing the entire string in one go -
> and there's no chance for another message to come in the middle of it=
=2E
>
> Note that I've placed the ' ' at the beginning of the format string s=
o
> that we don't end up with useless trailing space in messages. =C2=A0M=
inor
> point but it's easy to do here.

That could be my choice.
I'm not planing to resend this patch, but how good/bad it sounds to
you to have dev_dbg_cont() for such situation?

Br,

David
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
