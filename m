From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 00/10] ARM: dts: TI: Add CAN support
Date: Tue, 4 Nov 2014 07:55:03 -0800
Message-ID: <20141104155502.GS31454@atomide.com>
References: <1415098134-26405-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:27704 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819AbaKDP4P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Nov 2014 10:56:15 -0500
Content-Disposition: inline
In-Reply-To: <1415098134-26405-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, wsa@the-dreams.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, devicetree@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [141104 02:50]:
> Hi Tony,
> 
> These patches add CAN support for am33xx, am43xx and dra7 platforms.
> They must go in together with CAN driver RAMINIT Syscon support [1].

Can you make this series not depend on [1] for most part without
breaking existing functionality?

Then we can do a single follow-up patch to enable things after [1]
has been merged.

That would remove a dependency between driver changes and .dts changes.

Regards,

Tony

> [1] - CAN driver RAMINIT Syscon support
> http://article.gmane.org/gmane.linux.can/6773
