From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v9 0/4] OMAP: McBSP: Use register cache
Date: Fri, 15 Jan 2010 09:42:42 +0200
Message-ID: <20100115094242.3e710120.jhnikula@gmail.com>
References: <201001141658.32034.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:54304 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415Ab0AOHlb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 02:41:31 -0500
Received: by ewy1 with SMTP id 1so510014ewy.28
        for <linux-omap@vger.kernel.org>; Thu, 14 Jan 2010 23:41:30 -0800 (PST)
In-Reply-To: <201001141658.32034.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-omap@vger.kernel.org

On Thu, 14 Jan 2010 16:58:29 +0100
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> Change the way McBSP registers are maintained: store values written to the
> device in a cache in order to make use of those cached values when
> convenient.
> 
> This could help for developing the McBSP context save/restore features, as
> well as solve the problem of possible register corruption, experienced on
> OMAP1510 based Amstrad Delta board at least.
> 
Looks good. I tested the set by running following loop for some time on
BeagleBoard without any problems:

while [ 1 ]; do (arecord -f dat -d 3 |aplay); sleep 7; done

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
