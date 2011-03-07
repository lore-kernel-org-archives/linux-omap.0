From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v2 1/1] omap3: nand: report corrected ecc errors
Date: Mon, 07 Mar 2011 10:48:35 +0200
Message-ID: <1299487715.2746.1.camel@localhost>
References: <87oc64qr5b.fsf@vostro.fn.ogness.net>
	 <1298631549.2798.56.camel@localhost>
	 <87y650pdc1.fsf_-_@vostro.fn.ogness.net>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53483 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab1CGIuC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 03:50:02 -0500
In-Reply-To: <87y650pdc1.fsf_-_@vostro.fn.ogness.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-omap@vger.kernel.org, s-ghorai@ti.com, David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org

On Mon, 2011-02-28 at 13:12 +0100, John Ogness wrote:
> From: John Ogness <john.ogness@linutronix.de>
>=20
> The number of corrected ECC errors should be reported since other MTD
> systems make use of this information (such as UBI data scrubbing).
>=20
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
> Patch v2:
> o Patch against linux-next-20110225.
> o Added comments explaining return codes.

Pushed to l2-mtd-2.6.git, thanks.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
