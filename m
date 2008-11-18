From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] OMAP: MCSPI: Enable mcspi wake-up
Date: Tue, 18 Nov 2008 19:19:17 +0200
Message-ID: <20081118171917.GO20808@gandalf.research.nokia.com>
References: <1227013237-13650-1-git-send-email-jouni.hogander@nokia.com> <20081118133209.GY20808@gandalf.research.nokia.com> <200811180915.35230.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27255 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944AbYKRRTu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2008 12:19:50 -0500
Content-Disposition: inline
In-Reply-To: <200811180915.35230.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dbrownell@users.sourceforge.net
Cc: felipe.balbi@nokia.com, ext Jouni Hogander <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org

On Tue, Nov 18, 2008 at 09:15:34AM -0800, David Brownell wrote:
> On Tuesday 18 November 2008, Felipe Balbi wrote:
> > > +#define OMAP2_MCSPI_SYSCONFIG_SMARTIDLE=A0=A0=A0=A0=A0=A0(0x2 <<=
 3)
> > > +#define OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP=A0=A0=A0=A0=A0=A0(0x1 <<=
 2)
> >=20
> > could you follow the convention below and use (1 << offset) ??
>=20
> Or even BIT(offset).

much better :-)

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
