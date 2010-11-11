From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: BeagleBoard not resuming from uart with latest pm-core ?
Date: Thu, 11 Nov 2010 13:41:53 +0200
Message-ID: <20101111114153.GP16966@nokia.com>
References: <20101110164414.4529cbda@surf> <AANLkTi=Dzv2XE-X_z6yiCaRjgWrST5QGDE9dFDnDy9pT@mail.gmail.com> <87pqudaxtm.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:28260 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755119Ab0KKLm3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Nov 2010 06:42:29 -0500
Content-Disposition: inline
In-Reply-To: <87pqudaxtm.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Nov 10, 2010 at 06:32:53PM +0100, ext Kevin Hilman wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
> 
> > l-o is currently broken wrt to suspend and idle.
> > Solutions are being worked on for the moment.
> >
> > Kevin, are there solutions available yet?
> 
> The solution to your previous problem (ensuring runtime PM transitions
> work during system PM) is included in my pm-core branch, but is not yet
> the final solution.  I've been disussing this issue with the runtime PM
> maintainers for a final solution.  Until then, I will carry this in
> pm-core.
> 
> The other problem that I'm aware of so far I've only seen on boards with
> UART2 console (beagle, Overo, n900.)  The printk messages that warn of

N900 uses UART3 as its console... UART2 is bluetooth iirc.

CHeers,

Peter.
