From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH]  OMAP: McBSP: Drop unnecessary status/error bit
 clearing on reg_cache retrieved register values
Date: Thu, 4 Mar 2010 08:49:57 +0200
Message-ID: <20100304084957.28c2a9c9.jhnikula@gmail.com>
References: <201002231650.40351.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:62732 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab0CDGtK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Mar 2010 01:49:10 -0500
Received: by ewy20 with SMTP id 20so1518810ewy.21
        for <linux-omap@vger.kernel.org>; Wed, 03 Mar 2010 22:49:09 -0800 (PST)
In-Reply-To: <201002231650.40351.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Tue, 23 Feb 2010 16:50:38 +0100
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> The MsBSP register cache will never have any error/status flags set, since 
> these flags are never written to the reg_cache. So it is kind of not 
> necessary to clear these flags, which are actually always 0.
> 
> In other words, clearing the status/error flags are not necessary, since the 
> reg_cache will never got these bits set. We can just write back the 
> register content from the cache as it is when clearing an error condition.
> 
> Created against l-o for-next commit 62a7c2cc4c8e57e80ccf379536f362fe6e863ac3
> dated 2010-02-22.
> Tested on Amstrad Delta.
> 
> Reported-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> 
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
