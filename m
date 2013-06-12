From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: gpmc: removed 'gpmc,device-nand'.
 type determined from node-name
Date: Wed, 12 Jun 2013 09:59:07 -0700
Message-ID: <20130612165906.GH8164@atomide.com>
References: <1370001691-29320-1-git-send-email-pekon@ti.com>
 <1370001691-29320-2-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61821 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757196Ab3FLQ7J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jun 2013 12:59:09 -0400
Content-Disposition: inline
In-Reply-To: <1370001691-29320-2-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Jon Hunter <jgchunter@gmail.com>

* Gupta, Pekon <pekon@ti.com> [130531 05:07]:
> From: "Gupta, Pekon" <pekon@ti.com>
> 
> GPMC supports multiple types of child devices like NAND, NOR, OneNand, Ethernet
> This patch removes 'gpmc,device-nand', used explicitely to specify NAND type
> gpmc-child. Instead gpmc-child type can be inferred from gpmc->child->name.

This does not seem to apply. Also please break into a gpmc.c patch and
then the .dts patch for Benoit. And make sure you consider if removing
this binding might break something. If it does, we need to maintain the
support for the old binding.

Regards,

Tony
