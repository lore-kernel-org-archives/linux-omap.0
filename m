From: <Mikko.Soikkala@Tietoenator.com>
Subject: RE: [PATCH] Convert touchscreen to input_allocate_device
Date: Mon, 16 Jan 2006 13:59:35 +0200
Message-ID: <890E52023811004CB455C1B7C433BA101A8B26@dino.eu.tieto.com>
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
To: tony@atomide.com, dirk.behme@de.bosch.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi

Shouldn't there be a check after input_allocate_device() if the
allocation fails? At least other touchscreen drivers seem to return
-ENOMEM in this case.

Mikko

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Tony
Lindgren
Sent: 14. tammikuuta 2006 02:18
To: Dirk Behme
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: [PATCH] Convert touchscreen to input_allocate_device

* Dirk Behme <dirk.behme@de.bosch.com> [060106 11:36]:
> Tony Lindgren wrote:
> >Dirk, I've only pushed Todd's timer fix below like you suggested. Can
you=20
> >please
> >update your patch?
>=20
> ARM: OMAP: Convert touchscreen to input_allocate_device() to remove:
>=20
> input: device omap_ts is statically allocated, will not register
> Please convert to input_allocate_device() or contact
dtor_core@ameritech.net

Pushing this one today, thanks.

Tony
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
