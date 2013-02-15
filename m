From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Guidelines to move mach-omap2/gpmc to
 drivers/memory-controller
Date: Fri, 15 Feb 2013 19:53:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302151952410.19565@utopia.booyaka.com>
References: <20130215165840.GB2442@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37298 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab3BOTxg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Feb 2013 14:53:36 -0500
In-Reply-To: <20130215165840.GB2442@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Fri, 15 Feb 2013, Ezequiel Garcia wrote:

> I imagine one of the biggest issues is GPMC's dependency on
> hwmod code. Can anyone shed some light on how to handle this?

What dependency is this?  I'm not aware of any GPMC dependency to hwmod; 
there shouldn't be any.


- Paul
