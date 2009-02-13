From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/1] Group and resource assignments for TWL4030
Date: Fri, 13 Feb 2009 12:55:21 -0800
Message-ID: <200902131255.21379.david-b@pacbell.net>
References: <1234271495-11705-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:30755 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752996AbZBMUzX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2009 15:55:23 -0500
In-Reply-To: <1234271495-11705-1-git-send-email-peter.de-schrijver@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 10 February 2009, Peter 'p2' De Schrijver wrote:
> 
> This patch introduces support for board specific group assignments of TWL4030
> resources. The resource type and type2 fields can also be specified.

Do we have any real examples yet of needing to assign
resources to anything other than P1 (processor)?

I'd sort of like to stick to simplifying assumptions,
notably "only P1 matters", until we have a clear need
to switch to another one.

This sort of thing ties into some patches I have
floating around, to disable regulators turned on
inappropriately by the boot loader.  I was doing
that in a late_initcall in the regulator driver ...
but it's a bit messy, as the regulator framework
has deficiencies in that area (too).

- dave
