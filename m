From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 1/4] OMAP: DMA: Cleanup of DMA Request Lines
Date: Thu, 15 Nov 2007 09:34:28 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A08804D4067E@dbde01.ent.ti.com>
References: <20071115015708.GD6005@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20071115015708.GD6005@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Tony,

I'm sorry for the late reply. I have been on other things for a while =
and haven't re-looked at this patch yet. Will fix the ifdefs and re-send =
this patch.

@Kevin,
Thanks for the quickfix patch :)

Regards,
Anand

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]=20
> Sent: Thursday, November 15, 2007 7:27 AM
> To: Gadiyar, Anand
> Cc: linux-omap-open-source@linux.omap.com
> Subject: Re: [PATCH 1/4] OMAP: DMA: Cleanup of DMA Request Lines
>=20
> * Tony Lindgren <tony@atomide.com> [071114 17:56]:
> > * Gadiyar, Anand <gadiyar@ti.com> [071024 00:06]:
> > > From: Anand Gadiyar <gadiyar@ti.com>
> > >=20
> > > Added support for TI OMAP3430 and cleanup of DMA request lines.
> >=20
> > Thanks, I've updated it for OMAP_DMA4_OCP_SYSCONFIG and will
> > apply today.
>=20
> Oops, sorry it still has the ifdefs. Not applying it yet...
>=20
> Tony
>=20
