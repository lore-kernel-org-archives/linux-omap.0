From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/4] OMAP2: clock: clk2xxx.c doesn't compile if CPUFREQ
 is enabled
Date: Tue, 5 Jan 2010 09:03:19 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001050858280.2083@utopia.booyaka.com>
References: <20100105024113.16275.96273.stgit@localhost.localdomain> <20100105024204.16275.82098.stgit@localhost.localdomain> <20100105105150.GC11291@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41127 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624Ab0AEQDU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 11:03:20 -0500
In-Reply-To: <20100105105150.GC11291@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 5 Jan 2010, Felipe Balbi wrote:

> and you forgot to change the variable definition...

Thanks, looks like I sent an older version of the series.  I will resend.

> The variable defined is called rate but you use sys_ck_rate. I used rate,
> because that's what other functions are using and I wanted to keep the code
> consistent. 

Did you examine the other functions omap2_round_to_table_rate() and 
omap2_select_table_rate()?

What advantage is there to keeping this variable named "rate", which is 
less specific given that this function also deals with DPLL rates, MPU 
rates, and crystal rates?


- Paul
