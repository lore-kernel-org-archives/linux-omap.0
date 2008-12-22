From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: status of USB on omap35xx ?
Date: Mon, 22 Dec 2008 14:21:40 +0200
Message-ID: <20081222122140.GH7125@gandalf.research.nokia.com>
References: <5e088bd90812110938i10526ad3x94b47bb8adeb91b4@mail.gmail.com> <6ed0b2680812111241u5da7abd5r10094bf79ea9c299@mail.gmail.com> <alpine.DEB.2.00.0812111401100.26754@utopia.booyaka.com> <6ed0b2680812111452t75b175bdr304e9b1d22ea93de@mail.gmail.com> <alpine.DEB.2.00.0812111603520.26754@utopia.booyaka.com> <6ed0b2680812121215m15ff0e59t8ede0e5dca5b6270@mail.gmail.com> <alpine.DEB.2.00.0812121331180.26754@utopia.booyaka.com> <FCCFB4CDC6E5564B9182F639FC356087025106711C@dbde02.ent.ti.com> <alpine.DEB.2.00.0812121410220.26754@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB02E65453BA@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:18842 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbYLVMWn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Dec 2008 07:22:43 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02E65453BA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Steve Sakoman <sakoman@gmail.com>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "me@felipebalbi.com" <me@felipebalbi.com>, "Kridner, Jason" <jdk@ti.com>, "sakari.poussa@nokia.com" <sakari.poussa@nokia.com>, Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

Hi,

On Mon, Dec 22, 2008 at 03:55:26AM +0530, Anand Gadiyar wrote:
> The EHCI driver should actually go to linux-usb. If you look
> at the list archives, you will find that I had said I would
> do that - ages ago. Unfortunately I have not been able to do
> that so far. It's high on the priority list however.

Sure, but still we need some cleanups to EHCI driver before sending it
to linux-usb. Do you guys have plans to do that ? Unfortunately I don't
have hw to test it so that makes it difficult for me to patch ehci-omap

-- 
balbi
