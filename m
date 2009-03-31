From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] regulator: twl4030 VAUX3 supports 3.0V
Date: Tue, 31 Mar 2009 11:43:00 +0100
Message-ID: <1238496180.12172.0.camel@vega.slimlogic.co.uk>
References: <49B11EB0.30809@nokia.com>
	 <1237290190.6781.313.camel@vega.slimlogic.co.uk>
	 <49C9EB17.2020408@nokia.com> <200903251003.29340.david-b@pacbell.net>
	 <49CB8F5A.4030400@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from slimlogic.co.uk ([89.16.172.20]:45845 "EHLO slimlogic.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750695AbZCaKnH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Mar 2009 06:43:07 -0400
In-Reply-To: <49CB8F5A.4030400@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: David Brownell <david-b@pacbell.net>, Mark Brown <broonie@sirena.org.uk>, LKML <linux-kernel@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>

On Thu, 2009-03-26 at 16:21 +0200, Adrian Hunter wrote:
> >From 51f946af56a5de9c25b2eb6e6a33660283f84195 Mon Sep 17 00:00:00 2001
> From: Adrian Hunter <adrian.hunter@nokia.com>
> Date: Fri, 6 Mar 2009 14:51:30 +0200
> Subject: [PATCH] regulator: twl4030 VAUX3 supports 3.0V
> 
> TWL4030 and TWL5030 support 3.0V on VAUX3.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
>  drivers/regulator/twl4030-regulator.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)

Applied.

Thanks

Liam

