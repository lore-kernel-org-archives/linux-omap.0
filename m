From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 2/2] 3430 clock: add emulation clocks
Date: Thu, 8 Nov 2007 18:21:26 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290272C997@dlee13.ent.ti.com>
References: <20071105082406.387923286@pwsan.com>
	<20071105082528.483327389@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429026298DF@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0711060252540.25907@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <Pine.LNX.4.64.0711060252540.25907@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

 > > > Add clocks for the EMU domain for OMAP3430.  These clocks are not
> > > well-documented in the TRM, beyond register bit settings.  Some
> > > information is available in the ARM Cortex-A8 TRM, section 10.1.  =
Also
> > > rename existing emul_* clocks to emu_* to conform with recent =
TRMs.
> >
> > There are TRM addendums for emulations which have much more =
information.
> > You at times need more than the base TRM these days.  There are =
probably
> > a couple thousand more pages removed :) You wouldn't want to have =
too
> > big of TRM, 43Meg is just the right size.
>=20
> Ok, thanks.  Are you referring to the Emulation TRM, or are there =
other
> TRMs related to emulation that include this information?  Let me know =
and
> I will repost the patches with an updated commit-msg pointing people
> there.

Yes Emulation TRM is one.  There are also stacked and security ones.  =
Looking about there are also some other emulation related ones (spru893, =
spru928).  ARM Ltd also has a document set relating to their IP in use =
(coresight, etm, arm debug v5 architecture).

Regards,
Richard W.
