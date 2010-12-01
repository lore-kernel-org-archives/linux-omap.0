From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v8 00/11] OMAP: GPIO: Implement GPIO as platform device
Date: Wed, 1 Dec 2010 10:33:57 -0800
Message-ID: <20101201183357.GI17222@atomide.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:44779 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755618Ab0LASeH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Dec 2010 13:34:07 -0500
Content-Disposition: inline
In-Reply-To: <1290689318-10191-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, p-basak2@ti.com

* Varadarajan, Charulatha <charu@ti.com> [101125 04:39]:
> Implement OMAP GPIO module in platform device model. OMAP2+ specific GPIO
> module uses hwmod FW.
> 
> Tested on OMAP2430, OMAP4430, OMAP3430 SDP boards, OMAP4430 Blaze board
> and zoom3 board. Verified that this patch series does not break the OMAP1
> build.

I've boot tested this on N800 + 5912OSK.

I'll apply these patches into devel-gpio branch and start merging these
into linux-omap master branch and into for-next for the next merge window.

I've also added one minor fix for 16xx, will post that separately.

Regards,

Tony
