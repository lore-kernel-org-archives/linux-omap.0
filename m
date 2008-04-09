From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [PATCH 1/5] I2C: LM8323: Introduce lm8323 keypad driver
Date: Wed, 9 Apr 2008 14:33:56 +0300
Message-ID: <a0580c510804090433u7ee5cd9fn8f3dcb40fdfb8cc4@mail.gmail.com>
References: <1207735765-1356-1-git-send-email-felipe.balbi@nokia.com>
	 <1207735765-1356-2-git-send-email-felipe.balbi@nokia.com>
	 <a0580c510804090354m1c01cd60h86d1664390e0606d@mail.gmail.com>
	 <20080409110256.GA23681@intune.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:30868 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbYDILd5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 07:33:57 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2149052wah.23
        for <linux-omap@vger.kernel.org>; Wed, 09 Apr 2008 04:33:56 -0700 (PDT)
In-Reply-To: <20080409110256.GA23681@intune.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Stone <daniel.stone@nokia.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi Daniel,

On Wed, Apr 9, 2008 at 2:02 PM, Daniel Stone <daniel.stone@nokia.com> wrote:
> Hi,
>
>
>  On Wed, Apr 09, 2008 at 01:54:16PM +0300, ext Eduardo Valentin wrote:
>  > ERROR: do not initialise statics to 0 or NULL
>
> > WARNING: braces {} are not necessary for single statement blocks
>
>  Yeah, these should be fixed.
>
>
>  > WARNING: consider using strict_strtoul in preference to simple_strtoul
>  > WARNING: consider using strict_strtoul in preference to simple_strtoul
>
>  I don't even know what strict_strtoul is, but okay.
>
>
>  > WARNING: line over 80 characters
>
> > WARNING: do not add new typedefs
>
>  Sure.
>
>
>  > daniel.diff has style problems, please review.  If any of these errors
>  > are false positives report them to the maintainer, see
>  > CHECKPATCH in MAINTAINERS.
>  >
>  >
>  > I'd suggest using some #defines for lots for magic numbers in this code.
>
>  'lots'? The only ones I can see are the magic constant needed for reset
>  (used in one place and commented), and the default/max values for
>  debounce/active time, and max x/y, both of which are again only used in
>  a single place.

That's true. But, IMHO they still make the code difficult to read.

>
>  Cheers,
>  Daniel
>
> -----BEGIN PGP SIGNATURE-----
>  Version: GnuPG v1.4.6 (GNU/Linux)
>
>  iD8DBQFH/KJg68xJuWtYYdURAlUQAKCGvDHvm1DvmmIavnztgedxQj8pfACfVaEJ
>  GMOOUOVCzTEm7ULxwz5PE/Q=
>  =U9pC
>  -----END PGP SIGNATURE-----
>
>



-- 
Eduardo Bezerra Valentin
