From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] ARM: OMAP: Update PRCM rate-table entries for 2430
Date: Tue, 30 Oct 2007 14:50:18 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429025C0596@dlee13.ent.ti.com>
References: <20071030113449.099074338@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <20071030113449.099074338@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> On Behalf Of Kevin Hilman
> Sent: Tuesday, October 30, 2007 6:35 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: [PATCH] ARM: OMAP: Update PRCM rate-table entries for 2430
>=20
> [resend with minor build fix and updated description]
>=20
> Follow the lead of the TI kernels by removing PRCM #2 and adding PRCM
> #3 and #4 to the rate-table entries.  According to TI, having #2 and
> #3 together is known to be a bad combination.
>=20
> Also, change the default divider values for the PRCM #5a setting to
> match those of the TI kernel.  Using the smallest divider possible can
> give significant power savings when using the data-driven idle modes.
>=20
> Signed-off-by: Kevin Hilman <khilman@mvista.com>

Using the lowest N value gives the best power savings.  It might be we =
need to think a bit on how better to sort table rates.  The MPU index is =
not unique enough.  Could be per-board or something more cleaver.

Acked-by: Richard Woodruff <r-woodruff2@ti.com>
