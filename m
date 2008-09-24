From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: OMAP: Allocate McBSP devices dynamically, add
	34xx support
Date: Wed, 24 Sep 2008 15:32:40 +0300
Message-ID: <20080924123238.GQ5222@atomide.com>
References: <1222249943-19435-1-git-send-email-tony@atomide.com> <1222249943-19435-2-git-send-email-tony@atomide.com> <20080924115838.GB18700@strlen.de> <20080924121001.GP5222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62858 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582AbYIXMdG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 08:33:06 -0400
Content-Disposition: inline
In-Reply-To: <20080924121001.GP5222@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Chandra Shekhar <x0044955@ti.com>

* Tony Lindgren <tony@atomide.com> [080924 15:10]:
> * Uwe Kleine-K=F6nig <ukleinek@strlen.de> [080924 14:58]:

<snip>

> > Hhm, it looks there is already some 34xx support in the file.  Shou=
ld
> > the commit log be more detailed?
>=20
> Will split into a separate patch.

I'll change it to say add support for instances 3 - 5 on 34xx.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
