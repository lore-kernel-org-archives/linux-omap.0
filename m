From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4] OMAP: Fix McBSP spin_lock deadlock
Date: Thu, 15 Jan 2009 17:44:23 +0200
Message-ID: <20090115154423.GG4128@atomide.com>
References: <1232010712-25142-1-git-send-email-stanley.miao@windriver.com> <200901150135.27298.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59778 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224AbZAOPoY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2009 10:44:24 -0500
Content-Disposition: inline
In-Reply-To: <200901150135.27298.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [090115 11:35]:
> On Thursday 15 January 2009, Stanley.Miao wrote:
> > =A04 files changed, 78 insertions(+), 228 deletions(-)
>=20
> You know, I'm always predisposed to like bugfixes that delete
> more code than they add.  ;)

Thanks Stanley, pushed to linux-omap at 2.6.29-rc1, omap-2.6.28,
and added to omap-fixes queue for the mainline kernel.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
