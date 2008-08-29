From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: Pin mux utility?
Date: Fri, 29 Aug 2008 08:05:25 -0700
Message-ID: <5e088bd90808290805t1e9c71c4w21de5c9c7d90b717@mail.gmail.com>
References: <5e088bd90808290756k7c91d2dbu8e6593788d6a5d07@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB02C418C4EB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:60581 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbYH2PF0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Aug 2008 11:05:26 -0400
Received: by yx-out-2324.google.com with SMTP id 8so489234yxm.1
        for <linux-omap@vger.kernel.org>; Fri, 29 Aug 2008 08:05:26 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C418C4EB@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> How about reading the pin-mux registers directly?

That's the backup plan.  I was hoping there might be the equivalent of
the pxaregs utility for the pxa architecture - it produces a nicely
formatted text report of the current state of all pins and even allows
you to modify them.

Steve
