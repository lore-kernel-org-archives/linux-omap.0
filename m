From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 22/33] add omap nand drivers
Date: Sun, 31 Aug 2008 14:08:18 -0700
Message-ID: <200808311408.18492.david-b@pacbell.net>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <1220116593-862-22-git-send-email-me@felipebalbi.com> <1220116593-862-23-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:27533 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758112AbYHaVTN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 31 Aug 2008 17:19:13 -0400
In-Reply-To: <1220116593-862-23-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

Hmm, this seems like three distinct drivers to me.
Which should mean three separate patches ... going
go the MTD list!


On Saturday 30 August 2008, Felipe Balbi wrote:
>=20
> +config MTD_NAND_OMAP2
> +=A0=A0=A0=A0=A0=A0=A0tristate "NAND Flash device on OMAP2 and OMAP3"
> +=A0=A0=A0=A0=A0=A0=A0depends on ARM && MTD_NAND && (ARCH_OMAP2 || AR=
CH_OMAP3)
> +=A0=A0=A0=A0=A0=A0=A0help
> + =A0 =A0 =A0 =A0 =A0Support for NAND flash on Texas Instruments OMAP=
2 and OMAP3 platforms.

I've got a small patch for this one which I'll post.


> +config MTD_NAND_OMAP
> +=A0=A0=A0=A0=A0=A0=A0tristate "NAND Flash device on OMAP H3/H2/P2 bo=
ards"
> +=A0=A0=A0=A0=A0=A0=A0depends on ARM && ARCH_OMAP1 && MTD_NAND && (MA=
CH_OMAP_H2 || MACH_OMAP_H3 || MACH_OMAP_PERSEUS2)
> +=A0=A0=A0=A0=A0=A0=A0help
> +=A0=A0=A0=A0=A0=A0=A0 =A0Support for NAND flash on Texas Instruments=
 H3/H2/P2 platforms.
> +
> +config MTD_NAND_OMAP_HW
> +=A0=A0=A0=A0=A0=A0=A0bool "OMAP HW NAND Flash controller support"
> + =A0 =A0 =A0 =A0depends on ARM && ARCH_OMAP16XX && MTD_NAND
> +
> +=A0=A0=A0=A0=A0=A0=A0help
> +=A0=A0=A0=A0=A0=A0=A0 =A0Driver for TI OMAP16xx hardware NAND flash =
controller.

This one raises the question:  why are there *TWO* drivers for
the same hardware?  Which one is the failed experiment?

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
