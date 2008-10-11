From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/7] Remove existing twl4030 power script code.
Date: Sat, 11 Oct 2008 21:45:01 +0300
Message-ID: <20081011184459.GA20247@frodo>
References: <1223657776-16544-1-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-2-git-send-email-peter.de-schrijver@nokia.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:32781 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbYJKSpJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 11 Oct 2008 14:45:09 -0400
Content-Disposition: inline
In-Reply-To: <1223657776-16544-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Fri, Oct 10, 2008 at 07:56:10PM +0300, Peter 'p2' De Schrijver wrote:
> First we remove the existing twl4030 power sequencer code.
> 
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
>  drivers/i2c/chips/twl4030-power.c |  343 -------------------------------------

Missed Makefile changes. Will break tree compilation.

-- 
balbi
