From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 2/5] omap board changes for v3.6 merge window
Date: Tue, 10 Jul 2012 23:51:49 -0700
Message-ID: <20120711065149.GB1122@atomide.com>
References: <0M4ZFU-1RqIwX3VUq-00yonj@mx.kundenserver.de>
 <201207101534.13166.arnd@arndb.de>
 <4FFCCE43.2070709@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:48770 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756082Ab2GKGvx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jul 2012 02:51:53 -0400
Content-Disposition: inline
In-Reply-To: <4FFCCE43.2070709@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zumeng Chen <zumeng.chen@windriver.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

* Zumeng Chen <zumeng.chen@windriver.com> [120710 17:57]:
> =E4=BA=8E 2012=E5=B9=B407=E6=9C=8810=E6=97=A5 23:34, Arnd Bergmann =E5=
=86=99=E9=81=93:
> >I got a conflict in arch/arm/mach-omap2/common-board-devices.c betwe=
en
> >16aced80f6739 "ARM: OMAP3530evm: set pendown_state and debounce time=
 for
> >ads7846" and 97ee9f01d6f26 "ARM: OMAP: fix the ads7846 init code",
> >see my resolution below.
> >
> >Please check if what I have in the for-next branch makese sense to y=
ou
> >all.
>
> No problem,  many thanks Arnd for your information.
> I'll check it, test it, and send you feedback.

Thanks, looks good. Also I've checked that for-next builds fine with
my testconfigs.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
