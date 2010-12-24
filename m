From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: Issue : jffs2 and ecc layout
Date: Fri, 24 Dec 2010 21:51:22 +0800
Message-ID: <AANLkTi=DfzP5mkwJ3zWePSp+gthWV-OT1_kBVFtkpNWU@mail.gmail.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B03560990E3@dbde02.ent.ti.com>
	<AANLkTimJFsjLT15FA+TqDKzjvPXgxUAvovWpWKP3NCK4@mail.gmail.com>
	<201012241602.36582.manningc2@actrix.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56772 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab0LXNvZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Dec 2010 08:51:25 -0500
Received: by wwa36 with SMTP id 36so7388158wwa.1
        for <linux-omap@vger.kernel.org>; Fri, 24 Dec 2010 05:51:24 -0800 (PST)
In-Reply-To: <201012241602.36582.manningc2@actrix.gen.nz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charles Manning <manningc2@actrix.gen.nz>
Cc: "Ghorai, Sukumar" <s-ghorai@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

2010/12/24 Charles Manning <manningc2@actrix.gen.nz>:

> THis might be due to the way the omap2.c driver is now screwed up so that it
> does not read when not u32 aligned.
>
> Try this:
> http://www.spinics.net/linux/lists/linux-omap/msg42422.html
>
> Please report back if that fixes the problem for you.

No, the patch doesn't fix the issue.

thanks,
-- 
Lei Ming
