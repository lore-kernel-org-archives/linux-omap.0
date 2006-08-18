From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Building kenel error
Date: Fri, 18 Aug 2006 15:26:33 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5072DAD46@dlee02.ent.ti.com>
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
To: Brian Swetland <swetland@google.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > We have to use several different versions.  Currently I use 3.4.0,
> > 3.4.3, and 3.3.1 on older kernels.  On the latest kernels we will
use
> > 4.1.0.  We have built these, gotten them from a vendor, or gotten
from
> > www.codesourcery.com .
> >
> > One of the main reasons for using CodeSourcery based tool chains is
they
> > provide newer ARM support though ARMv7 (including VFP & VFP2).  If
you
> > are doing gaming with the OMAP2 3d core it can provide a nice boost.
>=20
> What is codegen and stability like?  I suffered through a number of
> pre-3.x versions while working at Danger and have found the 3.3.x and
> 3.4.x toolchains to be pretty solid.  I had heard that the changes in
> 4.x resulted in big improvements in x86 codegen but other platforms
> suffered a bit -- any truth to this?  New instruction set support is
> very cool, but I'm curious how the baseline arm and thumb support has
> held up.

I've not (nor had to) pay much attention to those aspects yet. Getting
integrated vfp and new instructions was the primary driver.  ARM Ltd. is
also validating their builds against it.  I think it has thumb2 support
also, perhaps some neon.  The latest u-boot and kernels do build and
boot against it...  It will surely have some issues, I hope we're not
impacted...will see.

Regards,
Richard W.
