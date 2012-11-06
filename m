From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 04/15] ARM: OMAP2+: hwmod: Update the reset API for
 AM33XX
Date: Tue, 6 Nov 2012 07:19:26 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC04552@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-5-git-send-email-vaibhav.bedia@ti.com>
 <5097639C.7000800@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC0336F@DBDE01.ent.ti.com>
 <79CD15C6BA57404B839C016229A409A83EB635A4@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50612 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068Ab2KFHTg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 02:19:36 -0500
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB635A4@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>

On Tue, Nov 06, 2012 at 11:36:20, Hiremath, Vaibhav wrote:
[...]

> 
> The code is checking whether the line is already de-asserted (== 0), so I am 
> not sure how this will change if hardreset line is asserted during bootup.

You are right. I just checked the behavior since I recall seeing something odd
earlier. Looks like this is needed to avoid issues with subsequent hardreset
deassertions so I'll put it back in.

Regards.
Vaibhav
