From: "R, Sricharan" <r.sricharan@ti.com>
Subject: Re: [PATCH 01/13] ARM: OMAP5: id: Add cpu id for ES versions
Date: Thu, 10 May 2012 16:52:00 +0530
Message-ID: <CAJ7qFSf-r2aXJsh+gP4X9+4kYqnwGu9-jMXOkJNTaEgF6Ug=OA@mail.gmail.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
	<1336029982-31898-2-git-send-email-r.sricharan@ti.com>
	<4FABA406.1080608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:37977 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757556Ab2EJL3A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 07:29:00 -0400
Received: by lahg1 with SMTP id g1so776432lah.16
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 04:28:57 -0700 (PDT)
In-Reply-To: <4FABA406.1080608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, b-cousson@ti.com

Hi Roger,

>> +void __init omap5xxx_check_revision(void)
>> +{
>> + =A0 =A0 u32 idcode;
>> + =A0 =A0 u16 hawkeye;
>> + =A0 =A0 u8 rev;
>> +
>> + =A0 =A0 idcode =3D read_tap_reg(OMAP_TAP_IDCODE);
>> + =A0 =A0 hawkeye =3D (idcode >> 12) & 0xffff;
>> + =A0 =A0 rev =3D (idcode >> 28) & 0xff;
>> + =A0 =A0 switch (hawkeye) {
>> + =A0 =A0 case 0xb942:
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (rev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case 0:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_revision =3D OMAP5430=
_REV_ES1_0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case 1:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_revision =3D OMAP5430=
_REV_ES2_0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_revision =3D OMAP5430=
_REV_ES1_0;
>
> Default should always be the latest version supported. i.e. in this c=
ase
> it should be OMAP5430_REV_ES2_0
>
 ok thanks, will correct it.

Thanks,
 Sricharan
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
