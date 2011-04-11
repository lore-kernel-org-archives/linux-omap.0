From: Tomasz =?utf-8?Q?M=C5=82oduchowski?=
	<tomasz.mloduchowski@xlogic.pl>
Subject: Re: Diagnosing issues with OMAPDSS scaling of overlay 0
Date: Mon, 11 Apr 2011 12:08:23 +0200 (CEST)
Message-ID: <f49bfabe-ecf0-4e9e-89d5-1a6a5c00b4b3@zimbra.xlogic.pl>
References: <1302503571.2198.0.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 81-18-210-90.static.chello.pl ([81.18.210.90]:51460 "EHLO
	mail.xlogic.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755411Ab1DKKRq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Apr 2011 06:17:46 -0400
In-Reply-To: <1302503571.2198.0.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

>> Is there a way to diagnose why the omapdss fails to scale ovl 0?
> No need to diagnose, graphics overlay (overlay 0) cannot be scaled =).
Thanks so much! 

Now that you pointed me in the right direction - the only place this limitation is actually mentioned is the TRM document (and the driver seems quite content to export unsupported functionality to the sysfs)

Perhaps next time someone stumbles over my naive question and finds this thread. If I find the time this week, I'll try adding something to the documentation.

- Tomasz
