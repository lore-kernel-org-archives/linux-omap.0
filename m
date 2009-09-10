From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: Is there anyway to know the way OMAP got reset
Date: Thu, 10 Sep 2009 14:11:19 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A8788E4B429@dlee01.ent.ti.com>
References: <deb0f030909101148i3571d6d4lfae38aebc6e7131a@mail.gmail.com>,<5A47E75E594F054BAF48C5E4FC4B92AB030A09B032@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32983 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753159AbZIJTOZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Sep 2009 15:14:25 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A09B032@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, Suresh Rajashekara <suresh@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Not sure about the OMAP5912, but at least on the OMAP3430, there
> is a register (PRM_RSTST) that can logs the global reset sources.
> Reading this register after the reset should tell you the cause of
> the last reset.
> 
> Maybe there is something similar in the OMAP5912.

You can look at the ARM_SYSST register on the 5912. This should tell you the source on the reset (external, watchdog, software, etc) that occured. 

Jon