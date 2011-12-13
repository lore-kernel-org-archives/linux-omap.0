From: Paul Walmsley <paul@pwsan.com>
Subject: Re: sys_clkout2
Date: Tue, 13 Dec 2011 15:23:35 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112131523030.12046@utopia.booyaka.com>
References: <4EE7C38D.8020501@mlbassoc.com> <alpine.DEB.2.00.1112131447230.12046@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43128 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab1LMWXh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 17:23:37 -0500
In-Reply-To: <alpine.DEB.2.00.1112131447230.12046@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: linux-omap@vger.kernel.org

Hi

one error:

On Tue, 13 Dec 2011, Paul Walmsley wrote:

> struct clk *c;
> 
> c = clk_get(dev_name(dev), "fck");

This should just be 

c = clk_get(dev, "fck");

sorry about that...
> 


- Paul
