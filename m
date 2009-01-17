From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/3v4] Add support for OMAP35x processors
Date: Sat, 17 Jan 2009 13:22:13 -0800
Message-ID: <200901171322.13845.david-b@pacbell.net>
References: <1232120757-7535-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:24952 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759993AbZAQVWR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 17 Jan 2009 16:22:17 -0500
In-Reply-To: <1232120757-7535-1-git-send-email-premi@ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

On Friday 16 January 2009, Sanjeev Premi wrote:
> +=A0=A0=A0=A0=A0=A0=A0select ARCH_OMAP34XX
> +=A0=A0=A0=A0=A0=A0=A0select ARCH_OMAP3430

Surely OMAP35XX shouldn't imply OMAP3430??


Other than that ... this set of patches looks much better.  :)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
