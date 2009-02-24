From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP: HSMMC: Initialize hsmmc controller registers when resuming
Date: Tue, 24 Feb 2009 14:12:07 -0800
Message-ID: <200902241412.08043.david-b@pacbell.net>
References: <4d34a0a70902200400s252f48ddvfd6e0d83e91fa291@mail.gmail.com> <200902231023.49653.david-b@pacbell.net> <49A3EF96.3090603@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:28936 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760356AbZBXWML (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Feb 2009 17:12:11 -0500
In-Reply-To: <49A3EF96.3090603@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <ext-adrian.hunter@nokia.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Kim Kyuwon <chammoru@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "drzeus-mmc@drzeus.cx" <drzeus-mmc@drzeus.cx>, =?utf-8?q?=B1=E8=B1=D4=BF=F8?= <q1.kim@samsung.com>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>

On Tuesday 24 February 2009, Adrian Hunter wrote:
> I would still like the other two issues I raised considered.
> They were:
> =A0=A0=A0=A0=A0=A0=A0=A01. =A0'host' can be NULL in omap_mmc_suspend(=
) / omap_mmc_resume()
> =A0=A0=A0=A0=A0=A0=A0=A02. wait for SDBP bit

Someone from Nokia was going to be shepherding HSMMC patches,
as I recall... that person should deal with these issues.  :)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
