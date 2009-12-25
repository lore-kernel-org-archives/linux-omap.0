From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: clk2xxx.c doesn't compile if CPUFREQ is enabled
Date: Sat, 26 Dec 2009 01:38:11 +0200
Message-ID: <20091225233811.GA18606@nokia.com>
References: <1261784154-18550-1-git-send-email-felipe.balbi@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20351 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203AbZLYXji (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Dec 2009 18:39:38 -0500
Content-Disposition: inline
In-Reply-To: <1261784154-18550-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Sat, Dec 26, 2009 at 12:35:54AM +0100, Balbi Felipe (Nokia-D/Helsinki) wrote:
>Hi Paul,
>
>if we enable CPUFREQ we can't build omap2 for two reasons,
>one of them is fixed by the patch below but the other one
>it seems like it'll need more invasive changes to the code
>so I'll leave it for you to decide how to do it.
>
>It's basically failing because the __musb_be_array() check

oops, it comes out naturally. Should be __must_be_array() hehe.

-- 
balbi
