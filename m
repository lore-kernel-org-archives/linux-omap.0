From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP: MCSPI: Enable mcspi wake-up
Date: Tue, 18 Nov 2008 09:15:34 -0800
Message-ID: <200811180915.35230.david-b@pacbell.net>
References: <1227013237-13650-1-git-send-email-jouni.hogander@nokia.com> <20081118133209.GY20808@gandalf.research.nokia.com>
Reply-To: dbrownell@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:30916 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755373AbYKRRPm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Nov 2008 12:15:42 -0500
In-Reply-To: <20081118133209.GY20808@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext Jouni Hogander <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org

On Tuesday 18 November 2008, Felipe Balbi wrote:
> > +#define OMAP2_MCSPI_SYSCONFIG_SMARTIDLE=A0=A0=A0=A0=A0=A0(0x2 << 3=
)
> > +#define OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP=A0=A0=A0=A0=A0=A0(0x1 << 2=
)
>=20
> could you follow the convention below and use (1 << offset) ??

Or even BIT(offset).

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
