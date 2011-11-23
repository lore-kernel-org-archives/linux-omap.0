From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap fixes for v3.2-rc2
Date: Wed, 23 Nov 2011 23:22:28 +0100
Message-ID: <21329850.CZjvquqxJn@wuerfel>
References: <20111119194408.GD31337@atomide.com> <201111232115.41035.arnd@arndb.de> <20111123220358.GI31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50699 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab1KWWWk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Nov 2011 17:22:40 -0500
In-Reply-To: <20111123220358.GI31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>

On Wednesday 23 November 2011 14:03:58 Tony Lindgren wrote:
> 
> The earlier patches are based on the earlier fixes (while waiting
> for them to get merged). So that's certainly not a random commit.
> Or at least was not at that time  I can rebase those too anyways
> now that the earlier fixes are merged.

No need to do that unless you are rebasing them anyway. IMHO
it's fine if you have all your bug fixes in one branch based
on the previous bug fixes you sent, but it's of course also
fine to start a fresh branch for each pull request.

In general, I would recommend not rebasing when you have the
choice, because that means your patches are not as well tested.

	Arnd
