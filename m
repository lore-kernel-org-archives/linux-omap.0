From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Das u-boot : relocation truncated to fit: R_ARM_PLT32 __div0
Date: Mon, 30 Jul 2007 06:43:00 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290182BDD7@dlee13.ent.ti.com>
References: <3B6D69C3A9EBCA4BA5DA60D9130274290182BD1F@dlee13.ent.ti.com>
	<BAY141-F2704C56A3D1CFA10479B9FBDED0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <BAY141-F2704C56A3D1CFA10479B9FBDED0@phx.gbl>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Farhad Rahimi <frk85@hotmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

=20

That is good.  Hope it will boot.

=20

Which chip are you compiling for anyway?  Seems like you need to compile =
for at least ARMv5 (something which supports the bx instruction) to get =
the warnings away in the configuration they provide.

=20

Regards,

Richard W.

=20

________________________________

From: Farhad Rahimi [mailto:frk85@hotmail.com]=20
Sent: Sunday, July 29, 2007 12:32 PM
To: Woodruff, Richard; linux-omap-open-source@linux.omap.com
Subject: RE: Das u-boot : relocation truncated to fit: R_ARM_PLT32 =
__div0

=20

Hi Richard,

I found it, it was in the Makefile, under ARM ARCH, I was grep the whole =
"arm-linux-gcc", which I should only search for "arm-linux-".

PS, why  there are so much warning, that "target CPU does not suppost =
interworking" ?

Regards

Farhad



=09
________________________________


	From:  "Woodruff, Richard" <r-woodruff2@ti.com>
	To:  "Farhad Rahimi" <frk85@hotmail.com>, =
<linux-omap-open-source@linux.omap.com>
	Subject:  RE: Das u-boot : relocation truncated to fit: R_ARM_PLT32 =
__div0
	Date:  Sun, 29 Jul 2007 11:04:24 -0500
	>There are 2 fixes for this.
	>
	>Early GCC3.4 had a bug which the patch you are looking at is for
	>(patching and rebuilding your tool chain).  Next you can build u-boot
	>with out issue.
	>
	>Later GCC version fixes this so no patch should be necessary.
	>
	>It seems like the very latest u-boot sources may not have this issue =
as
	>someone had went though code and change function usage to try and =
avoid
	>functions which result in this.  The ports likely haven't been =
refreshed
	>to make use of this.  Using a CodeSourcry tool chain direcly is likely
	>the easiest thing to do.
	>
	>Regards,
	>Richard W.
	>
	> > -----Original Message-----
	> > From: linux-omap-open-source-bounces@linux.omap.com
	>[mailto:linux-omap-
	> > open-source-bounces@linux.omap.com] On Behalf Of Farhad Rahimi
	> > Sent: Sunday, July 29, 2007 4:01 AM
	> > To: linux-omap-open-source@linux.omap.com
	> > Subject: Das u-boot : relocation truncated to fit: R_ARM_PLT32 =
__div0
	> >
	> >
	> > _______________________________________________
	> > Linux-omap-open-source mailing list
	> > Linux-omap-open-source@linux.omap.com
	> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source




________________________________

Ta' p=E5 udsalg =E5ret rundt p=E5 MSN Shopping =
<http://g.msn.com/8HMAENDK/2755??PS=3D47575> hvor du altid finder de =
bedste priser
