From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc6 1/2] regulator: enumerate voltages (v2)
Date: Thu, 26 Feb 2009 16:10:24 -0800
Message-ID: <200902261610.24931.david-b@pacbell.net>
References: <200902081037.06645.david-b@pacbell.net> <200902261328.41910.david-b@pacbell.net> <1235685488.31223.104.camel@vega.slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n23a.bullet.mail.mud.yahoo.com ([68.142.207.189]:22189 "HELO
	n23a.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755467AbZB0AKh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2009 19:10:37 -0500
In-Reply-To: <1235685488.31223.104.camel@vega.slimlogic.co.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@sirena.org.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Thursday 26 February 2009, Liam Girdwood wrote:
> 
> > What were the conflicts -- just offsets?
> > 
> > Your "-next" regulator tree seems to be missing a doc patch
> > you had asked for, maybe that's an issue.

And you seem to only have merged the header part of
the $SUBJECT patch, not the core.c parts ...

Everything gets kind of broken without the core.c
change!

- Dave


