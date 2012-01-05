From: Marc Butler <marc@plastictigers.com>
Subject: How do I get slimbus hwmod information?
Date: Wed, 4 Jan 2012 19:45:03 -0500
Message-ID: <20120105004503.GA4650@plastictigers.com>
Reply-To: marc@plastictigers.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from li158-162.members.linode.com ([173.230.148.162]:51095 "EHLO
	plastictigers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757321Ab2AEAxr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jan 2012 19:53:47 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Currently omap_hwmod_44xx_data.c has slimbus1/slimbus2 included in the
list of excluded IPs.

Is it possible to get a version of omap_hwmod_44xx_data.c generated
with slimbus1/2 included? 

I want this as I am currently working on a driver for the slimbus
modules, based on the SLIMbus RFC patch posted last year. 

I am concerned that I do not understand how the pieces for such a
driver should be put together: should such a driver be built from the
ground up with hwmod interfaces, or should they be added in as the
driver stabilizes?

Thanks.

-m
