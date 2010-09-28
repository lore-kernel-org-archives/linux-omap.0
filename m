From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: pandora: add fixed regulator for wlan
Date: Tue, 28 Sep 2010 14:35:32 -0700
Message-ID: <20100928213531.GP3117@atomide.com>
References: <1285190427-15834-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56052 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478Ab0I1Vfh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 17:35:37 -0400
Content-Disposition: inline
In-Reply-To: <1285190427-15834-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org

* Grazvydas Ignotas <notasas@gmail.com> [100922 14:12]:
> Instead of enabling the wifi module explicitly using GPIO, add a fixed
> regulator and hook it to MMC host card power control. This way it will
> only be enabled when SDIO subsystem wants to talk to it, saving power
> (as done by Zoom boards).

I'll queue this one for the upcoming merge window.

Tony
