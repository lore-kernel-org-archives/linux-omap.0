From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: v2.6.28-omap1 tagged, some bugs remain
Date: Tue, 13 Jan 2009 09:08:01 +0200
Message-ID: <20090113090801.3a575b89.jarkko.nikula@nokia.com>
References: <20090112145051.GL9373@atomide.com>
	<B5CEECBB-9939-46B9-BEDB-D8D9879DB63E@student.utwente.nl>
	<20090112161514.GP9373@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27694 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbZAMHIf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 02:08:35 -0500
In-Reply-To: <20090112161514.GP9373@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Mon, 12 Jan 2009 18:15:20 +0200
"ext Tony Lindgren" <tony@atomide.com> wrote:

> >> - According to Jarkko Nikula, ASoC does not currently work because of
> >>  some recent clock changes.
> >
> > Confirmed on omap3evm.
> 
> Thanks, can you try to git-bisect the breaking commit?
> 
I did very short test on sunday and it was working at least when
checkouting into 12081fce83c10221ccd1b282e3e2fbe56f742e21, i.e. commit
before 60b8b431e47d8c5b8c02a2e4fa9af388aae20790 which was mentioned in
the commit 818862e11bad091dc635baedace58265a126b5c8 :-)

Paul was going to take a look tomorrow.


Jarkko
