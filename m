From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] ARM: OMAP: CLKFW: Initial debugfs support for omap clock framework
Date: Thu, 17 Apr 2008 14:22:26 -0700
Message-ID: <200804171422.26994.david-b@pacbell.net>
References: <alpine.DEB.1.00.0804170952270.3689@utopia.booyaka.com> <1208461772.32060.14.camel@mort> <alpine.DEB.1.00.0804171422160.8530@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:31019 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752398AbYDQVW3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Apr 2008 17:22:29 -0400
In-Reply-To: <alpine.DEB.1.00.0804171422160.8530@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Igor Stoppa <igor.stoppa@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org

On Thursday 17 April 2008, Paul Walmsley wrote:
> >
> > Userspace should limit itself to changing policies.
>=20
> CPUFreq is good, but it does not manage non-CPU-frequency knobs very =
well,=20
> and there are plenty of those on OMAP3.

Similar issues are widely acknowledged.


> Is there any reason why we should not allow the option of userspace O=
PP=20
> selection/powerdomain control for OMAP? =A0If people don't want to us=
e it,=20
> they don't have to :-)

Sure, allow userspace controls.  Even use debugs to prototype
them.  Just don't build fragile interfaces ... don't expect
userspace code to do the equivalent of open heart surgery.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
