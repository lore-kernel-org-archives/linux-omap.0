From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/3] ARM: OMAP2: delete board-rm680
Date: Tue, 8 Oct 2013 11:45:33 -0700
Message-ID: <20131008184532.GL8313@atomide.com>
References: <1380050897-6605-1-git-send-email-aaro.koskinen@iki.fi>
 <1380050897-6605-4-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:65167 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755338Ab3JHSph (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 14:45:37 -0400
Content-Disposition: inline
In-Reply-To: <1380050897-6605-4-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [130924 12:36]:
> Delete board file for Nokia RM-680/RM-696 (N950/N9). DT-based booting
> should be used for further development on this HW.

I'll apply this into omap-for-v3.13/board-removal that I
will rebase on Benoit's .dts changes before I push out
that branch.

Regards,

Tony
