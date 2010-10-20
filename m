From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] arm: omap: combine zoom2 and zoom3 board-files
Date: Wed, 20 Oct 2010 09:30:51 -0700
Message-ID: <20101020163051.GB28099@atomide.com>
References: <1287555912-16058-1-git-send-email-balbi@ti.com>
 <1287555912-16058-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62420 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab0JTQaz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Oct 2010 12:30:55 -0400
Content-Disposition: inline
In-Reply-To: <1287555912-16058-2-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Anand Gadiyar <gadiyar@ti.com>

* Felipe Balbi <balbi@ti.com> [101019 23:16]:
> They are extremely similar anyway, let's get rid
> of one file.
> 
> While at that, also remove the empty zoom_config
> variable.

Nice, that saves up some memory.

Tony
