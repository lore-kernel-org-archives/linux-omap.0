From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: OMAP2430: networking errors
Date: Thu, 17 May 2007 15:03:35 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47F15BFE@dlee13.ent.ti.com>
References: <57314e840705171255n5932cba1wf32abffbc6a0baaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <57314e840705171255n5932cba1wf32abffbc6a0baaa@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Budhee Jamaich <budheej@gmail.com>, Steve Poulsen <spoulsen@css-design.us>, "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

>
>It'd be interesting to understand why the OMAP has trouble working
>with those low cost switches (or the opposite), while standard PCs
>seem to work fine with the...   but I guess I won't have the time
>to explore it too much... :(
>

As I know, the SMC91 driver for OMAP configures the chip in half duplex. =
Generally PCs will be configured to work Full duplex. Don't know if this =
is the problem, but giving you some start for reasoning :)

Regards,
Khasim
