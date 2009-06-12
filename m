From: Tony Lindgren <tony@atomide.com>
Subject: Re: Which directory should OMAP-L137/L138's code in ?
Date: Fri, 12 Jun 2009 03:32:00 -0700
Message-ID: <20090612103200.GB7060@atomide.com>
References: <4A32264F.6050609@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51503 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbZFLKcA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 06:32:00 -0400
Content-Disposition: inline
In-Reply-To: <4A32264F.6050609@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "stanley.miao" <stanley.miao@windriver.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

* stanley.miao <stanley.miao@windriver.com> [090612 02:53]:
> I am developing on the board OMAP-L137/L138, which is similar with  
> Davinci series board.  Should I put its platform file in the directory  
> arch/arm/mach-davinci ? or create a new direcory arch/arch/mach-L1xx for  
> it ?
>
> Any suggestions ?

If it uses DaVinci core code to me it sounds like it should be under
mach-davinci. Kevin?

Tony
