From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: OMAP: timer: allow gp timer clock-event to be
 used on both cpus
Date: Mon, 6 Aug 2012 23:50:55 -0700
Message-ID: <20120807065054.GH11011@atomide.com>
References: <1333114048-26136-2-git-send-email-santosh.shilimkar@ti.com>
 <501B7AE6.8080405@gmail.com>
 <76308EBE-F802-411A-973A-7BBC7575FE5A@dominion.thruhere.net>
 <BDB76D4F-31B0-47D0-B1A1-64A743D091D3@dominion.thruhere.net>
 <CAMQu2gxLAVk-LN8R1xBeeL1=iZ-mLSRmtZe4wpQYQPTBsY5RMA@mail.gmail.com>
 <FF29FBF3-67EC-478E-9A74-65F8A2870BDC@dominion.thruhere.net>
 <79CD15C6BA57404B839C016229A409A83EA7F59B@DBDE01.ent.ti.com>
 <A6396D46-C6B9-44A4-A960-657668AF08E4@dominion.thruhere.net>
 <CAMQu2gz-93W9zWD_v3m1nQkqmnvFwcWKDTxNsf0v39y9_rhQPA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA7F6C3@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54231 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab2HGGu7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 02:50:59 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA7F6C3@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Daniel Mack <zonque@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "ccross@android.com" <ccross@android.com>, Paul Walmsley <paul@pwsan.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120803 03:34]:
> 
> Actually its not that.
> AM335x needs to be added as part of cpu_class_is_omap2(), without this it 
> gets into issues. 
> The patch has been already submitted to the list, but still not merged by 
> Tony.

Let's just add it to the list of cpu_class_is_omap2() with a proper patch
description for the fix. Then we still need to sort it out properly from
common zImage point of view without having to maintain that list.

Vaibhav, can you please post your original patch with the description
updated for v3.6-rc1?

Regards,

Tony
