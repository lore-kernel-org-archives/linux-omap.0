From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: Re: PM: timeout waiting for write of PM_WKEN_WKUP.EN_IO_CHAIN
Date: Fri, 15 May 2009 09:26:48 +0300
Message-ID: <1242368808.6466.203.camel@ubuntu>
References: <87r5yry8wr.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:30296 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755135AbZEOG0q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 May 2009 02:26:46 -0400
In-Reply-To: <87r5yry8wr.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2009-05-14 at 18:57 +0300, Kevin Hilman wrote:
> Kalle,
> 
> In your "Enable IO-CHAIN wakeup" patch[1], you set a timout based on
> 1000 tries of reading back from PM_WKST_WKUP.
> 
> Just curious how you came up with that value. 

I tested it around a few times, and the loop seemed to run 2 iterations
max. 1000 is just a random (big enough) number that I think should work
if everything is ok. 


> 
> On ES3.1 3430SDP, some TI folks are seeing that timeout warning
> every time hitting idle.

Then there is something wrong and the io-chain enable is not working.
Please try removing the timeout and see if it hangs completely. I don't
have a SDP to test on.

- Kalle

> 
> Kevin
> 
> [1] http://marc.info/?l=linux-omap&m=123807750921423&w=2

