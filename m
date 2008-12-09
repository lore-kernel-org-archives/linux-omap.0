From: Artem Bityutskiy <dedekind@yandex.ru>
Subject: Re: MLC NAND support on OMAP35xx
Date: Tue, 09 Dec 2008 11:30:09 +0200
Message-ID: <493E3AA1.3070806@yandex.ru>
References: <dbdb2ea60812081456p63aafe1fucb20d6fa6d4bce71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58652 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbYLIJcn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Dec 2008 04:32:43 -0500
In-Reply-To: <dbdb2ea60812081456p63aafe1fucb20d6fa6d4bce71@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

twebb wrote:
> Can anyone comment on the existence or status of MLC NAND support in
> the linux-omap kernel or even the mainline kernel?  And would this
> support be built into YAFFS or into an mtd driver where other NAND
> (SLC) support resides?

It should be easy to write a driver for MLC flash. It is more difficult
to find file-system which would be able to work on top of it. YAFFS
requires free space in OOB, and MLC usually does not have it.

The closest linux FS which may work on MLC is UBIFS, but there are stil=
l
some aspects which needs work, see

http://www.linux-mtd.infradead.org/faq/ubifs.html#L_ubifs_mlc

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
