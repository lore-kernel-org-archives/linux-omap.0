From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Set correct off mode polarity
Date: Mon, 21 Jul 2008 20:22:31 +0300
Message-ID: <20080721172229.GA4738@frodo>
References: <1216656125-5800-1-git-send-email-peter.de-schrijver@nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58146 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbYGURWu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2008 13:22:50 -0400
Content-Disposition: inline
In-Reply-To: <1216656125-5800-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi,

style comments inlined.

On Mon, Jul 21, 2008 at 07:02:02PM +0300, Peter 'p2' De Schrijver wrote:
> +#define OFFMODE_POL 			(1<<3)

add spaces after 1 and before 3 (1 << 3)

> -

unnecessary change ?!?

-- 
balbi
