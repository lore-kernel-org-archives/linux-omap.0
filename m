From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: TV-out problem
Date: Wed, 18 Apr 2007 06:50:06 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4708106D@dlee13.ent.ti.com>
References: <BAY111-F32222F07E9CCD50C787685A6500@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Hades Liu <lcc0917@msn.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Which code base are you using?=20
=20
Try the one on linux.omap.com =
:http://linux.omap.com/pub/kernel/2430sdp/source/=20
linux-2.6.14-omap2420-omap2430.tgz =
<https://webmail.ti.com/exchange/x0khasim/Drafts/RE:%20TV-out%20problem.E=
ML/linux-2.6.14-omap2420-omap2430.tgz>=20
=20
Boot the system, then do a=20
echo "tv" > /sys/class/omap_disp/display_control/graphics, You should =
see the penguin on TV out.
=20
You can use either projector or TV. Makesure the projector is set to =
NTSC input (if such configuration is available in your projector).
=20
Regards,
Khasim=20
________________________________

From: linux-omap-open-source-bounces@linux.omap.com on behalf of Hades =
Liu
Sent: Wed 4/18/2007 6:03 AM
To: linux-omap-open-source@linux.omap.com
Subject: TV-out problem



Hi all,
I am trying the tv-out feature of omap2430.

I had output the displaying graphic to tv-out target, but the output =
image
is not correct. My original display is to show a linux penguin at =
left-top
of displaying. But when output to tv-out, it became foggy and many =
penguins
at the left-top, middle-left-top, middle-right-top, and right-top of
displaying.

What will cause this problem? I used a projector to be the tv-out =
target,
does the projector cause the result?


Thank you.

Best Regards
Hades

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE!
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
