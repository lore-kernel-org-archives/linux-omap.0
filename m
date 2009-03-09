From: Juha Yrjola <juha.yrjola@solidboot.com>
Subject: Re: [PATCH] OMAP: Store reboot mode in scratchpad on OMAP34xx
Date: Mon, 09 Mar 2009 20:08:09 +0200
Message-ID: <49B55B09.7070803@solidboot.com>
References: <1236532839-3696-1-git-send-email-juha.yrjola@solidboot.com>	<20090309172140.GF7329@atomide.com> <8763iizitg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from solidboot.com ([92.48.122.80]:60469 "EHLO rei.solidboot.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752970AbZCISfP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Mar 2009 14:35:15 -0400
In-Reply-To: <8763iizitg.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Kevin Hilman wrote:

> Maybe just a brief description of this scratchpad location is reserved.
> Is there a boot ROM doc that could be referenced?

I don't know how public the boot ROM behaviour is. On my OMAP34xx TRM, 
the relevant info is in Chapter 26.4.4.4, Software Booting Configuration.

Cheers,
Juha
