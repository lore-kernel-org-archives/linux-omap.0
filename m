From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/3] ARM: OMAP4: register V1V8, V2V1 regulators
Date: Wed, 9 May 2012 10:13:11 -0700
Message-ID: <20120509171310.GP5088@atomide.com>
References: <1336548814-1005-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58103 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413Ab2EIRNN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 13:13:13 -0400
Content-Disposition: inline
In-Reply-To: <1336548814-1005-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120509 00:37]:
> Hello,
> 
> Changes since v1:
> - rebased on 3.4-rc6
> 
> Original intro message:
> 
> This series adds common configuration for the V1V8, V2V1 regulators from
> twl6030. These regulators are commonly used to feed the twl6040 audio IC on
> OMAP4 based boards (SDP4430, PandaBoards).
> 
> The regulator support for the twl6040 MFD driver will be going via MFD tree to
> avoid cross tree issues.

Thanks applying into board branch.

Tony
