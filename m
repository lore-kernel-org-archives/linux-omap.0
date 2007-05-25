From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: [PATCH] OMAP: 2430SDP: Support LCD display as a FB device
Date: Fri, 25 May 2007 18:20:58 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47FF0C4B@dlee13.ent.ti.com>
References: <200705251518.13137.hyau@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <200705251518.13137.hyau@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hunyue Yau <hyau@mvista.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


>Add glue to control the 2430SDP LCD as a frame buffer device
>using the existing dispc.c driver under omapfb.
>
>Signed-off-by: Hunyue Yau <hyau@mvista.com>
>Signed-off-by: Kevin Hilman <khilman@mvista.com>

Generally if we are putting a new file to list, it's better to mark it =
as an RFC or RFC / PATCH. So that Tony takes up this in his next series =
of pushes and we get some chance to review the code.

And for 2430 LCD please have discussions on list before working. Imre =
and I had a discussion a month back but due to other priorities we were =
not able to sync up again. There are good pointers that we have which =
can bring the code in a better shape.

We have to work on 2420 2430 3430 Display subsystem for many boards that =
have different kind of interfaces like parallel, RFBI, DSI etc and =
software stack interface to FBDEV, V4L, etc.

Lets re-start a thread may be early next week with Imre, Kevin, Hunyue. =
Let's come up with a framework later who ever gets time can contribute.

Regards,
Khasim
