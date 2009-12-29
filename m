From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: Issue in oamp nand driver with 32-bit reads in prefetch mode
Date: Tue, 29 Dec 2009 13:47:17 -0800
Message-ID: <5e088bd90912291347j370ab30cid7c6cfc558c2ed18@mail.gmail.com>
References: <ce9ab5790912230133wae2c4dcw73051221b66cb40f@mail.gmail.com>
	 <20091223174429.GD3512@atomide.com>
	 <5e088bd90912291238t1f2aba64na94887b2f864454d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:38656 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbZL2VrU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 16:47:20 -0500
Received: by qw-out-2122.google.com with SMTP id 8so1044104qwh.37
        for <linux-omap@vger.kernel.org>; Tue, 29 Dec 2009 13:47:18 -0800 (PST)
In-Reply-To: <5e088bd90912291238t1f2aba64na94887b2f864454d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Vimal Singh <vimal.newwork@gmail.com>, linux-omap@vger.kernel.org, Linux MTD <linux-mtd@lists.infradead.org>, linux-arm-kernel@lists.infradead.org

On Tue, Dec 29, 2009 at 12:38 PM, Steve Sakoman <sakoman@gmail.com> wrote:

> I can confirm that this issue exists on Overo too.  Sadly, switching
> to 16 bit reads does not fix the issue for me.  I'll start digging to
> see if I can find what's broken.

I can also confirm that there are days when I am not even capable of
applying a patch properly :-(

Switching to 16 bit read accesses does indeed fix the ECC issue on Overo too.

Which still leaves us needing to find the root cause of the breakage . . .

Steve
