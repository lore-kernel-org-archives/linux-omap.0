From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: [PATCH 4/4] I2C: OMAP3: PM: (re)init for every transfer to
 support off-mode
Date: Tue, 30 Jun 2009 11:49:04 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A874D31A321@dlee01.ent.ti.com>
References: <1245965646-20070-1-git-send-email-khilman@deeprootsystems.com>
	<1245965646-20070-2-git-send-email-khilman@deeprootsystems.com>
	<1245965646-20070-3-git-send-email-khilman@deeprootsystems.com>
	<1245965646-20070-4-git-send-email-khilman@deeprootsystems.com>
	<1245965646-20070-5-git-send-email-khilman@deeprootsystems.com>
	<4A44AD44.4070107@nokia.com> <87bpobjcx6.fsf@deeprootsystems.com>
	<F12CE1A68F023D498A2691C7B5393115035F09BD@ZMY16EXM66.ds.mot.com>
	<87y6rb7yz7.fsf@deeprootsystems.com>
	<7B4574D56E4ADF438756313E9A172A874D31A30B@dlee01.ent.ti.com>,<87ocs67ndy.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35519 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751514AbZF3Qx4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jun 2009 12:53:56 -0400
In-Reply-To: <87ocs67ndy.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: HU TAO-TGHK48 <taohu@motorola.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Hogander Jouni (Nokia-D/Tampere)" <jouni.hogander@nokia.com>, "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>

Hi Kevin,

> Jon, thanks for the clarification.  I will fold this change into
> the upstream-bound I2C changes.

Thanks.

> Tao, in the future please be sure to cite original authors and/or
> sources when submitting patches to the list.

Actually, I should point out that Hu Tao and I worked on this together originally for the omapzoom.org tree. So I should have added Hu Tao's name to this when submitting originally to omapzoom.org. So we should give credit to Hu Tao on this. Sorry about that.

Cheers,
Jon