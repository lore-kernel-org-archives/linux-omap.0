From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 1/2] OMAP: McBSP: Always maintain McBSP fclk while
 active
Date: Wed, 11 Mar 2009 13:12:41 +0200
Message-ID: <20090311131241.24fe697c.jarkko.nikula@nokia.com>
References: <12365823123402-git-send-email-ext-eero.nurkkala@nokia.com>
	<12365823142066-git-send-email-ext-eero.nurkkala@nokia.com>
	<20090310162954.c3876442.jarkko.nikula@nokia.com>
	<1236750490.29572.197.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:49920 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbZCKLM3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 07:12:29 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2BBC558028685
	for <linux-omap@vger.kernel.org>; Wed, 11 Mar 2009 13:12:24 +0200
In-Reply-To: <1236750490.29572.197.camel@eenurkka-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 11 Mar 2009 06:48:10 +0100
"Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
wrote:

> On Tue, 2009-03-10 at 15:29 +0100, Nikula Jarkko (Nokia-D/Helsinki)
> wrote:
> > Looks like a valid change eventhough haven't tested the actual
> > problem. Would it be possible with the PM branch and Beagle now?
> > 
> > 
> > Jarkko
> 
> 
> Now this appears to be inherently wrong =)
> 
> Read this:
> 
> http://marc.info/?l=linux-omap&m=123674373120880&w=2
> 
> (Of course I went in to mention "I am 100% certain the McBSP FCLK is
> the bit 8" =)
> 
Ah, ok. I was also reviewing your patch with even some older TRM (but
this was going to be updated anyway only into next TRM) :-)


Jarkko
