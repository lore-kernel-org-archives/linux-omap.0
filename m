From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 0/9] ARM: OMAP2+: AM33XX: Misc fixes/updates
Date: Fri, 8 Feb 2013 14:28:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302081423030.11464@utopia.booyaka.com>
References: <1359458108-8489-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:49275 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758550Ab3BHO2h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 09:28:37 -0500
In-Reply-To: <1359458108-8489-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, khilman@deeprootsystems.com

Hi,

On Tue, 29 Jan 2013, Vaibhav Bedia wrote:

> The following patches were earlier posted as part the AM33XX
> suspend-resume support series [1]. Based on the suggestion
> from Santosh Shilimkar <santosh.shilimkar@ti.com> i have split
> out the changes which update the various data files related
> to AM33XX support.

Thanks, queued patches 1-8.  9 looks reasonable to me once documentation 
is added.  One caveat is that I'm unable to test these patches at the 
moment due to the appended DTB issue here, but they seem pretty 
straightforward.


- Paul
