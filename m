From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: [PATCH] board-n8x0: add USB initialization
Date: Mon, 01 Mar 2010 10:37:06 +0200
Message-ID: <873a0kfnf1.fsf@purkki.valot.fi>
References: <1267321831-2775-1-git-send-email-alecrim@gmail.com>
	<877hpxfat6.fsf@purkki.valot.fi>
	<309201e1002281933k1fb52d29sa47b2f4eca35861d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51063 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab0CAIhL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Mar 2010 03:37:11 -0500
Received: by wya21 with SMTP id 21so1171283wya.19
        for <linux-omap@vger.kernel.org>; Mon, 01 Mar 2010 00:37:10 -0800 (PST)
In-Reply-To: <309201e1002281933k1fb52d29sa47b2f4eca35861d@mail.gmail.com> (Francisco Alecrim's message of "Sun\, 28 Feb 2010 23\:33\:45 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Francisco Alecrim <alecrim@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

=46rancisco Alecrim <alecrim@gmail.com> writes:

> Hi Kalle,

Hi again Francisco,

> On Sun, Feb 28, 2010 at 2:57 PM, Kalle Valo <kalle.valo@iki.fi> wrote=
:
>     Please do not add my Signed-off-by unless I have explicitly added=
 it.
>     And I don't recall giving it to this patch, so it can be removed.
>
>
> I got the initial code from http://www.valot.fi/kalle/n8x0/patches/n8=
x0-add/
> 2009-07-31-12:15/07-n8x0-add-usb-support.patch .=A0 I just re-organiz=
ed some
> variables. So I didn't remove your Signed-off-by.

Hehe, I had totally forgotten that patch! Sorry :)

> And I merged your patch to Tony's code http://www.mail-archive.com/
> linux-omap@vger.kernel.org/msg21443.html . So I kept his Signed-off-b=
y.

[...]

> Sorry! I was not sure about keep or not these Signed-off-by. Do you
> want me to re-send it without your Signed-off-by? =A0

No, this was my mistake. Please don't remove the Signed-off-by line.

But when you improve a patch originally implemented by somene else
it's a good practise to mention the history of the patch. For example,
"Based on Kalle's and Tony's patches", or something like that, is
enough IMHO.

--=20
Kalle Valo
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
