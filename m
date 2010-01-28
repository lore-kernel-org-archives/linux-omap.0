From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: [PATCH] omap3: pm: cpufreq: populate l3 opp1 again
Date: Thu, 28 Jan 2010 19:13:25 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E22B41EC@dbde02.ent.ti.com>
References: <1264657260-12310-1-git-send-email-nm@ti.com>
 <4B6134EB.8040202@ti.com>
 <74583B8642AB8841B30447520659FCA9E768536D@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57952 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755858Ab0A1Nns convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 08:43:48 -0500
In-Reply-To: <74583B8642AB8841B30447520659FCA9E768536D@dnce01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Andrew Murray <amurray@mpc-data.co.uk>, Kevin Hilman <khilman@deeprootsystems.com>

> >IMHO the best way to unconfuse readers is to remove the entry.
> 
> The confusion is due to a mismatch between public TRM/white paper and
> current code, so maybe a simple comment on top of the
> omap34xx_l3_rate_table will be enough.
> 
But why do we want to keep an OPP that will never be used? 

