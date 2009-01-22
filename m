From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: OMAP I2C: query on save and restore
Date: Thu, 22 Jan 2009 08:38:27 +0200
Message-ID: <87wscnsv4s.fsf@trdhcp146196.ntc.nokia.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CE7F6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:19218 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764AbZAVGhL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 01:37:11 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CE7F6@dbde02.ent.ti.com>
	(ext Pakaravoor's message of "Thu, 22 Jan 2009 12:02:15 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>

"ext Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com> writes:

> For i2c-omap.c, on the origin/pm branch, upon save and restore, OMAP_=
I2C_SYSC_REG is not saved and restored.
>
> Any specific reason, why it is so? Or is it a bug?

It is a bug. Originally when save/restore was written, there was no
ocp configuration in i2c-omap.c. Feel free to send a patch.

>
> TIA.
>
> --
> With Regards,
> Jagadeesh Bhaskar P
> =20
> ----------------------------
> Some men see things as they are and say why - I dream things that nev=
er were and say why not.
> - George Bernard Shaw
> ----------------------------

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
