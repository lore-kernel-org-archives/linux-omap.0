From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] omap2_get_clksel(): fix suspicious assignment
Date: Wed, 2 May 2007 10:53:06 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429E55242@dlee13.ent.ti.com>
References: <Pine.LNX.4.64.0705020845350.19145@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0705020845350.19145@utopia.booyaka.com>
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

 > mach-omap2/clock.c contains a suspicious assignment that=20
> almost certainly should be a equality test, in omap2_get_clksel().

Yes, its obviously wrong.  Nice to fix.

Strangely, my pre-translated trees are correct for this.  Generally,
I've tried to keep this aspect in bug fix sync.

Regards,
Richard W.
