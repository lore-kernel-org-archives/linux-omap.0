From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 2/6] ARM: OMAP4 PM: Add IO Daisychain support
Date: Tue, 28 Feb 2012 03:33:47 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202280332460.11716@utopia.booyaka.com>
References: <1330096546-20477-1-git-send-email-t-kristo@ti.com> <1330096546-20477-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49281 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964836Ab2B1Kds (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 05:33:48 -0500
In-Reply-To: <1330096546-20477-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

Hi 

a minor comment

On Fri, 24 Feb 2012, Tero Kristo wrote:

>  
> +/**
> + * Maximum time(us) it takes to output the signal WUCLKOUT of the last pad of
> + * the I/O ring after asserting WUCLKIN high
> + */

This is not a kerneldoc comment, so it's best not to use a double asterisk 
on the start line.


- Paul
