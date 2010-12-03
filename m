From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] arm: mach-omap2: n8x0: clean up dummy onenand init
Date: Thu, 2 Dec 2010 17:10:24 -0800
Message-ID: <20101203011023.GC17222@atomide.com>
References: <1291305084-9159-1-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56190 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758225Ab0LCBKc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 20:10:32 -0500
Content-Disposition: inline
In-Reply-To: <1291305084-9159-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Aaro Koskinen <aaro.koskinen@nokia.com> [101202 07:40]:
> When OneNAND support is disabled, the platform code defines NULL
> board_onenand_data and empty init function for us. By utilizing this we
> can avoid cluttering board files with dummy definitions/wrappers.

Applying these too.

Tony
