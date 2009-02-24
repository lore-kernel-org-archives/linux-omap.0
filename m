From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc3-git 1/2] regulator: twl4030 regulators
Date: Mon, 23 Feb 2009 18:03:49 -0800
Message-ID: <200902231803.50059.david-b@pacbell.net>
References: <200902081037.06645.david-b@pacbell.net> <200902231443.16334.david-b@pacbell.net> <20090224005536.GC3601@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:48027 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754950AbZBXCDx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2009 21:03:53 -0500
In-Reply-To: <20090224005536.GC3601@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Monday 23 February 2009, Mark Brown wrote:
> The change to add voltage range constraints if none were supplied is a
> noticable policy change from the existing framework standard - it allows
> machines to enable voltage changes without specifying what the valid
> values are. 

"Whatever the hardware handles" *is* a specification.

And there's no more assurance it's right than any
other specification would be ... except that, as a
rule, hardware designers like to avoid assemblies
subject to trivial misconfiguration mistakes (like
firing up a 2.5V-max rail at 5V).


> I'm not convinced that this is a good idea in the first 
> place and it will result in the opposite behaviour to the current core
> code (which should end up erroring out in constraint checking at runtime).

Well, if you really dislike it so much, that can
easily be removed.  Got any comments on the
framework patch I sent?  I'll take that as the
first one, even though it's a different thread.

- Dave



