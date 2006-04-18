From: "Menon, Nishanth" <x0nishan@ti.com>
Subject: RE: segmentation fault while accessing mcbsp1 port from the ARM
Date: Tue, 18 Apr 2006 09:54:50 -0500
Message-ID: <520AB2AD990DC04082102F77CA172638032874FF@dlee03.ent.ti.com>
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
To: prafulla chandra vejendla <v.prafulla@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Two things come to mind:
1. are u using virtual address to access mcbsp? If not, use the same
(however, I remember sometime back at least, virt=3Dphy on omap1
platforms, but mebbe an ioremap was missing?).
2. mcbsp1 has a strange behavior of wanting dsp to be in idle state
before being accessible on omap1 platforms (1610,1710 had it). Check the
same out.

Regards,
Nishanth Menon

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of prafulla chandra
vejendla
> Sent: Tuesday, April 18, 2006 5:37 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: segmentation fault while accessing mcbsp1 port from the ARM
>=20
> Hi all,
> in OSK5912 board i am trying to access the McBSP port through ARM
> processor
> in which LINUX 2.6.11.3  is ported. i am  trying to access McBSP1
using
> the
> address 0xe1011806. but i am getting error as segmentation fault. why
is
> it
> so. any one come accross the problem.is there any other way to acces
the
> McBSP1 port there by AIC23  codec from the ARM processor.
> thanks in advance
> prafulla chandra
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
