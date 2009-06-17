From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] TWL4030: Reset header file to mainline
Date: Wed, 17 Jun 2009 07:06:48 -0700
Message-ID: <20090617140648.GT6605@atomide.com>
References: <1245238182-11697-1-git-send-email-amit.kucheria@verdurent.com> <4A38F387.1050502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49820 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060AbZFQOGs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 10:06:48 -0400
Content-Disposition: inline
In-Reply-To: <4A38F387.1050502@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: Amit Kucheria <amit.kucheria@verdurent.com>, linux-omap@vger.kernel.org

* Eugeny S. Mints <eugeny.mints@gmail.com> [090617 06:46]:
> Amit Kucheria wrote:
>> Reset twl4030.h to what is upstream. Patches to restore twl4030_power
>> functionality will follow directly to lkml.
>>
>>   
> development against upstream is great. But what will be left for
> this mail list if we send all patches directly to lkml?

Anything touching arch/arm/*omap*.

Also, while waiting things to get to mainline, we can merge in various
topic branches, such as PM, DSS2. So basically linux-omap master branch
will shortly be just a queue of things going to the mainline tree while
waiting for the next merge window.

Regards,

Tony
