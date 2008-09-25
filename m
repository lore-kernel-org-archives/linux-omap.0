From: David Brownell <david-b@pacbell.net>
Subject: Re: NULL pointer dereference when using ALSA SOC
Date: Thu, 25 Sep 2008 10:22:08 -0700
Message-ID: <200809251022.08544.david-b@pacbell.net>
References: <dfeb90390809222326s44162f94sf42f96fdfc0a0690@mail.gmail.com> <01BA5FDD-AC4E-4450-B576-8A7DA867E314@student.utwente.nl> <dfeb90390809250638r22474563q1262209d15974cb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:46569 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754948AbYIYRWK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Sep 2008 13:22:10 -0400
In-Reply-To: <dfeb90390809250638r22474563q1262209d15974cb9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arun KS <getarunks@gmail.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Steve Sakoman <sakoman@gmail.com>

On Thursday 25 September 2008, Arun KS wrote:
> >>> I narrowed this into CONFIG_SLUB. When it's set, I can reproduce the
> >>> bug both with N810 and Beagle but not when using CONFIG_SLAB.

So it's confirmed that SLUB is a factor, but
the root cause is still not known or resolved?


