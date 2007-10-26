From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: oprofile on OMAP2: ARM11 PMU interrupts?
Date: Fri, 26 Oct 2007 15:53:10 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742902530AF3@dlee13.ent.ti.com>
References: <472225F6.9070502@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <472225F6.9070502@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>, Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Kevin,

Yes, several people are using it locally on SDP2430 for measurements.  =
It is pretty neat.

Yes IRQ3 is correct I believe.

There is a patch around which makes it work on ML4.1 which someone did a =
while back.  Last comment I saw was Russell's base patch had a few =
mistakes when needed fixing.

I'll take a look for the path and send you a copy.  Perhaps you can push =
out fixes as your currently interested.

Regards,
Richard W.

> Is anyone using oprofile on OMAP2?
>=20
> A quick test of the current code in current git doesn't seem to work.  =
I
> see the PMU being configured, IRQ3 being registered but no interrupts
> ever fire on that IRQ, and thus no data is collected.
>=20
> I tested on a 2420/H4 and 2430SDP with same results.  In both cases, =
the
> IRQ is configured to IRQ3, which in the TRM says 'BENCH MPU =
emulation'.
>  I have no idea what that means, but it doesn't sound like the ARM11 =
PMU
> interrupt to me though.
>=20
> Any ideas?
>=20
> Kevin
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
