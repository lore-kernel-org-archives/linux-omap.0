From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v5 1/1] OMAP2: Spi: Force CS to be in inactive state after
 off-mode transition
Date: Tue, 30 Nov 2010 09:26:04 +0100
Message-ID: <4CF4B51C.7030902@free-electrons.com>
References: <509131.41359.qm@web180304.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:37336 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab0K3I0R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Nov 2010 03:26:17 -0500
In-Reply-To: <509131.41359.qm@web180304.mail.gq1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, spi-devel-general@lists.sourceforge.net, Grant Likely <grant.likely@secretlab.ca>

On 11/30/2010 04:08 AM, David Brownell wrote:
>>> Now force CS to be in inactive state only if it was
>> inactive when it was suspended.
> 
> Note that it's a bug if CS is active in
> any suspend state (including OFF).  That
> strongly suggests $SUBJECT is an incomplete
> workaround for that other bug...
> 

It is not the case, at least it is not what we
observed. In suspend state, CS is inactive.

>>>
>>> When SPI wake up from OFF mode, CS is in the wrong
>> state: force it to the inactive state.
> 
> Best report the bug that the suspend/OFF state
> was mis-handled...  That is, it didn't
> correctly ENTER that OFF mode...
> 
> In fact ... I'd like to see that fixed more
> than the $SUBJECT issue, so the root cause
> gets resolved...

As far as I know, it enter correctly that OFF mode.
It is only at wake up, that CS become active while
there is no SPI message being processed. It is the
point of my patch.

My first patch version forced unconditionally CS to
inactive state at wake up. It was correct from the
point of view of the SPI but not for suspend/resume.
Resume should only restore the state of the driver
just before suspend. If resume force the inactive
state it could mask a bug in the suspend path.
But as I wrote before, as far as I know there is no
bug when driver enter suspend mode, at this moment
CS is inactive.

> 
> CS should only be active while a SPI message
> is being processed, and such processing must
> have completed before suspend/OFF/... starts
> 
I agree and this driver seems to respect this point.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
