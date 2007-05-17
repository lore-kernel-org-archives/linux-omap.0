From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: OMAP2430: networking errors
Date: Thu, 17 May 2007 08:44:29 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429010254F3@dlee13.ent.ti.com>
References: <57314e840705170639j410cdd26s40370f492fec6f00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <57314e840705170639j410cdd26s40370f492fec6f00@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Budhee Jamaich <budheej@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> but the OMAP doesn't see the arp reply,
> and keep sending the arp who-has packets... :(
>=20
> anyone knows why this may be happening ?
> or any ideas how to debug this further ?

Is this a custom board?  What etherent chip is in use?

Does networking work at the u-boot level?

If it is using the standard etherent on SDP's I'd say the gpmc timing
was wrong on your instance.  If its not the same chip add possible
driver error.

Regards,
Richard W.
