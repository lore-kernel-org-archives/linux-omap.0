From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: hwmod: Print an error message if no
 match exists for a hwmod class
Date: Wed, 8 Aug 2012 08:05:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1208080803560.5447@utopia.booyaka.com>
References: <1344422117-20707-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47163 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763Ab2HHOFv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 10:05:51 -0400
In-Reply-To: <1344422117-20707-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: b-cousson@ti.com, paul@pswan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Vaibhav,

On Wed, 8 Aug 2012, Vaibhav Bedia wrote:

> If no match is found for a hwmod class, omap_hwmod_for_each_by_class()
> currently does not spit out any error messages. To make debugging
> issues related to non-existent hwmod classes simpler make this function
> print an error message in case no match is found for the supplied hwmod
> class.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

It doesn't seem to me that this would necessarily always be an error.  
Suppose some init code to create cpsw devices is running on an OMAP3430.  
Then a omap_hwmod_for_each_by_class() that doesn't locate anything 
wouldn't be an error, right?


- Paul
