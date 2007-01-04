From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Question about SRAM access
Date: Thu, 4 Jan 2007 16:49:59 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A50939B78F@dlee02.ent.ti.com>
References: <1c5b04b60701041443s1dc8ee2cja1ced88ef8af4934@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <1c5b04b60701041443s1dc8ee2cja1ced88ef8af4934@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Bhaskara Rao Kotla <bhaskar12@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

SRAM is not by default assigned into a pool which kmalloc or other could
use.

The only current user in the default tree's is clock code for sleep and
operation point changes.  If you ever make ROM code service calls it
uses some also.

Currently this clock code is 'allocated' using two methods.  The git
tree uses a push function which can in a sense allocate memory from
sram, however, there is no pop routine.  In the TI tree we hand carve
out the memory.

Currently the SRAM has a static TLB entry associated with it so you can
access through that mapping directly as long as you don't overwrite the
clock code.

Regards,
Richard W.

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Bhaskara Rao Kotla
> Sent: Thursday, January 04, 2007 4:44 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: Question about SRAM access
>=20
> Hi,
>      I am new to linux driver development.
>      I have a question(may be blind Qns) regarding SRAM access on
OMAP2430.
>      my task is write some chunk of data in SRAM from DDR SDRAM
> memory(data
> transfer from DDRSDRAM to SRAM) using DMA.
>      I have a question, how to allocate the SRAM memory(I mean, is it
> using
> kmalloc() or malloc? ). I can allocate a memory space  using kmalloc()
in
> DDR SDRAM, by default kernel will do i guess.
>=20
> Can someone suggest how to handle this?
>=20
>=20
> Regards,
> Bhaskara
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
