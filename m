From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCHv3 0/3] OMAP UART: Adding support for omap-serial driver.
Date: Mon, 23 Nov 2009 11:05:44 -0600
Message-ID: <20091123170544.GA10313@lixom.net>
References: <35552.192.168.10.88.1256713953.squirrel@dbdmail.itg.ti.com> <44977.192.168.10.88.1258095220.squirrel@dbdmail.itg.ti.com> <d6a0f7aa0911200151xb948a28kf4f22d79e61b993e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:35158 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752244AbZKWREw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Nov 2009 12:04:52 -0500
Content-Disposition: inline
In-Reply-To: <d6a0f7aa0911200151xb948a28kf4f22d79e61b993e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>, g@lixom.net
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, "Pandita, Vikram" <vikram.pandita@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>

On Fri, Nov 20, 2009 at 03:21:26PM +0530, Govindraj wrote:
> I have not seen any comments on this patch series yet.
> 
> Tony,
> Is there something I need to modify?

Govindaj,

I'm having problems with these patches on Zoom2 with debug board, since
they don't seem to coexist very well together with 8250. Enabling both
options will result in build errors.

Also, you have hardcoded and are using the same major/minor versions as
the 8250 driver, which results in failure to allocate those devices when
probing 8250. That needs to be corrected.


-Olof

