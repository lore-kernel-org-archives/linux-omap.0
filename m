From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] alsa: add beagleboard SoC configuration.
Date: Fri, 24 Oct 2008 12:03:38 -0700
Message-ID: <20081024190338.GE16354@atomide.com>
References: <1224692929-15108-1-git-send-email-felipe.contreras@gmail.com> <200810221209.28194.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57755 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbYJXTDm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Oct 2008 15:03:42 -0400
Content-Disposition: inline
In-Reply-To: <200810221209.28194.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081022 12:14]:
> On Wednesday 22 October 2008, Felipe Contreras wrote:
> > +
> > +=A0=A0=A0=A0=A0=A0=A0printk(KERN_INFO "OMAP3 Beagle SoC init\n");
> > +=A0=A0=A0=A0=A0=A0=A0if (!machine_is_omap3_beagle()) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0printk(KERN_ERR "Not =
OMAP3 Beagle!\n");
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENODEV;
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +
>=20
> Note that the version I (re)posted fixed the bogus messaging
> on non-Beagle boards.  Move that KERN_INFO after the "if ...)".
> And for that matter, the KERN_ERR isn't really an error; it's
> quite legit to have a kernel support e.g. both Overo and Beagle.

OK, will push Dave's fixed version.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
