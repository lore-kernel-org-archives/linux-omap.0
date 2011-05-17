From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH 1/4] omap: igep0020: name refactoring for future
 merge with IGEP3
Date: Tue, 17 May 2011 10:53:46 +0300
Message-ID: <20110517075345.GQ5323@atomide.com>
References: <cover.1305235542.git.mike@compulab.co.il>
 <d6dc9e334c729523f25993b7d610808e537ca74c.1305235542.git.mike@compulab.co.il>
 <BANLkTikJaN=Q2RgrA7Hz-ye2BCOjNK42zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:38247 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752525Ab1EQHxx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 May 2011 03:53:53 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikJaN=Q2RgrA7Hz-ye2BCOjNK42zA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric =?utf-8?B?QmFsbGV0YsOy?= i Serra <eballetbo@gmail.com>
Cc: Mike Rapoport <mike@compulab.co.il>, Tony.Lindgren.tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Enric Balletb=C3=B2 i Serra <eballetbo@gmail.com> [110516 10:11]:
> Hi Mike,
>=20
> The only comment I wanted to do is maybe I prefer rename the
> board-igep0020 to board-igep00x0 to be more generic. Apart from this
> these patch series looks good for me and has my ack. Thanks.

I suggest we do the rename separately later on. Otherwise it
easily gets classified as "crazy churn" type of patch, so best
to stick to just code coalescing and fixes for this merge window.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
