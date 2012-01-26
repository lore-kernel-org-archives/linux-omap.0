From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 10/21] OMAP3+: Smartreflex: clear ERRCONFIG_VPBOUNDINTST
 only on a need
Date: Thu, 26 Jan 2012 15:29:21 +0400
Message-ID: <4F213911.1080806@ru.mvista.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com> <1327504583-13408-11-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:47755 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751609Ab2AZLaa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jan 2012 06:30:30 -0500
In-Reply-To: <1327504583-13408-11-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

Hello.

On 25-01-2012 19:16, Jean Pihet wrote:

> From: Nishanth Menon<nm@ti.com>

> ERRCONFIG register's VPBOUNDINTST has an additional functional meanin=
g
> It force clears Sr_interruptz internal signal. This can result in
> scenarios where VP->  SR protocol is violated where voltage processor=
's
> As interruptz is already high, VP will never clear the signal vpirqcl=
r.
> Therefore during the next force update to reset to nominal voltage,
> VP can=E2=80=99t pulsed vpirqclr =3D>  PRCM HW can=E2=80=99t generate=
 the tranxdone IRQ
> and the situation is not recoverable untill a cold reset is invoked.

> To prevent this situation, check if status is set before clearing the
> status as this needs to be done only on a need basis.

> Change-Id: Ic8065d7d79df143bf46877c50f5b6b19ed105a70

    Please remove this line.

> Reported-by: Vincent Bour<v-bour@ti.com>
> Signed-off-by: Nishanth Menon<nm@ti.com>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
