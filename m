From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: FW: [RFC][PATCH] MMC: Major restructuring and cleanup
Date: Thu, 18 Jan 2007 04:12:09 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47080FBE@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: drzeus-list@drzeus.cx
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Pierre,
=20
> I guess what we lose by not supporting these is 8 bit data bus, but as
> we do not currently have a controller for that I think the point is =
moot.
=20
TI's OMAP3430 MMC controller does support 8 bit data bus. Its a =
different story that we dont have a public TRM for 3430 now :(
=20
Regards,
Khasim=20

________________________________

From: linux-arm-kernel-bounces@lists.arm.linux.org.uk on behalf of =
Pierre Ossman
Sent: Sun 1/14/2007 7:06 AM
To: Philip Langdale
Cc: LAK; LKML
Subject: Re: [RFC][PATCH] MMC: Major restructuring and cleanup



Philip Langdale wrote:
> So, I think I'm a bit too much of a kernel newbie to be able to =
provide a
> definitive review, but I've looked over the changes and they look good =
to me.
> =20

Good to hear. I'd like to get this in ASAP, but in order to make sure
everyone gets a look at it, it'll have to go a round in -mm during the
next kernel.

> I fully agree with the rearchitecturing - it makes it a lot easier to =
see
> what's going on and it'll scale for SDIO (as you mention) and CE-ATA =
as well,
> if we ever get a hold of any of those :-)
> =20

With the very generous help of John Gilmore, I think we'll have those
sorted out in a jiffy. :)

> One concrete observation I'd make is that we should probably try and =
detect
> MMC first instead of SD. Up until today, I'd have said it didn't =
really
> matter, but I've been doing some reading and discovered that Protec =
make
> some very strange cards they call "SuperSD" which can talk mmc4 and sd =
1.1.
> These will happily go along with either initialisation sequence - and =
as mmc4
> is either the same or better than sd 1.1 from a performance point of =
view,
> we should prefer it. This is independent of your restructuring, but as =
you're
> fiddling with this code... :-)
> =20

Eeeeww... This is a problem as the SD spec. clearly states the order of
init commands. So I wouldn't be surprised if we find SD cards that choke
on the MMC init sequence.

I guess what we lose by not supporting these is 8 bit data bus, but as
we do not currently have a controller for that I think the point is =
moot.

Rgds

--
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org =
<http://www.kernel.org/>=20
  PulseAudio, core developer          http://pulseaudio.org =
<http://pulseaudio.org/>=20
  rdesktop, core developer          http://www.rdesktop.org =
<http://www.rdesktop.org/>=20


-------------------------------------------------------------------
List admin: =
http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
