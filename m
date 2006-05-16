From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: File system in flash
Date: Tue, 16 May 2006 10:18:40 -0500
Message-ID: <520AB2AD990DC04082102F77CA172638036D9CAA@dlee03.ent.ti.com>
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
To: Gururaj N <gururaj@sasken.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> How to specify for kernel bootup that filesytem resides at  specific
> flash address ?

Bootargs: e.g.:
setenv bootargs mem=3D32M console=3DttyS0,115200n8 noinitrd
root=3D/dev/mtdblock3 rootfstype=3Djffs2 devfs=3Dmount
>=20
> "SASKEN RATED Among THE Top 3 BEST COMPANIES TO WORK FOR IN INDIA -
SURVEY
> 2005 conducted by the BUSINESS TODAY - Mercer - TNS India"
>=20
>                            SASKEN BUSINESS DISCLAIMER
> This message may contain confidential, proprietary or legally
Privileged
> information. In case you are not the original intended Recipient of
the
> message, you must not, directly or indirectly, use, Disclose,
distribute,
> print, or copy any part of this message and you are requested to
delete it
> and inform the sender. Any views expressed in this message are those
of
> the individual sender unless otherwise stated. Nothing contained in
this
> message shall be construed as an offer or acceptance of any offer by
> Sasken Communication Technologies Limited ("Sasken") unless sent with
that
> express intent and with due authority of Sasken. Sasken has taken
enough
> precautions to prevent the spread of viruses. However the company
accepts
> no liability for any damage caused by any virus transmitted by this
email


This is a bad disclaimer to send to an opensource list.. please ask your
mail admin to fix this.
Regards,
Nishanth Menon
