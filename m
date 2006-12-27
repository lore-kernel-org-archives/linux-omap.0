From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: Some questions about OMAP 2430 video output
Date: Tue, 26 Dec 2006 22:01:11 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470C4B2A@dlee13.ent.ti.com>
References: <dbf1574b0612261834i4c3b0bb6q6086118b202b7a14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <dbf1574b0612261834i4c3b0bb6q6086118b202b7a14@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: RobertChou <rbtchc@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Yes, the screen size can be varied by changing the configuration
parameters.

For Framebuffer use the setvar. For Video drivers using the S_FMT to set
the picture size and remember to configure the Video window size too.

Regards,
Khasim

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of RobertChou
> Sent: Tuesday, December 26, 2006 8:35 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: Some questions about OMAP 2430 video output
>=20
> Dear all:
>=20
>    I'm currently using Linux-2.6.14-omap2 for OMAP 2430 SDP, and i'm
> trying to output
> the screen through video out. But the size of video out is restricted
> at 240*320.
> Is it possible to adjust the size by feeding parameter to framebuffer
> or video driver??
> Thx a lot :)
>=20
> Robert
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
