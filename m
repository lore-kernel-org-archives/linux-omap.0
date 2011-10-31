From: Florian Fainelli <ffainelli@freebox.fr>
Subject: Re: [RFC] Change ECC algorithm from userspace
Date: Mon, 31 Oct 2011 10:02:35 +0100
Message-ID: <5769554.XO3QpDQ76H@flexo>
References: <CAAwP0s059H3BGhYbYLux2gR6ZNb+sFDue676OM2Evz5cA2q6DA@mail.gmail.com>
	<4EAA845B.1020009@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <4EAA845B.1020009@parrot.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-mtd@lists.infradead.org
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Enric Balletbo i Serra <eballetbo@iseebcn.com>, Matthieu CASTET <matthieu.castet@parrot.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Friday 28 October 2011 12:30:51 Matthieu CASTET wrote:
> Hi,
> =

> Javier Martinez Canillas a =E9crit :
> > Hello,
> > =

> > I want to be able to use 1-bit ECC for the first partition where I
> > save the loader binary and has to be accessed by the ROM boot but use
> > a 4-bit ECC for my rootfs partition.
> > =

> > Does anyone have this same issue?
> =

> We use raw programming and compute the ecc in software.

We are doing something similar here as well. Our bootloader also requires t=
he =

data to be layed out differently (data + ecc interleaved inside a page + oo=
b).

> =

> > What is the best approach to store data in a NAND device using
> > different ECC techniques?
> > =

> > I've think of two approaches:
> > =

> > 1- Adding an ioctl to mtdchar (something like ECCSETBITS) to change
> > the ECC technique used.
> =

> But this won't work if there is concurrent acess to mtd. One program may
> want 1 bit ecc other want 4 bits ecc.
> =

> > 2- Use a platform data field to notify the omap2 nand driver that the
> > ROM boot only supports 1-bit ECC. So it can use a 1-bit ECC to write
> > and read the first 4 sectors but a 4-bit ECC for the rest.
> =

> This may be better.

Would not it better to add infrastructure for allowing per-partition ECC =

scheme? This should allow the kernel to also be able to properly handle the =

bootloader partitions (bad-block scanning ...).

> =

> Matthieu
> =

> PS : note that some OMAP ROM support a better protection than Hamming (but
> the details are not public AFAIK)
> =

> From OMAP34xx Multimedia Device, Silicon Revision 3.1.x, public version :
> =

> Pages can contain errors caused by memory alteration. To correct these
> errors, the ROM code uses ECC,
> based on Hamming codes for SLC NAND and BCH (Bose, Ray-Chaudhuri,
> Hocquenghem) code for
> multilevel cell (MLC) devices. The computed ECC is compared to ECC stored=
 in
> the spare area of the
> corresponding page. If there are uncorrectable errors, the ROM code retur=
ns
> with FAIL.
--
Florian

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
