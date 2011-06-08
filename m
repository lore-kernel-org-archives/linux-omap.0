From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] OMAP4: McBSP: Clear rx_irq at probe time
Date: Wed, 8 Jun 2011 10:51:26 +0300
Message-ID: <201106081051.27234.peter.ujfalusi@ti.com>
References: <1305628420-10592-1-git-send-email-peter.ujfalusi@ti.com> <201105181539.46959.peter.ujfalusi@ti.com> <20110531075701.GN11352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33068 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754833Ab1FHHvH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jun 2011 03:51:07 -0400
In-Reply-To: <20110531075701.GN11352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

Hi Tony,

On Tuesday 31 May 2011 10:57:02 Tony Lindgren wrote:
> Sure, but that's the only option we have to merge any new code.

So this patch will be not taken (even if without this patch OMAP4 McBSP=
 is=20
broken), unless we move the McBSP code out from plat-omap?

I have discussed with Jarkko, and internally about the mcbsp code move.=
 This=20
will certainly take some time to figure out a sane way to do this.
To be hones I would be surprised if we can do this for 3.1...

Regards,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
