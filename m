From: Mika Laitio <lamikr@pilppa.org>
Subject: Re: Important changes, please read
Date: Wed, 14 Jan 2009 16:15:43 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0901141613130.18586@shogun.pilppa.org>
References: <20090114134152.GJ29324@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from dyn60-31.dsl.spy.dnainternet.fi ([83.102.60.31]:45981 "EHLO
	shogun.pilppa.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754788AbZANOWo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 09:22:44 -0500
In-Reply-To: <20090114134152.GJ29324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

> - We reset arch/arm/mach-omap1 to be what's in the mainline and
>  tag that patch again with "REMOVE OMAP LEGACY CODE" so it's easy
>  to find later on. Naturally any code in that patch can be reworked
>  so it can be integrated to the mainline kernel.

What is the status of OMAP1 devices in 2.6.28-omap1 tree compared to this 
tree that will be there? Has anybody made tests whether devices like 
innovator are still either with this 2.6.28-omap1 or with 2.6.29-rc1-omap?

Mika
