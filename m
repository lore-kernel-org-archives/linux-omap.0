From: Tony Lindgren <tony@atomide.com>
Subject: Re: AM335x: Beaglebone stops to boot with current git kernel
Date: Wed, 14 Nov 2012 09:51:49 -0800
Message-ID: <20121114175149.GT6801@atomide.com>
References: <k80da6$61d$1@ger.gmane.org>
 <CAORVsuV7y_A4m+pHPoQ9a=Q7b4j-fCutJAFA1L+bqp4BV3kmFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:57504 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423120Ab2KNRvw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 12:51:52 -0500
Content-Disposition: inline
In-Reply-To: <CAORVsuV7y_A4m+pHPoQ9a=Q7b4j-fCutJAFA1L+bqp4BV3kmFg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: i.mazanov@gmail.com, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org

* Jean Pihet <jean.pihet@newoldbits.com> [121114 08:43]:
> 
> The patch should change the name of the hwmod entry as well, can you
> fold this change in the current patch?

This was caused by the merge of omap-for-v3.8/pm into omap-for-v3.8/clock.
I noticed a smilar issue for omap3, but missed at least this one.

Jean, can you please check omap-for-v3.8/clock for the smartreflex
clock names in case there are more issues like this remaining?

Regards,

Tony
