From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 1/1] omap3: Add minimal OMAP3 IGEP module support.
Date: Tue, 5 Oct 2010 11:16:10 -0700
Message-ID: <20101005181610.GN3117@atomide.com>
References: <1286057175-22916-1-git-send-email-eballetbo@gmail.com>
 <1286057175-22916-2-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57172 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab0JESQM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 14:16:12 -0400
Content-Disposition: inline
In-Reply-To: <1286057175-22916-2-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Enric Balletbo i Serra <eballetbo@gmail.com> [101002 14:58]:
> The OMAP3 IGEP module is a low-power, high performance production-ready
> system-on-module (SOM) based on TI's OMAP3 family. More about this
> board at www.igep.es.

Adding this to omap-for-linus. Updated it for to use MMC caps instead
of wires and to be selected by default in Kconfig.

Regards,

Tony
