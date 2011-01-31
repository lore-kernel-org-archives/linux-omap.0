From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH] i2c: OMAP: fix static suspend vs. runtime
 suspend
Date: Mon, 31 Jan 2011 10:13:13 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1101311010580.1931-100000@iolanthe.rowland.org>
References: <1a4ad626f3cb73267847e8ac7bd47545@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:40745 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752016Ab1AaPNO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Jan 2011 10:13:14 -0500
In-Reply-To: <1a4ad626f3cb73267847e8ac7bd47545@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 31 Jan 2011, Rajendra Nayak wrote:

> Can you elaborate a bit more on how/why runtime PM transitions
> are disabled during system suspend, and how is it taken care
> of that a runtime resume of a device works however a subsequent
> runtime (re)suspend does not?

I'll answer for Kevin.  This is done by the PM core, in order to 
prevent runtime power transitions from interfering with a system power 
transition.  The PM core increments the device's usage_count; this 
prevents the device from being runtime-suspended but it allows 
runtime-resume calls to go through.

Alan Stern

