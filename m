From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH] Debobs and ETK padconf implementation
Date: Thu, 25 Sep 2008 15:06:49 +0300
Message-ID: <20080925120649.GF4654@codecarver.research.nokia.com>
References: <1221663749-26121-1-git-send-email-peter.de-schrijver@nokia.com> <1221663749-26121-2-git-send-email-peter.de-schrijver@nokia.com> <1221663749-26121-3-git-send-email-peter.de-schrijver@nokia.com> <87ej38ob7t.fsf@deeprootsystems.com> <20080925113550.GC4654@codecarver.research.nokia.com> <873ajoo3mk.fsf@deeprootsystems.com> <20080925115256.GD4654@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:44361 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757354AbYIYMH3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 08:07:29 -0400
Content-Disposition: inline
In-Reply-To: <20080925115256.GD4654@codecarver.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

> > In that case, what is the proposed method for other kernel code to use
> > the debobs lines?
> 
> Hmm, good point :) My idea was to use the gpiolib calls on GPIO12 -
> GPIO29, but then there is no way for a user to know if the GPIO was
> assigned to debobs or not... Maybe debobs should register as gpiolib
> 'chip' and reexport those lines ? Would that make sense ?
> 

Actually, debobs should be claiming IO pads, not GPIOs. Unfortunately
there is no way to do that currently :(

Cheers,

Peter.

-- 
goa is a state of mind
