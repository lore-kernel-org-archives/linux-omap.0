From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Bug in linux omap clock framework?
Date: Fri, 12 Dec 2008 09:48:13 +0200
Message-ID: <1229068093.13774.0.camel@tubuntu>
References: <21FAA8D4A5AB5E4096AC4BE4BF42EB140157D444@vaebe104.NOE.Nokia.com>
	 <alpine.DEB.2.00.0812061635110.21247@utopia.booyaka.com>
	 <1228726770.8668.66.camel@tubuntu>
	 <alpine.DEB.2.00.0812080218190.5902@utopia.booyaka.com>
	 <1228831086.31061.9.camel@tubuntu>
	 <87wse7rrvd.fsf@trdhcp146196.ntc.nokia.com>
	 <alpine.DEB.2.00.0812110916310.26754@utopia.booyaka.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57168 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbYLLHsX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Dec 2008 02:48:23 -0500
In-Reply-To: <alpine.DEB.2.00.0812110916310.26754@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: =?ISO-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

On Thu, 2008-12-11 at 09:17 -0700, ext Paul Walmsley wrote:
> Hi Jouni, Tomi,=20
>=20
> On Thu, 11 Dec 2008, H=F6gander Jouni wrote:
>=20
> > So it seems that cm_* register should not be written while there is
> > powerstate transition ongoing in * domain. Patch by Tomi is fixing
> > this. As it seems to be transition related rather than pwrdm state,
> > same line should be added into omap2_clkdm_clk_disable also.
>=20
> Shouldn't this have also crashed the system if it needed to be done=20
> in omap2_clkdm_clk_disable() ?  Perhaps we should avoid adding it the=
re=20
> until we can reproduce a crash there?
>=20

Yep, I haven't seen a crash related to disabling the clock. So perhaps
it's better to just wait in enable for now. I'll resend the patch I sen=
t
earlier.

 Tomi


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
