From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] twl4030-core: fix a typo
Date: Thu, 9 Oct 2008 13:03:20 -0700
Message-ID: <200810091303.21099.david-b@pacbell.net>
References: <EAF47CD23C76F840A9E7FCE10091EFAB028C6305D0@dbde02.ent.ti.com> <20081009160713.GA12091@frodo> <FCCFB4CDC6E5564B9182F639FC356087023958D5DE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:31241 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751416AbYJIUDX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 16:03:23 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087023958D5DE@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

On Thursday 09 October 2008, Pandita, Vikram wrote:
> 
> >To: Pakaravoor, Jagadeesh
> >On Thu, Oct 09, 2008 at 08:44:49PM +0530, Pakaravoor, Jagadeesh wrote:
> >> From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> >>
> >> Fix a trivial typo.
> >
> >please Cc Samuel Ortiz <sameo@openedhand.com> and lkml
> 
> Samuel already fixed this. 
> 	http://lkml.org/lkml/2008/10/8/166

Right, but we won't see such fixes until around 2.6.28-rc1-omap1,
which is probably 2-3 weeks away.  Meanwhile, it's important not
to diverge from mainline here ... so CC'ing Sam (MFD maintainer)
is "better safe than sorry".

- Dave
