From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] plat-omap changes for 2430 SDP
Date: Tue, 14 Nov 2006 06:02:10 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A50893F77A@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
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
To: Trilok Soni <soni.trilok@gmail.com>, "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> As clk_get gpio5_ick can really fail, we should also put proper error
> return path if there is an error in getting gpio5_fck. Actually this
> is required in general for other OMAP1/2 clocks in gpio.c, also printk
> with KERN_INFO will be good :)

That is the convention and it should be followed...  But practically for
an internal clock wrapped in an is_cpu_xyz macro the only way for it to
fail today is for the name parameter to be wrong (or system corruption).
Given the API there are many possibilities which could do the get in a
more creative way, requiring a check, but that isn't usage today.  A lot
of verbosity inside of a is_cpu_xyz doesn't feel like it adds much for
its size.

Regards,
Richard W.
