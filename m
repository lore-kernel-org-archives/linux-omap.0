From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 0/5] SRAM patcher: patch register addresses in SRAM code
	atruntime
Date: Wed, 14 Nov 2007 13:12:00 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429027B3E1E@dlee13.ent.ti.com>
References: <20071114083010.938764990@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <20071114083010.938764990@pwsan.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Paul,

> This patches implement a different approach.  They patch in the
> correct register addresses at runtime into the SRAM, just after the
> code is copied there.  While the current code simply writes in the
> preprocessor-defined address bases, a forthcoming patch series uses
> this code to write runtime-computed address bases.

- Well that does look fine.  It kind of feels like a gratuitous cache =
range flush should be added.  But as its all data side patches it =
probably can live with out it.  The initial code copy should probably =
have this.  Caches are VIPT, which means you almost don't have to flush, =
but you still do, but it can be in a more optimal way at run time.

-*- This code as written today likely won't be used on OMAP3 anyway as =
the DVFS procedure will be different.  The SRAM code usage can be much =
smaller and should also be different.

- The OMAP2420 DVFS requirements are much more restrictive than the =
OMAP3 ones.  In OMAP3 the SDRC_ICLK method should be used for the final =
VDD2 OPP change bits.  Using an OMAP2420 method on OMAP3 will result in =
you not being about to scale during audio play back.  The latency is too =
high and you will under run your mcbsp FIFO during the pause.  I think =
N800 today is not affected here today based on some of the DSP side =
effects which require it to be running faster than needed.  Other code =
bases don't have these restrictions and the 3430 one shouldn't either.  =
If you are playing audio you only need to be at the low OPP.  Something =
else can happen and require a speed up while the audio is playing.  We =
shouldn't depend on being at the high OPP while audio is active.  To =
achieve this the low latency 3430 specific method should be used.  Later =
2430's versions can today use a similar procedure as 3430.

The aim of making it single kernel for OMAP2 to OMAP3 in this case is =
just using the SRAM function for pushing the correct SRAM routine.

Regards,
Richard W.
