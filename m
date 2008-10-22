From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] alsa: add beagleboard SoC configuration.
Date: Wed, 22 Oct 2008 12:09:27 -0700
Message-ID: <200810221209.28194.david-b@pacbell.net>
References: <1224692929-15108-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:29545 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752918AbYJVTJa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2008 15:09:30 -0400
In-Reply-To: <1224692929-15108-1-git-send-email-felipe.contreras@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org

On Wednesday 22 October 2008, Felipe Contreras wrote:
> +
> +=A0=A0=A0=A0=A0=A0=A0printk(KERN_INFO "OMAP3 Beagle SoC init\n");
> +=A0=A0=A0=A0=A0=A0=A0if (!machine_is_omap3_beagle()) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0printk(KERN_ERR "Not OM=
AP3 Beagle!\n");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENODEV;
> +=A0=A0=A0=A0=A0=A0=A0}
> +

Note that the version I (re)posted fixed the bogus messaging
on non-Beagle boards.  Move that KERN_INFO after the "if ...)".
And for that matter, the KERN_ERR isn't really an error; it's
quite legit to have a kernel support e.g. both Overo and Beagle.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
