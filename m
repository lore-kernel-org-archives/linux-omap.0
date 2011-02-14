From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: McBSP: Remove unused audio macros in mcbsp.h
Date: Mon, 14 Feb 2011 14:58:22 -0800
Message-ID: <20110214225821.GQ20795@atomide.com>
References: <1296810909-24737-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48381 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab1BNW63 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 17:58:29 -0500
Content-Disposition: inline
In-Reply-To: <1296810909-24737-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jhnikula@gmail.com>

* Kishon Vijay Abraham I <kishon@ti.com> [110204 01:17]:
> Some macros defined in mcbsp.h related to audio, which are never being used
> is removed.

Applying this to devel-cleanup branch for the upcoming merge window.

Tony
