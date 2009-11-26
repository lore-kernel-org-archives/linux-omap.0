From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC][PATCH v2] OMAP: McBSP: Use register cache
Date: Thu, 26 Nov 2009 14:25:36 +0100
Message-ID: <200911261425.39562.jkrzyszt@tis.icnet.pl>
References: <200908121239.26346.jkrzyszt@tis.icnet.pl> <200911241231.18333.jkrzyszt@tis.icnet.pl> <20091126100000.add50e72.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:57927 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899AbZKZNZm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Nov 2009 08:25:42 -0500
In-Reply-To: <20091126100000.add50e72.jhnikula@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thursday 26 November 2009 09:00:00 Jarkko Nikula napisa=C5=82(a):
> Hi
>
> On Tue, 24 Nov 2009 12:31:16 +0100
>
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
> > -#define OMAP_MCBSP_READ(base, reg) \
> > -			omap_mcbsp_read(base, OMAP_MCBSP_REG_##reg)
> > -#define OMAP_MCBSP_WRITE(base, reg, val) \
> > -			omap_mcbsp_write(base, OMAP_MCBSP_REG_##reg, val)
> > +#define OMAP_MCBSP_READ(mcbsp, reg) \
> > +		omap_mcbsp_read(mcbsp->io_base, OMAP_MCBSP_REG_##reg)
> > +#define OMAP_MCBSP_WRITE(mcbsp, reg, val) \
> > +		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, val)
> > +
> > +#define OMAP_MCBSP_CREAD(mcbsp, reg) \
> > +		(mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / OMAP_MCBSP_REG_DRR1])
> > +#define OMAP_MCBSP_CWRITE(mcbsp, reg, val) \
> > +		omap_mcbsp_write(mcbsp->io_base, OMAP_MCBSP_REG_##reg, \
> > +		mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / OMAP_MCBSP_REG_DRR1] \
> > +			=3D val)
> > +
>
> Have rather single write writing both the cache and actual register.
> I.e. keep the OMAP_MCBSP_WRITE since writes should always go to hw an=
d
> makes the patch smaller.

Jarkko,
Not that I am against making things simpler, but please reconsider:

1. Is there any point for caching data written to DXR registers?

2. There is at least one register, WAKEUPEN, never updated bit by bit, =
but=20
always rewritten from scratch with a few different values that can be=20
computed easily from other msbsp structure member values. For these rar=
e=20
cases, is it any worth to bypass the cache while writing them, saving a=
 few=20
instructions maybe?

3. Sometimes a register is written several times in succession with dif=
ferent=20
values, like SYSCON inside omap34xx_mcbsp_free(), for example. Could al=
l=20
writes but the last one bypass the cache for the same reason?

Another axample is omap_mcbsp_start() fiddling with SPCR2 several times=
=2E=20
However, there is a udelay(500) inbetween that I am not sure if can eve=
r=20
happen to be interleaved with a concurrent suspend or idle or something=
 like=20
that requiring the cache being up-to-date.

That said, please confirm if a single write macro with caching still se=
ems=20
sufficient, or a separate one without caching would provide enough bene=
fits=20
to keep it as well.

> I also found the OMAP_MCBSP_CREAD a little=20
> unclear so I suggest to name is as OMAP_MCBSP_READ_CACHE.

I just tried to minimize line wrapping :/. If we agree on a single cach=
ing=20
version of OMAP_MCBSP_WRITE(), what about OMAP_CACHE_READ()? If no bett=
er=20
ideas, I'll use what you suggest.

> > +#define OMAP_MCBSP_BREAD(mcbsp, reg) \
> > +		(mcbsp->reg_cache[OMAP_MCBSP_REG_##reg / OMAP_MCBSP_REG_DRR1] \
> > +			=3D OMAP_MCBSP_READ(mcbsp->io_base, reg))
>
> Why is this? There is nothing eating this :-)

It's a part of a possible solution I am considering for SYSCON register=
=20
handling. See below.

> >  	dev_dbg(mcbsp->dev, "DRR2:  0x%04x\n",
> > -			OMAP_MCBSP_READ(mcbsp->io_base, DRR2));
> > +			OMAP_MCBSP_READ(mcbsp, DRR2));
>
> These changes are worth to send as a separate cleanup patch. Will mak=
e
> the actual cache patch smaller and easier to follow.

OK, but let me recap that first. We have two options:

1. All macros accept very same arguments, as long as applicable.
   This is what I have put in my patch.

2. Every macro is optimized in respect of its argumnets, ie.
	OMAP_MCBSP_READ(io_base, ...)
	OMAP_MCBSP_READ_CACHE(reg_cache, ...)
	OMAP_MCBSP_WRITE(mcbsp, ...)

Which one do you think is better?

