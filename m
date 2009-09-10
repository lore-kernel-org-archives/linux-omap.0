From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Is there anyway to know the way OMAP got reset
Date: Fri, 11 Sep 2009 00:24:21 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A09B032@dbde02.ent.ti.com>
References: <deb0f030909101148i3571d6d4lfae38aebc6e7131a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41181 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753220AbZIJSyZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Sep 2009 14:54:25 -0400
In-Reply-To: <deb0f030909101148i3571d6d4lfae38aebc6e7131a@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suresh Rajashekara <suresh@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Suresh Rajashekara wrote:
>
> Is there anyway on OMAP systems (or in general in embedded systems) to
> know a way in which the processor was reset, after the reset.
> 
> I am using a system based on OMAP5912 OSK and its getting reset for no
> known reason.

Not sure about the OMAP5912, but at least on the OMAP3430, there
is a register (PRM_RSTST) that can logs the global reset sources.
Reading this register after the reset should tell you the cause of
the last reset.

Maybe there is something similar in the OMAP5912.

- Anand
