From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] omapfb vsync support
Date: Mon, 27 Feb 2006 17:10:14 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5048ACB45@dlee02.ent.ti.com>
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
To: Brian Swetland <swetland@google.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > This will cause a VST enabled kernel to wake up for no good reason
if
> > there is no application requesting it anymore.  Someone pointed out
this
> > fact to me recently while doing power measurements.  If you have a
low
> > power screen saver mode this can mess up expected power savings.
>=20
> Hmm.  I wonder if there's some happy medium between disabling the
> interrupt every time the ioctl returns and having to close and reopen
> the driver when going into and returning from low power mode.

Two bits, one is I don't see the disable being called in the code when
you wake the process up.  I see you have the function, at interrupt wake
up time it should likely be disabled.

Second goes to your comment... One would think an application should let
go of this accounting if it doesn't need it.  Perhaps that is two
optimistic... I would think something like sending a D2/D3 message to
the driver could trigger it to lock out processes until a specified wake
up event.  The policy manager upon feeling its correct, would send such
a call to the devices, to match the wake up state.  An activity time out
like which now drives blanking might be enough to trigger the lockout,
but probably not quite enough.

Regards,
Richard W.
