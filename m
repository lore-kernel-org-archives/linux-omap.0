From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 7/7] omap3 evm, beagle and overo use the generic twl4030 script
Date: Tue, 14 Oct 2008 09:26:35 -0700
Message-ID: <200810140926.35200.david-b@pacbell.net>
References: <1223657776-16544-1-git-send-email-peter.de-schrijver@nokia.com> <200810101050.29525.david-b@pacbell.net> <20081013082345.GB4596@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:47132 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751891AbYJNQ1D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2008 12:27:03 -0400
In-Reply-To: <20081013082345.GB4596@codecarver.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

On Monday 13 October 2008, Peter 'p2' De Schrijver wrote:
> > > +extern struct twl4030_power_data generic3430_t2scripts_data;
> >=20
> > Such "extern" decls should as a rule be in header files...
> >=20
> > In this case the rule is appropriate, since you've got the
> > same decl in three different places. =A0That's about two times
> > more often than I'm comfortable making exceptions to such a
> > rule ... :)
>=20
> Please suggest an appropriate header file. I couldn't find one and
> creating a header file for a single extern declaration ?

Maybe arch/arm/mach-omap2/pm.h would be the most natural fit.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
