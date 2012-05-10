From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: AM35xx: fix UART4 softreset
Date: Thu, 10 May 2012 12:37:29 -0700
Message-ID: <20120510193729.GE20494@animalcreek.com>
References: <20120510172449.13418.66815.stgit@dusk>
 <20120510172918.13418.64781.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:36717 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760771Ab2EJTha (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 15:37:30 -0400
Content-Disposition: inline
In-Reply-To: <20120510172918.13418.64781.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kyle Manna <kyle.manna@fuel7.com>, Ranjith Lohithakshan <ranjithl@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>

On Thu, May 10, 2012 at 11:29:19AM -0600, Paul Walmsley wrote:
> During kernel init, the AM3505/AM3517 UART4 cannot complete its softr=
eset:
>=20
> omap_hwmod: uart4: softreset failed (waited 10000 usec)
>=20
> This also results in another warning later in the boot process:
>=20
> omap_hwmod: uart4: enabled state can only be entered from initialized=
, idle, or disabled state
>=20
> >From empirical observation, the AM35xx UART4 IP block requires eithe=
r
> uart1_fck or uart2_fck to be enabled while UART4 resets.  Otherwise
> the reset will never complete.  So this patch adds uart1_fck as an
> optional clock for UART4 and adds the appropriate hwmod flag to cause
> uart1_fck to be enabled during the reset process.  (The choice of
> uart1_fck over uart2_fck was arbitrary.)
>=20
> Unfortunately this observation raises many questions.  Is it necessar=
y
> for uart1_fck or uart2_fck to be controlled with uart4_fck for the
> UART4 to work correctly?  What exactly do the AM35xx UART4 clock
> tree and the related PRCM idle management FSMs look like?  If anyone
> has the ability to answer these questions through empirical functiona=
l
> testing, or hardware information from the AM35xx designers, it would
> be greatly appreciated.
>=20
> Cc: Beno=EEt Cousson <b-cousson@ti.com>
> Cc: Kyle Manna <kyle.manna@fuel7.com>
> Cc: Mark A. Greer <mgreer@animalcreek.com>
> Cc: Ranjith Lohithakshan <ranjithl@ti.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Acked-by: Mark A. Greer <mgreer@animalcreek.com>
(on an am3517evm)

Mark
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
