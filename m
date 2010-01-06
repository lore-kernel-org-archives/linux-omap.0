From: Francisco Alecrim <alecrim@gmail.com>
Subject: Re: problem with n810 boot up
Date: Wed, 06 Jan 2010 19:02:23 -0400
Message-ID: <4B45167F.8020605@gmail.com>
References: <200912290152.16357.luke@dashjr.org> <201001051747.02221.luke@dashjr.org> <4B43F983.5050200@gmail.com> <201001052107.55283.luke@dashjr.org> <4B450A7E.6040103@gmail.com> <20100106224520.GA29239@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:52095 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932866Ab0AFXCa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 18:02:30 -0500
Received: by ywh6 with SMTP id 6so17926139ywh.4
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 15:02:29 -0800 (PST)
In-Reply-To: <20100106224520.GA29239@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Luke-Jr <luke@dashjr.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Kalle Valo <kalle.valo@iki.fi>

Hi/Ol=E1 Balbi, :)

=46elipe Balbi wrote:
> Hi,
>=20
> On Wed, Jan 06, 2010 at 06:11:10PM -0400, Francisco Alecrim wrote:
>> Thanks! Now it goes to rootfs and continue the boot, but device
>> power-off after 10-20 seconds. There is no error message to help. :(
>=20
> watchdog ?
>=20
> how about disabling watchdog with flasher ??
>=20

I'm using the flags (no-omap-wd,no-retu-wd,no-lifeguard-reset)
recommended by Kalle[1]. This's not the problem. :(

Thanks anyway,
Alecrim

[1] - http://gitorious.org/stlc45xx/mainline/blobs/HEAD/README

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
