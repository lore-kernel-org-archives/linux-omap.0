From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 00/11] ARM: dts: sbc-t3x: add support for more boards
Date: Sun, 02 Mar 2014 16:15:45 +0200
Message-ID: <53133D11.7000502@compulab.co.il>
References: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il> <52FB6B2E.9070106@compulab.co.il> <5309E9EE.2040705@compulab.co.il> <20140228221219.GH13624@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:41435 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752251AbaCBOQM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 2 Mar 2014 09:16:12 -0500
In-Reply-To: <20140228221219.GH13624@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, Benoit Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 03/01/14 00:12, Tony Lindgren wrote:
> * Igor Grinberg <grinberg@compulab.co.il> [140223 04:33]:
>> ping x2!
> 
> Thanks applying into omap-for-v3.15/dt finally.

Thanks!

> 
> Is it OK to remove the board-cm-*.c files for v3.15?

Hmmm....
I thought we will have a transition release with both ways and
similar functionality available...
For this to happen, we need to extend the DT support to the stuff
board-cm-t*.c files cover before removing them...
We should be able to send additional patches in 3-5 weeks.
Since rc4 is out a week ago, and rc5 is coming, we won't be able
to prepare the extension in time for 3.15...
So, can we postpone the board-cm-t*.c files removal to 3.16?
Or does it make too much trouble for you?

-- 
Regards,
Igor.
