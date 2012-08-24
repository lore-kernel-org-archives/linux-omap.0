From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 10/10] ARM: OMAP2+: tusb6010: generic timing
 calculation
Date: Fri, 24 Aug 2012 12:46:30 -0700
Message-ID: <20120824194630.GU11011@atomide.com>
References: <cover.1345524670.git.afzal@ti.com>
 <bc000ac53bb1b3ae1a951bbcf372caf6336d2a19.1345524670.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:11327 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757692Ab2HXTqf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Aug 2012 15:46:35 -0400
Content-Disposition: inline
In-Reply-To: <bc000ac53bb1b3ae1a951bbcf372caf6336d2a19.1345524670.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: jon-hunter@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Afzal Mohammed <afzal@ti.com> [120821 03:46]:
> Generic gpmc timing calculation helper is available now, use
> it instead of custom timing calculation.

This hangs n800 during the boot.

Tony
