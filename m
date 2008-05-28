From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Driver for omap34xx temperature sensor. second version.
Date: Wed, 28 May 2008 16:12:29 -0700
Message-ID: <20080528231228.GB8013@atomide.com>
References: <20080519135629.GB5040@codecarver.research.nokia.com> <20080523104942.GB4976@codecarver.research.nokia.com> <B5748808-2B1B-4849-8324-844B4BF56F33@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:65332 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155AbYE1XMb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 19:12:31 -0400
Content-Disposition: inline
In-Reply-To: <B5748808-2B1B-4849-8324-844B4BF56F33@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: linux-omap@vger.kernel.org

* Koen Kooi <k.kooi@student.utwente.nl> [080528 16:08]:
> 
> Op 23 mei 2008, om 12:49 heeft Peter 'p2' De Schrijver het volgende  
> geschreven:
> 
> > Hi,
> >
> > This patch adds a hwmon driver for the OMAP34xx internal temperature
> > sensor. I get unusually high values (80 degrees and more) from this
> > sensor though.
> 
> Same high values here as well:
> 
> root@beagleboard:/sys/class/hwmon/hwmon0/device# cat temp1_input
> 96
> 
> does anyone from TI have a hint if the chip is really that hot, or  
> that we need to scale the value?

Maybe it's in Fahrenheit?

Tony