> > @@ -93,15 +104,15 @@ static irqreturn_t omap_mcbsp_tx_irq_han
> >  	struct omap_mcbsp *mcbsp_tx =3D dev_id;
> >  	u16 irqst_spcr2;
> >
> > -	irqst_spcr2 =3D OMAP_MCBSP_READ(mcbsp_tx->io_base, SPCR2);
> > +	irqst_spcr2 =3D OMAP_MCBSP_READ(mcbsp_tx, SPCR2);
> >  	dev_dbg(mcbsp_tx->dev, "TX IRQ callback : 0x%x\n", irqst_spcr2);
> >
> >  	if (irqst_spcr2 & XSYNC_ERR) {
> >  		dev_err(mcbsp_tx->dev, "TX Frame Sync Error! : 0x%x\n",
> >  			irqst_spcr2);
> >  		/* Writing zero to XSYNC_ERR clears the IRQ */
> > -		OMAP_MCBSP_WRITE(mcbsp_tx->io_base, SPCR2,
> > -			irqst_spcr2 & ~(XSYNC_ERR));
> > +		OMAP_MCBSP_CWRITE(mcbsp_tx, SPCR2,
> > +			OMAP_MCBSP_CREAD(mcbsp_tx, SPCR2) & ~(XSYNC_ERR));
>
> I was thinking that should these read+read_cache changes be a separat=
e
> patch for fixing the 1510 issues since no other OMAPs are known to
> corrupt registers and plain hw read is enough for them.

I see. Do you want the change limited to cpu_is_omap1510() case only?

> > @@ -612,7 +612,6 @@ EXPORT_SYMBOL(omap_mcbsp_stop);
> >  int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
> >  {
> >  	struct omap_mcbsp *mcbsp;
> > -	void __iomem *base;
> >
> >  	if (!omap_mcbsp_check_valid_id(id)) {
> >  		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> > @@ -620,28 +619,27 @@ int omap_mcbsp_pollwrite(unsigned int id
> >  	}
> >
> >  	mcbsp =3D id_to_mcbsp_ptr(id);
> > -	base =3D mcbsp->io_base;
> >
> > -	writew(buf, base + OMAP_MCBSP_REG_DXR1);
> > +	OMAP_MCBSP_WRITE(mcbsp, DXR1, buf);
> >  	/* if frame sync error - clear the error */
> > -	if (readw(base + OMAP_MCBSP_REG_SPCR2) & XSYNC_ERR) {
> > +	if (OMAP_MCBSP_READ(mcbsp, SPCR2) & XSYNC_ERR) {
>
> These looks also that these are better to cover with its own separate
> cleanup patch.

Ok, the series will start with this cleanup therefore.

> I'm not completely sure are there any code path expecting to read res=
et
> default values from the cache or are there always explicit write or
> read before it? I was thinking would it be necessary to initialize th=
e=20
> cache by issuing dummy reads for all registers. IRCC the OMAP2420 has
> fewer registers than 2430 or OMAP3 so that should be took into accoun=
t
> if there is a need to do so.

=46irst of all, I decided not touching any registers not maintained by =
the code=20
so far. I have not enough knowledge to deal with them unless someone de=
cides=20
to shepherd me there :-).

The only issue I am not satisfied how I have dealt with so far is SYSCO=
N=20
register case. I have noticed that the register is never initialized li=
ke=20
others , but always updated based on values read back from hardware.=20
Initially I didn't find any good idea how to deal with this in respect =
of=20
caching, so decided to take an intermediate path: read from hardware, t=
hen=20
write with caching, even if the cached value is never referred for now.=
 Here=20
is the relevant part of my patch:

@@ -313,19 +318,18 @@ static inline void omap34xx_mcbsp_reques
 	if (cpu_is_omap34xx()) {
 		u16 syscon;
=20
-		syscon =3D OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
+		syscon =3D OMAP_MCBSP_READ(mcbsp, SYSCON);
 		syscon &=3D ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
=20
 		if (mcbsp->dma_op_mode =3D=3D MCBSP_DMA_MODE_THRESHOLD) {
 			syscon |=3D (ENAWAKEUP | SIDLEMODE(0x02) |
 					CLOCKACTIVITY(0x02));
-			OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN,
-					XRDYEN | RRDYEN);
+			OMAP_MCBSP_CWRITE(mcbsp, WAKEUPEN, XRDYEN | RRDYEN);
 		} else {
 			syscon |=3D SIDLEMODE(0x01);
 		}
=20
-		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
+		OMAP_MCBSP_CWRITE(mcbsp, SYSCON, syscon);
 	}
 }
=20
@@ -337,7 +341,7 @@ static inline void omap34xx_mcbsp_free(s
 	if (cpu_is_omap34xx()) {
 		u16 syscon;
=20
-		syscon =3D OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
+		syscon =3D OMAP_MCBSP_READ(mcbsp, SYSCON);
 		syscon &=3D ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
 		/*
 		 * HW bug workaround - If no_idle mode is taken, we need to
@@ -345,12 +349,12 @@ static inline void omap34xx_mcbsp_free(s
 		 * device will not hit retention anymore.
 		 */
 		syscon |=3D SIDLEMODE(0x02);
-		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
+		OMAP_MCBSP_CWRITE(mcbsp, SYSCON, syscon);
=20
 		syscon &=3D ~(SIDLEMODE(0x03));
-		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
+		OMAP_MCBSP_CWRITE(mcbsp, SYSCON, syscon);
=20
-		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, 0);
+		OMAP_MCBSP_CWRITE(mcbsp, WAKEUPEN, 0);
 	}
 }
 #else

How about caching the SYSCON register initial value from inside=20
omap_mcbsp_config() by copying it's initial value from the hardware wit=
h=20
something like that OMAP_MCBSP_BREAD() macro not eaten so far (probably=
=20
renamed to OMAP_CACHE_INIT/COPY() or OMAP_MCBSP_SAVE/STORE() or somethi=
ng=20
similiar)? Would that be enough for addressing your concern?

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
