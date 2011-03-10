From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2] omap2/3: dmtimer: Enable autoidle
Date: Thu, 10 Mar 2011 03:21:29 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103100320590.15132@utopia.booyaka.com>
References: <1297787428-5717-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36753 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab1CJKVa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 05:21:30 -0500
In-Reply-To: <1297787428-5717-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 15 Feb 2011, Tero Kristo wrote:

> This saves some power. OMAP4 version should check for GPT module ID, as
> autoidle is only supported on a subset of these.
> 
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Thanks, queued for 2.6.39 since it looks like these won't be converted to 
hwmod in time for 2.6.39.


- Paul
