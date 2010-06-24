From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 11/13] OMAP: create omap_devices for MPU, DSP, L3
Date: Thu, 24 Jun 2010 00:55:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1006240050570.1550@utopia.booyaka.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com> <1277336563-24988-12-git-send-email-khilman@deeprootsystems.com> <alpine.DEB.2.00.1006232325470.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49791 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab0FXGzg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 02:55:36 -0400
In-Reply-To: <alpine.DEB.2.00.1006232325470.1550@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

Hi Kevin,

one other thought.

On Thu, 24 Jun 2010, Paul Walmsley wrote:

> On Wed, 23 Jun 2010, Kevin Hilman wrote:
> 
> > Create simple omap_devices for the main processors and busses.
> > 
> > This is required to support the forth-coming device-based OPP
> > approach, where OPPs are managed and tracked at the device level.

If these omap_devices are only to deal with OPPs, you might only need one 
omap_device for the MPU subsystem for OMAP4, since I think both cores 
receive the same clock.  That might simplify this patch for the current 
timeframe.


- Paul
