From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: omap clock.h question
Date: Tue, 7 Feb 2006 16:06:12 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A504365B3D@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> I believe he meant just to hide the clock number for mmc 1 or 2. But I
> guess we still need to have different naming for omap1 and omap2.

Like I was saying you could hide both the slot and the names.

 for(i=3Ddata.slot[slot].num_clks; i>0; i--)
 {
	ck =3D clk_get(data.slot.clk_name[i-1])
	if(ck !=3D NULL)
	clk_enabl(ck);
 }

That way we don't care the name or how many.  It gets rid of some if
statements anyway.

Regards,
Richard W.
