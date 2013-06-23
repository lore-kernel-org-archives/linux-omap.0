From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v3 1/4] mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC
 configurations in device_probe
Date: Sun, 23 Jun 2013 18:06:51 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9DF3A8@DBDE04.ent.ti.com>
References: <1371935030-20773-1-git-send-email-pekon@ti.com>
 <1371935030-20773-2-git-send-email-pekon@ti.com>,<20130622214717.GA1569@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57566 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737Ab3FWSHe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Jun 2013 14:07:34 -0400
In-Reply-To: <20130622214717.GA1569@arwen.pp.htv.fi>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "Cousson, Benoit" <b-cousson@ti.com>, "arnd@arndb.de" <arnd@arndb.de>, "Philip, Avinash" <avinashphilip@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "jp.francois@cynove.com" <jp.francois@cynove.com>

>> From: "Gupta, Pekon" <pekon@ti.com>

> Can you fix your From address ? I guess:
> git config --global user.name "Pekon Gupta"
> should do it, but you'll have to recommit those commits with:
> git commit --amend --reset-author
[Pekon]: Thanks for pointing it out. I had missed this.
I updated my global config recently, But as this patch series was 
ported from my older branch, so older 'from' string continued.
Fixed now and re-sent.

with regards, pekon