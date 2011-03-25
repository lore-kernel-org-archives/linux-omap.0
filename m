From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP: iovmm: fix SW flags passed by user
Date: Fri, 25 Mar 2011 20:05:57 +0000
Message-ID: <20110325200557.GA14228@n2100.arm.linux.org.uk>
References: <1301071572-25251-1-git-send-email-omar.ramirez@ti.com> <4D8CD126.6000405@ru.mvista.com> <AANLkTikV37gmmf5sRQ98EzOL6K7JNvDy9gfCWbR=747k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47054 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924Ab1CYUGY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 16:06:24 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikV37gmmf5sRQ98EzOL6K7JNvDy9gfCWbR=747k@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Tony Lindgren <tony@atomide.com>, l-o <linux-omap@vger.kernel.org>, David Cohen <dacohen@gmail.com>, lak <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 25, 2011 at 12:36:57PM -0500, Ramirez Luna, Omar wrote:
> On Fri, Mar 25, 2011 at 12:30 PM, Sergei Shtylyov <sshtylyov@mvista.c=
om> wrote:
> > Hello.
> >
> > Omar Ramirez Luna wrote:
> >
> >> Commit d038aee24dcd changes iovmm to receive flags specified by us=
er,
> >
> > =A0 Please also specify that commit's summary for the human readers=
=2E Bare ID
> > is only usable to gitweb...
>=20
> Here it is the patch, introducing the change:
>=20
> https://patchwork.kernel.org/patch/620871/
>=20
> If accepted by Hiroshi, I can update the description making reference
> to this patch instead of commit.

It is a requirement that all descriptions which refer to a commit shall
contain both the commit ID *and* the summary line for that commit.
=46ailure to ensure that's the case results in rejection of the patch
until it conforms.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
