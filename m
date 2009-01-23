From: Kalle Valo <kalle.valo@nokia.com>
Subject: Re: [PATCH 2/3] tsub6010: fix omap compile
Date: Fri, 23 Jan 2009 16:04:37 +0200
Message-ID: <87y6x215l6.fsf@nokia.com>
References: <20090122131602.18315.84862.stgit@tikku>
	<20090122131913.18315.73478.stgit@tikku>
	<20090123021051.GM7172@atomide.com>
	<20090123121423.GT9233@scadufax.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57338 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbZAWOFg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 09:05:36 -0500
In-Reply-To: <20090123121423.GT9233@scadufax.research.nokia.com> (Felipe Balbi's message of "Fri\, 23 Jan 2009 14\:14\:23 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

=46elipe Balbi <felipe.balbi@nokia.com> writes:

> On Thu, Jan 22, 2009 at 06:10:52PM -0800, Tony Lindgren wrote:
>> * Kalle Valo <kalle.valo@nokia.com> [090122 05:21]:
>> > drivers/usb/musb/tusb6010_omap.c:18:26: error: asm/arch/dma.h: No =
such file or directory
>> > drivers/usb/musb/tusb6010_omap.c:19:26: error: asm/arch/mux.h: No =
such file or directory
>>=20
>> Not touching this, Felipe needs to queue this up via linux-usb list.
>
> sure, kalle, could you resend to linux-usb@vger.kernel.org ??

Ok, I will.

> also, sure to Cc me

T=E1 bom :)

--=20
Kalle Valo
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
