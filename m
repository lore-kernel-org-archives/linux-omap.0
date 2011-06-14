From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: [PATCH] OMAP4: McBSP: Clear rx_irq at probe time
Date: Tue, 14 Jun 2011 14:19:34 +0300
Message-ID: <27857936.rzNg0PjYWH@barack>
References: <1305628420-10592-1-git-send-email-peter.ujfalusi@ti.com> <201106081051.27234.peter.ujfalusi@ti.com> <20110613133542.GD3352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46727 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362Ab1FNLTe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jun 2011 07:19:34 -0400
In-Reply-To: <20110613133542.GD3352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

Hi Tony,

On Monday 13 June 2011 15:35:43 Tony Lindgren wrote:
> Sure we can merge fixes

Can you take this patch forward?

> but let's get the move done before adding
> new features.

What is considered a new feature here?
Is it a new feature, if I fix the McBSP for OMAP4 (FIFO usage, and smal=
l=20
updates)?
We have discussion ongoing about the mcbsp code move, and so far the cu=
rrent=20
understanding/plan is (Jarkko/Liam correct me if I'm wrong):
- Fix the OMAP4 support
- move the code under sound/soc/omap/
 - the reason for this is that McBSP block can be only used for streami=
ng type=20
of modes (from omap2430 onwards McBSP does not have clock stop function=
ality).
This makes other type of usage hard to say the least.
- Clean up the code (remove the SPI mode, remove unused code paths at t=
he same=20
time)
- Consolidate the interface for audio only use
- Only OMAP3 has sidetone (on OMAP2 EAC block has the sidetone), might =
need=20
some change, but I think the current way can be reused.

In this way we are not going to hide the OMAP4 fixes with the code=20
move/consolidation effort, so one can track what has been done, and why=
=2E

Opinions?

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
