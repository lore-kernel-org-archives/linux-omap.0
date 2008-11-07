From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: Problems with jffs2 rootfs using 2.6.28-rc3
Date: Fri, 7 Nov 2008 13:21:29 -0800
Message-ID: <5e088bd90811071321v5bc2b4adm2b89eebf1f3f906c@mail.gmail.com>
References: <5e088bd90811071209w6fb1b6c0y689d589819104862@mail.gmail.com>
	 <200811071246.17303.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.183]:23187 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbYKGVVb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 16:21:31 -0500
Received: by ik-out-1112.google.com with SMTP id c29so1250552ika.5
        for <linux-omap@vger.kernel.org>; Fri, 07 Nov 2008 13:21:30 -0800 (PST)
In-Reply-To: <200811071246.17303.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Nov 7, 2008 at 12:46 PM, David Brownell <david-b@pacbell.net> wrote:
> On Friday 07 November 2008, Steve Sakoman wrote:
>> I'm having little success.  It used to work back in 2.6.26 timeframe
>> but seems to have broken sometime during 2.6.27.
>
> There's a patch floating around making the omap2 NAND driver
> use readsw not readsl, which might explain that problem...

Do you recall where you saw that patch?  Here or linux-mtd?  My
initial search efforts weren't successful.

Steve
