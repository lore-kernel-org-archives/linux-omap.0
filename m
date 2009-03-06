From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] regulator: twl4030 VAUX3 supports 3.0V
Date: Fri, 6 Mar 2009 14:48:43 -0800
Message-ID: <200903061448.43749.david-b@pacbell.net>
References: <49B11EB0.30809@nokia.com> <200903061116.21544.david-b@pacbell.net> <20090306221842.GB15728@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:24359 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752338AbZCFWsq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2009 17:48:46 -0500
In-Reply-To: <20090306221842.GB15728@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, lrg@slimlogic.co.uk, LKML <linux-kernel@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>

On Friday 06 March 2009, Mark Brown wrote:
> Would it make sense to make this platform data so that if a given board
> requires running the chip like this it can be enabled for those boards
> but it's not something people might turn on because it seems useful?

Let's hear if it's actually needed, first.  :)

I coded those tables so that it would be easy to kick in the
support for out-of-spec operation if it's really needed.  But
so far we don't know that it's needed, and I'd rather it not
be too easy to run like that.

- Dave


