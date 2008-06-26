From: Felipe Balbi <me@felipebalbi.com>
Subject: RE: [PATCH 0/4] OMAP2/3 clock: fix some bugs in =?UTF-8?Q?omap=32=5Fclk?=
 =?UTF-8?Q?=5Fwait=5Fready=28=29?=
Date: Thu, 26 Jun 2008 14:11:35 -0500
Message-ID: <1ad6998ad72e30b16522b7d499317268@felipebalbi.com>
References: <20080626070305.16555.96759.stgit@localhost.localdomain> <FCCFB4CDC6E5564B9182F639FC356087019826DC08@dbde02.ent.ti.com> <alpine.DEB.1.00.0806261112400.25954@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48776 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbYFZTLl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 15:11:41 -0400
In-Reply-To: <alpine.DEB.1.00.0806261112400.25954@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, linux-omap@vger.kernel.org

Hi,

On Thu, 26 Jun 2008 11:13:10 -0600 (MDT), Paul Walmsley <paul@pwsan.com=
>
wrote:
>> I hope this has fixed:
>> "Clock usbhost_48m_fck didn't enable in 100000 tries"
>=20
> First I've heard of it, Vikram.  Tell me more.

afaict this was fixed by a patch from Jouni H=C3=B6gander,
the problem was basically a shift value when checking
if the clock was already enabled.

Not sure about it, but that's what came to my mind by
reading the mail.

--=20
Best Regards,

=46elipe Balbi
http://blog.felipebalbi.com
me@felipebalbi.com

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
