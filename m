From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH V2] OMAP: DSS2: don't power off a panel twice
Date: Thu, 21 Oct 2010 16:42:00 +0300
Message-ID: <1287668520.2142.52.camel@tubuntu>
References: <1281496753-17471-1-git-send-email-stanley.miao@windriver.com>
	 <1282041251.2348.24.camel@tubuntu.research.nokia.com>
	 <4C8062FE.9090004@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.ext.nokia.com ([147.243.1.48]:53765 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757556Ab0JUNlu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Oct 2010 09:41:50 -0400
In-Reply-To: <4C8062FE.9090004@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext stanley.miao" <stanley.miao@windriver.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lwalkera@ieee.org" <lwalkera@ieee.org>, "lwalkera@gmail.com" <lwalkera@gmail.com>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>, Mathieu Poirier <mathieu.poirier@canonical.com>

Hi,

On Fri, 2010-09-03 at 04:52 +0200, ext stanley.miao wrote:
> Hi, Tomi,
> 
> Tomi Valkeinen wrote:
> > <snip>
> >
> > Otherwise this looks fine, except that panel-taal.c does not need
> > modifications, as it already handles this case.
> >   
> 
> I will send a V3 to remove the panel-taal.c part.
> 
> > Also, at some point I (or somebody else =) should think how to do proper
> > locking for the panel drivers. Currently it's rather broken, and, for
> > example, enabling and disabling a panel at the same time will cause
> > problems. Except for panel-taal, which uses its own lock.
> >   
> 
> First, I don't think there is any occasion where you need to enable and 
> disable a panel at the same time.

No, but that doesn't mean that enable and disable won't be called at the
same time.

> If so, what kind of result do you want ? enabled or disabled ?

Enabled or disabled, but not crashing or bugging display.

> Second, now the dssdev->state can do the lock job properly. It can 
> ensure only one function can run if both disable()
> and enable are called at the same time.

It doesn't do any kind of locking, it just checks the variable. enable
and disable can still be run at the same time.

 Tomi


