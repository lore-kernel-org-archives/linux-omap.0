From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: TV-out problem
Date: Wed, 25 Apr 2007 11:24:22 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47C33D8D@dlee13.ent.ti.com>
References: <BAY111-F2834F47ABBF2631D0C2EA3A6490@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <BAY111-F2834F47ABBF2631D0C2EA3A6490@phx.gbl>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Hades Liu <lcc0917@msn.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>When my board outputs image to tv-out, the output image is not =
completed.
>The partials of top and left are cut. Please reference to the attached
>file,
This is expected issue with any normal TV set. If you have a LCD TV then =
you should be able to see them properly.=20
Yes, the image gets chopped off from top/left and bottom / Right too.

>I had tried to set several different video mode parameters such =
pixclock,
>left_margin, hsync_len, and so on in data structure h4_tv_var, file
>omap2_disp_out.c. But it doesn't improve anything. :(
The tv_var structure will not help here as TV settings are controlled by =
VENC and not the DISPC as such. So you might have to play around with =
VENC register configuration a bit. But it's kind of a TV issue and not a =
problem with encoder. If you see same image on a different TV you see =
less chopped one. On a flat panel + LCD based TV you shouldn't see any =
chopped image.

>What can I do to solve this problem? Or it is NTSC's constraints and I
>should reserve 16 pixes from top and left while writting data to frame
>buffer for tv-out?
>
If you really need entire picture as is on TV, On Video pipeline you can =
downscale it to some factor that fits your TV. On Graphics pipeline you =
can pad with some data.

Why is your image shifted? It should just be chopped and not shifted. Is =
this your image capturing/drawing problem?

Regards,
Khasim
