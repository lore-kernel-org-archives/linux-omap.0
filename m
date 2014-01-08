From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [pandaboard] audio initialization fails due to TWL6040
Date: Wed, 8 Jan 2014 15:23:09 +0200
Message-ID: <52CD513D.8010403@ti.com>
References: <529E5EC9.10008@math.uni-bielefeld.de> <20131205185349.GH26766@atomide.com> <52C12226.6010404@ti.com> <20140107225302.GC5074@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53279 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756071AbaAHNXP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Jan 2014 08:23:15 -0500
In-Reply-To: <20140107225302.GC5074@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, linux-omap@vger.kernel.org, "Kristo, Tero" <t-kristo@ti.com>

On 01/08/2014 12:53 AM, Tony Lindgren wrote:
> Well we cannot sanely deprecate the "ti,hwmods" and move on to
> matching hwmod data with DT data based on the compatible flag.
> So it's a bit of a blocker for v3.15 or so time frame.
>
>> Due to a 'hw feature' around the sidetone this is not as straight fo=
rward as
>> it sounds...
>=20
> OK. The driver(s) should still be able to coordinate things
> to sort it out hopefully?

After a quick look at the code:
- sidetone _is_ broken when we boot with DT for sure already.
- sidetone works only if we boot in legacy mode.

While it is true that ST block has it's own address space and even dedi=
cated
irq line, but..
ST can be enabled from the McBSP address space (via SSELCR_REG).
When ST is enabled we need to disable the corresponding McBSP's autoidl=
e. The
reason for this is that the ST block is clocked from the McBSP IP's int=
erface
clock. If the interface clock of the McBSP is idling there will be glit=
ches in
the sidetone generation due to not having continuously running clock fo=
r it's
internals.

=46or legacy boot we had this handled by a custom callback to disable a=
utoidle
for the McBSP when the ST starts and enable it back when ST is stopped:
arch/arm/mach-omap2/mcbsp.c:omap3_enable_st_clock() is the callback we =
call.

Normal audio will work via McBSP if we get rid of hwmod, the driver can=
 load
and operate that way. As for the sidetone functionality: it is broken w=
hen we
boot with DT and the removal of hwmod will have no effect on this.

The Sidetone address space also have sysconfig register with AUTOIDLE b=
it, but
it has no effect on the McBSP_ICLK autoidle itself.
In theory we can handle the sidetone as we do right now, but we need on=
e
thing: an API so drivers can disable/enable autoidle of an already enab=
led clock.

CCing Tero for this, he might have pointers or idea on how we can do th=
is.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
