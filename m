From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH 1/2] OMAP: Kill compile warnings
Date: Fri, 25 May 2007 18:25:32 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47FF0C4E@dlee13.ent.ti.com>
References: <782515bb0705251623o4810c35ap87084ee3c66d4932@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <782515bb0705251623o4810c35ap87084ee3c66d4932@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: nishanth menon <menon.nishanth@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


>That would be redundant:
>220         /* Get the debug Device */
>221         dbg_dev =3D &(pdev->dev);
>already did that for you.. only, now the messages will show
>"input:xyz.." instead of "omap_twl4030:xyz"..

OK, thanks.=20

Acked-by: x0khasim@ti.com

Regards,
Khasim
