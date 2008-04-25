From: Tony Lindgren <tony@atomide.com>
Subject: Re: PRCM: 34XX: Add PARENT_CONTROLS_CLOCK flag to dpll5_m2_ck
Date: Fri, 25 Apr 2008 11:20:49 -0700
Message-ID: <20080425182049.GC7671@atomide.com>
References: <874p9s3ebw.fsf@trdhcp146196.ntc.nokia.com> <alpine.DEB.1.00.0804251152550.28937@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59750 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764761AbYDYSUx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2008 14:20:53 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804251152550.28937@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080425 10:54]:
> On Wed, 23 Apr 2008, H=F6gander Jouni wrote:
>=20
> > This patch removes following message on dpll5_m2_ck enable and
> > disable:
> >=20
> > clock.c: Enable for dpll5_m2_ck without enable code
> > clock: clk_disable called on independent clock dpll5_m2_ck which ha=
s no enable_reg
> >=20
> > Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>=20
> Acked-by: Paul Walmsley <paul@pwsan.com>

Pushing.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
