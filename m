From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] ARM: omap2: throw the die id into the entropy pool
Date: Mon, 9 Sep 2013 19:14:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1309091908270.28435@utopia.booyaka.com>
References: <1378366158-31183-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37390 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab3IITPA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Sep 2013 15:15:00 -0400
In-Reply-To: <1378366158-31183-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>

Hi Linus,

On Thu, 5 Sep 2013, Linus Walleij wrote:

> Atleast eight bytes of this number are totally unique for the device
> it seems, so this is a perfect candidate for feeding the entropy
> pool. One byte more or less of constants does not matter so feed in
> the entire OID struct.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Paul Walmsley <paul@pwsan.com>
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Heh, that function name "add_device_randomness()" is a bit misleading.  
It's not actually intended to add "randomness": from 
drivers/char/random.c:

/*
 * Add device- or boot-specific data to the input and nonblocking
 * pools to help initialize them to unique values.
 *
 * None of this adds any entropy, it is meant to avoid the
 * problem of the nonblocking pool having similar initial state
 * across largely identical devices.
 */

But of course the function name is not your fault :-)  The entropy count 
isn't increased by this, so:

Reviewed-by: Paul Walmsley <paul@pwsan.com>

Thanks Linus.


- Paul
