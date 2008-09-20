From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/5] watchdog: cleanup a bit omap_wdt.c
Date: Fri, 19 Sep 2008 17:41:44 -0700
Message-ID: <200809191741.44986.david-b@pacbell.net>
References: <1221820359-8943-1-git-send-email-felipe.balbi@nokia.com> <1221820359-8943-3-git-send-email-felipe.balbi@nokia.com> <1221820359-8943-4-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:41556 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752642AbYITAlr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Sep 2008 20:41:47 -0400
In-Reply-To: <1221820359-8943-4-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Wim Van Sebroeck <wim@iguana.be>, Andrew Morton <akpm@linux-foundation.org>, "George G. Davis" <gdavis@mvista.com>

On Friday 19 September 2008, Felipe Balbi wrote:
> =A0static int omap_wdt_open(struct inode *inode, struct file *file)
> =A0{
> -=A0=A0=A0=A0=A0=A0=A0struct omap_wdt_dev *wdev;
> -=A0=A0=A0=A0=A0=A0=A0void __iomem *base;
> -=A0=A0=A0=A0=A0=A0=A0wdev =3D platform_get_drvdata(omap_wdt_dev);
> -=A0=A0=A0=A0=A0=A0=A0base =3D wdev->base;
> +=A0=A0=A0=A0=A0=A0=A0struct omap_wdt_dev *wdev =3D platform_get_drvd=
ata(omap_wdt_dev);
> +=A0=A0=A0=A0=A0=A0=A0void __iomem *base =3D wdev->base;
> +

Oh, I see where "omap_wdt_dev" (global) gets used.  The normal
way to do stuff like that is using void* pointers placed in the
inode and file structures for exactly that purpose.


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
