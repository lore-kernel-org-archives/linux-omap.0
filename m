From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v9 0/4] OMAP: McBSP: Use register cache
Date: Wed, 3 Feb 2010 11:49:10 -0800
Message-ID: <20100203194910.GI22747@atomide.com>
References: <201001141658.32034.jkrzyszt@tis.icnet.pl>
 <201001181007.36436.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64633 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289Ab0BCTsx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 14:48:53 -0500
Content-Disposition: inline
In-Reply-To: <201001181007.36436.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Jarkko Nikula <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Peter Ujfalusi <peter.ujfalusi@nokia.com> [100118 00:05]:
> Hello,
> 
> On Thursday 14 January 2010 17:58:29 ext Janusz Krzysztofik wrote:
> > Change the way McBSP registers are maintained: store values written to the
> > device in a cache in order to make use of those cached values when
> > convenient.
> > 
> > This could help for developing the McBSP context save/restore features, as
> > well as solve the problem of possible register corruption, experienced on
> > OMAP1510 based Amstrad Delta board at least.
> > 
> 
> Please make a followup patch for the unneeded masking of status bits as we 
> discussed regarding to patch 4.

Thanks for sorting out this issue Janusz.

I've applied this series into omap for-next with Acks from Jarkko and Peter.

Regards,

Tony
