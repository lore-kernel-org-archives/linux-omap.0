From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] OMAP2/3: GPMC: ensure valid clock pointer
Date: Thu, 28 Jan 2010 15:24:24 -0800
Message-ID: <20100128232424.GS23505@atomide.com>
References: <1264699036-5491-1-git-send-email-khilman@deeprootsystems.com>
 <1264699036-5491-3-git-send-email-khilman@deeprootsystems.com>
 <20100128172231.GA27291@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62832 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755586Ab0A1XYH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 18:24:07 -0500
Content-Disposition: inline
In-Reply-To: <20100128172231.GA27291@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: ext Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Felipe Balbi <felipe.balbi@nokia.com> [100128 09:24]:
> On Thu, Jan 28, 2010 at 06:17:14PM +0100, ext Kevin Hilman wrote:
> >Ensure valud clock pointer during GPMC init.  Fixes compiler
>            ^ typo :-)

Adding the first two to omap-fixes, also fixed this typo.

Adding the last to master branch, we have to wait for Paul
to merge those into his branch and then redo omap-for-linus.

Tony
