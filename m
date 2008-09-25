From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [Resend] [PATCH 1/3] Add MCSPI1 and gpio_85 Mux configuration
Date: Thu, 25 Sep 2008 08:53:28 +0300
Message-ID: <20080925085328.62009bf3.jarkko.nikula@nokia.com>
References: <dfeb90390809242234h2264c7acw3003d6895574f002@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22570 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197AbYIYFyA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 01:54:00 -0400
In-Reply-To: <dfeb90390809242234h2264c7acw3003d6895574f002@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Arun KS <arunks@mistralsolutions.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 25 Sep 2008 11:04:07 +0530
"ext Arun KS" <arunks@mistralsolutions.com> wrote:

> This patch adds mcspi1 and gpio_85 mux configuration for 2430.
> 
> Signed-off-by: Arun KS <arunks@mistralsolutions.com>
> ---
>  arch/arm/mach-omap2/mux.c             |   10 ++++++++++
>  arch/arm/plat-omap/include/mach/mux.h |    9 +++++++++
>  2 files changed, 19 insertions(+), 0 deletions(-)
> 
How about adding muxing for remaining 2430 McBSP ports 3-5 as well in
this patch?


Jarkko
