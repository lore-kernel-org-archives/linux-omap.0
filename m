From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP3: MMC needs CONFIG_REGULATOR{,_TWL4030} now in defconfigs
Date: Tue, 24 Mar 2009 17:30:41 -0700
Message-ID: <200903241730.41404.david-b@pacbell.net>
References: <alpine.DEB.2.00.0903241716030.9924@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:25445 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754783AbZCYAbE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Mar 2009 20:31:04 -0400
In-Reply-To: <alpine.DEB.2.00.0903241716030.9924@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 24 March 2009, Paul Walmsley wrote:
> MMC doesn't work after 3fe326511c66ab842ef0a09a1f4c564b1a8beecf unles=
s=20
> CONFIG_REGULATOR, CONFIG_REGULATOR_TWL4030 are present in the .config=
=2E =A0
> Add those in for all OMAP3 defconfigs. =A0Tested on BeagleBoard, but =
this is=20
> presumably needed for anything with MMC and TWL4030.
> =A0 =A0=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: David Brownell <david-b@pacbell.net>

Acked-by: David Brownell <dbrownell@users.sourceforge.net>

I seem to have given up on updating defconfigs, but
that doesn't mean it's not a good thing to do!

Same thing with twl4030 GPIO support, on most of those
platforms.


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
