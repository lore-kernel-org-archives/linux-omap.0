From: David Brownell <david-b@pacbell.net>
Subject: Re: [RESENDING][PATCH 1/2]OMAP3 NAND: Add NAND support on OMAP3430
Date: Thu, 11 Sep 2008 02:31:47 -0700
Message-ID: <200809110231.47453.david-b@pacbell.net>
References: <41054.192.168.10.89.1219747319.squirrel@dbdmail.itg.ti.com> <200809102321.44169.david-b@pacbell.net> <19F8576C6E063C45BE387C64729E739403CD517C4B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:46228 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751797AbYIKJcL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Sep 2008 05:32:11 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E739403CD517C4B@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Singh, Vimal" <vimalsingh@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 11 September 2008, Singh, Vimal wrote:
> I will define NAND_BLOCK_SIZE as:
> #define NAND_BLOCK_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A064 * NAND_MAX_=
PAGESIZE

Never define such things without parentheses ...

Also, that looks wrong as well as sub-optimal.  Current NAND chips
can have page sizes up to 4 KB (right?), so I think "MAX" isn't
what you would want (even if it never grows again).

I'd just use SZ_128K for NAND_BLOCK_SIZE, and avoid the confusion.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
