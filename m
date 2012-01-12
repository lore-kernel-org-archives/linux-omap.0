From: Kevin Hilman <khilman@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Thu, 12 Jan 2012 14:40:40 -0800
Message-ID: <87obu8sfx3.fsf@ti.com>
References: <WC20120109124643.880164@terrafix.co.uk>
	<1326386551.1896.41.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:47395 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755630Ab2ALWkn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jan 2012 17:40:43 -0500
Received: by mail-tul01m020-f171.google.com with SMTP id wc7so2367324obb.16
        for <linux-omap@vger.kernel.org>; Thu, 12 Jan 2012 14:40:42 -0800 (PST)
In-Reply-To: <1326386551.1896.41.camel@deskari> (Tomi Valkeinen's message of
	"Thu, 12 Jan 2012 18:42:31 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> On Mon, 2012-01-09 at 12:46 +0000, Joe Woodward wrote:
>> I'm running on a Gumstix Overo (OMAP3530) with an 24-bit LCD panel connected via the DPI interface (using the generic panel driver).
>> 
>> Entering standby used to work just fine on 3.0, but on 3.2 I get the following:
>
> I've been debugging this, but I'm at loss. I added some debug prints,
> which I show below, and I also pushed them to
> "git://gitorious.org/linux-omap-dss2/linux.git pm-test-prints" if
> somebody wants to see exactly what they print.
>
> Kevin, perhaps you have an idea what could be wrong here. Long version
> below, short version: doing system suspend breaks omapdss, if omapdss
> uses pm_runtime_put, but works with pm_runtime_put_sync.

Is the pm_runtime_put() done after system suspend has started?  

After system suspend has begun, the workqueue used for async callbacks
is frozen, so any runtime PM calls that you want to work during
suspend/resume must use the _sync versions.

Kevin
