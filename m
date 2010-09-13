From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [RESEND/PATCH 5/6] USB: musb-gadget: complete request only if
 data is transfered over
Date: Mon, 13 Sep 2010 22:34:08 +0800
Message-ID: <AANLkTinei3u1OZ-eBiUTDF=PDjwxLcL6rBpt7iNQJgHJ@mail.gmail.com>
References: <1283873014-32511-1-git-send-email-tom.leiming@gmail.com>
	<1283873014-32511-6-git-send-email-tom.leiming@gmail.com>
	<4C8E18AD.8000502@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41715 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab0IMOeK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Sep 2010 10:34:10 -0400
In-Reply-To: <4C8E18AD.8000502@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: greg@kroah.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <balbi@ti.com>, Anand Gadiyar <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>

2010/9/13 Sergei Shtylyov <sshtylyov@mvista.com>:
> =A0 But why not modify the conditional above all that code, just excl=
uding
> 'is_dma' from it. This conditional already includes (request->actual =
=3D=3D
> request->length) check. Please recast this patch.

The two condition is OR relation, not and, so we can't exclude 'is_dma'=
 simply.
Anyway, the change is not wrong, right?


thanks,
--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
