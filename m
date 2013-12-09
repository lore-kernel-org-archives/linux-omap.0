From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 01/15] mfd: menelaus: Drop __exit section annotation
Date: Mon, 9 Dec 2013 09:37:48 +0000
Message-ID: <20131209093748.GA12675@lee--X1>
References: <1386042188-12246-1-git-send-email-balbi@ti.com>
 <20131203095136.GF11828@lee--X1>
 <20131208190739.GA18977@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:64376 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab3LIJhy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Dec 2013 04:37:54 -0500
Received: by mail-oa0-f49.google.com with SMTP id i4so3537452oah.22
        for <linux-omap@vger.kernel.org>; Mon, 09 Dec 2013 01:37:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131208190739.GA18977@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, sameo@linux.intel.com, Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

> > The code looks mostly fine, but the implementation of the commit lo=
gs
> > seems lazy. Please submit a v3 using coherent sentences with full
> > explanations and correct punctuation.
>=20
> example ?

All of your commit messages.

> that macro just helps removing some extra

  ^- Sentences start with an uppercase character.

> line of code and hides ffs() calls.
>=20
> while at that, also fix a variable shadowing

  ^- Sentences start with an uppercase character.

> bug where 'int irq' was being redeclared inside
> inner loop while it was also argument to interrupt
> handler.

  < ---------------   50 chars   ----------------- >

Please use the full 72 char (or there abouts) width of the buffer.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
