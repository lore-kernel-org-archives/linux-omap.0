From: Christopher Harvey <charvey@matrox.com>
Subject: Re: [PATCH v3] mtd: omap: nand: Remove 0xFF's that prefixed 16bit
 NAND addresses
Date: Thu, 15 Nov 2012 09:48:00 -0500
Message-ID: <20121115144800.GI2508@harvey-pc.matrox.com>
References: <20121029195127.GA32749@harvey-pc.matrox.com>
 <1352977329.2221.29.camel@sauron.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mtxmxout3.matrox.com ([138.11.2.93]:48767 "EHLO
	mtxmxout3.matrox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768068Ab2KOOsE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 09:48:04 -0500
Content-Disposition: inline
In-Reply-To: <1352977329.2221.29.camel@sauron.fi.intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: linux-mtd@lists.infradead.org, Ivan Djelic <ivan.djelic@parrot.com>, linux-omap@vger.kernel.org

On Thu, Nov 15, 2012 at 01:02:09PM +0200, Artem Bityutskiy wrote:
> On Mon, 2012-10-29 at 15:51 -0400, Christopher Harvey wrote:
> > In 16bit NAND mode the GPMC would send the address 0xNN as 0xFFNN
> > instead of 0x00NN on the bus. The 0xFFs were actually uninitialized
> > bits that were left unset in the GPMC command output register. The
> > reason they weren't initialized in 16bit mode is that if the same c=
ode
> > that writes to this register was used in 8bit mode then 2 commands
> > would be output in 8bit mode. One for the low byte, and an extra 0x=
0
> > command for the high byte. This commit uses writew if we're using
> > 16bit NAND. This commit also changes the high byte in the command
> > output register, but they are ignored by NAND chips anyway.
> >=20
> > Most chips seem fine with the extra 0xFFs, but the ONFI spec says
> > otherwise.
> >=20
> > Signed-off-by: Christopher Harvey <charvey@matrox.com>
>=20
> Pushed to l2-mtd.git, thanks!

!!! Did anybody get around to testing this? I thought this patch had
    been abandoned. Will testing get done on an omap chip now that it
    is in a tree?

I should have prefixed it with RFC.

-C

--=20

CONFIDENTIAL & WITHOUT PREJUDICE

This e-mail and any files transmitted with it, is confidential, may be
protected under NDA and/or privileged and shall be treated as
such. The e-mail and its attachments are intended only for use of the
individual(s) or entity(ies) indicated above. Any other person is
hereby advised that it strictly forbidden to disclose, distribute or
reproduce this message.  If you have received this e-mail in error,
please advise me by return e-mail or by telephone at 514-822-6000,
immediately and destroy the message and its contents immediately.
Thank You.

CONFIDENTIEL - SANS PR=C9JUDICE

Ce courriel et tout document qui y est joint, est confidentiel, peut
=EAtre privil=E9gi=E9 et prot=E9g=E9 par entente de confidentialit=E9 e=
t est =E0
l'usage exclusif du destinataire. Toute autre personne est par les
pr=E9sentes avis=E9e qu'il lui est strictement interdit de le diffuser,=
 le
distribuer ou le reproduire. Si vous recevez ce courriel par erreur,
veuillez m'en aviser imm=E9diatement, par retour de courriel ou par
t=E9l=E9phone au (514) 822-6000 et d=E9truire ce message et toute copie=
 de
celui-ci imm=E9diatement.  Merci.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
