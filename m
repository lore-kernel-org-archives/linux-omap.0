From: Tony Lindgren <tony@atomide.com>
Subject: Re: AM335x: Beaglebone stops to boot with current git kernel
Date: Wed, 21 Nov 2012 10:38:09 -0800
Message-ID: <20121121183809.GZ18567@atomide.com>
References: <k80da6$61d$1@ger.gmane.org>
 <CAORVsuV7y_A4m+pHPoQ9a=Q7b4j-fCutJAFA1L+bqp4BV3kmFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:55994 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755579Ab2KUSiO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Nov 2012 13:38:14 -0500
Content-Disposition: inline
In-Reply-To: <CAORVsuV7y_A4m+pHPoQ9a=Q7b4j-fCutJAFA1L+bqp4BV3kmFg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: i.mazanov@gmail.com, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org

* Jean Pihet <jean.pihet@newoldbits.com> [121114 08:43]:
> On Wed, Nov 14, 2012 at 4:28 PM, Igor Mazanov <i.mazanov@gmail.com> wrote:
> >
> > Beaglebone boot process is broken with the current git kernel. I use
> > omap2plus_defconfig for tests.
> >
> > It looks like the boot process stops due to the last changes in the AM33xx
> > clock sysbsystem. A following patch resolves this issue:
...
 
> The patch should change the name of the hwmod entry as well, can you
> fold this change in the current patch?

Any news on updating this?

Regards,

Tony
