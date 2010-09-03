From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH V2] OMAP: DSS2: don't power off a panel twice
Date: Fri, 03 Sep 2010 10:52:46 +0800
Message-ID: <4C8062FE.9090004@windriver.com>
References: <1281496753-17471-1-git-send-email-stanley.miao@windriver.com> <1282041251.2348.24.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44674 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755003Ab0ICCx3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 22:53:29 -0400
In-Reply-To: <1282041251.2348.24.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lwalkera@ieee.org" <lwalkera@ieee.org>, "lwalkera@gmail.com" <lwalkera@gmail.com>, bryan.wu@canonical.com, Mathieu Poirier <mathieu.poirier@canonical.com>

Hi, Tomi,

Tomi Valkeinen wrote:
> <snip>
>
> Otherwise this looks fine, except that panel-taal.c does not need
> modifications, as it already handles this case.
>   

I will send a V3 to remove the panel-taal.c part.

> Also, at some point I (or somebody else =) should think how to do proper
> locking for the panel drivers. Currently it's rather broken, and, for
> example, enabling and disabling a panel at the same time will cause
> problems. Except for panel-taal, which uses its own lock.
>   

First, I don't think there is any occasion where you need to enable and 
disable a panel at the same time.
If so, what kind of result do you want ? enabled or disabled ?

Second, now the dssdev->state can do the lock job properly. It can 
ensure only one function can run if both disable()
and enable are called at the same time.

Stanley.

>  Tomi
>
>
>
>   

