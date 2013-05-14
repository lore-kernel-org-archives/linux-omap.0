From: "Fernandes, Joel A" <joelagnel@ti.com>
Subject: RE: [PATCH] OMAP: AES: Don't idle/start AES device between Encrypt
 operations
Date: Tue, 14 May 2013 02:49:50 +0000
Message-ID: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4D6FF3@DLEE08.ent.ti.com>
References: <1368293024-6654-1-git-send-email-joelagnel@ti.com>
	<878v3i6dne.fsf@linaro.org>
	<083BC63EECB6FD41B8E81CF7FD87CC0F2E4D6E5F@DLEE08.ent.ti.com>
 <87y5bi38yc.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38233 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755826Ab3ENCtz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 May 2013 22:49:55 -0400
In-Reply-To: <87y5bi38yc.fsf@linaro.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mark A. Greer" <mgreer@animalcreek.com>

Hi Kevin,

> have to be created anyway.
> > Imagine encrypting a 20M block- this means runtime PM API is called
> > 20 * 1024 / 4 =~ 5000 times. The slow down in my opinion doesn't make it
> worth it.
> > What is your opinion about this?
> 
> OK, I'm not terribly familiar with the crypto API, so I was assuming that the
> init/exit calls you're instrumenting were happening at driver probe/remove
> time.  Based on your clarifications, that doesn't seem to be the case.
> 
> My main concern is that drivers don't simply use 'get' on driver probe and 'put'
> on driver remove and force the system awake as long as the driver is present.
> I've seen that plenty of times, and I was assuming that's what was going on
> here.  Sorry for the confusion.

[Joel] No problem, thanks. Yes, the driver doesn't put/get in the probe functions.
Just when it has to do its work.

> How about just add a few more details to the changelog summarizing
> how/when the init/exit calls happen to make it a bit more clear.

[Joel] Sure, I will make this more clear. Sorry for not doing so earlier.

Thanks,
Joel
