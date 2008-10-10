From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/7] Hook twl4030 power code into twl4030 core.
Date: Fri, 10 Oct 2008 10:57:01 -0700
Message-ID: <200810101057.01845.david-b@pacbell.net>
References: <1223657776-16544-1-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-4-git-send-email-peter.de-schrijver@nokia.com> <1223657776-16544-5-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:22159 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1762125AbYJJR5E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2008 13:57:04 -0400
In-Reply-To: <1223657776-16544-5-git-send-email-peter.de-schrijver@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Friday 10 October 2008, Peter 'p2' De Schrijver wrote:
> +#ifdef CONFIG_TWL4030_POWER

Nothing in your patches seems to set that... or update
the Makefile so that this file gets linked.

Wouldn't it be simpler to just not have that #ifdef,
and always link it?  If there's no script to install,
no problem; I'll not worry about some __init code.

- Dave

