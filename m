From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: new PRCM breakage: 2430 FB
Date: Tue, 12 Jun 2007 10:14:35 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470117CDC1@dlee13.ent.ti.com>
References: <3B6D69C3A9EBCA4BA5DA60D913027429012C43D6@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429012C43D6@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@mvista.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


>The 2420 usually gives something like that for DSS.
>
>If you just look at the IDLST bit it won't show accessible.  The DSS is
>supposed to be a combination initiator/target.  However the target side =
is
>not internally hooked up.
>
>The status bit won't show proper status unless the DSS initiator is out =
of
>mute.  I've found a write to the OCP wrapper will result in it coming =
to
>life.  This was one of the exceptions when compared to other modules.
>There is a deterministic wait time which can be applied after turning =
on
>clocks.
>
>Generally, after sleep you apply this, and then do the write to wake.  =
If
>you do a read you will get an abort.
>

I gave a quick try with 2420 and it works fine. We might have to work on =
Richard's suggestions for 2430 DSS Clock logic.=20

Regards,
Khasim
