From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Re: McBSP 2 yet
Date: Wed, 17 Oct 2007 00:49:32 -0200
Message-ID: <ae36f8040710161949p278fba93v6d6b30710d17e211@mail.gmail.com>
References: <ae36f8040710161533x2d4fad0amc4136a75ba6d287c@mail.gmail.com>
	<4715430F.3020303@gmail.com>
	<ae36f8040710161634u308512fdwfae33f64fd15f755@mail.gmail.com>
	<ae36f8040710161634ra42bfc3v8b075ef1dbd2f351@mail.gmail.com>
	<782515bb0710161700k78813b0dn4335be38e13a7e77@mail.gmail.com>
Reply-To: lvcargnini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <782515bb0710161700k78813b0dn4335be38e13a7e77@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: nishanth menon <menon.nishanth@gmail.com>
Cc: Diogo Scolari <diogo@instramed.com.br>, OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

my friend you was of amazing help, but only to elucidate the problem,
reading the sources of tsc210X and AIC23 I founded this function:
static int omap_mcbsp3_aic23_clock_init(void)
{
    u16 w;

    /* enable 12MHz clock to mcbsp 1 & 3 */
    __raw_writew(__raw_readw(DSP_IDLECT2) | (1<<1), DSP_IDLECT2);
    __raw_writew(__raw_readw(DSP_RSTCT2) | 1 | 1<<1, DSP_RSTCT2);

    /* disable sample rate generator */
    OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SPCR1, 0x0000);
    OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SPCR2, 0x0000);

    /* pin control register */
    OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, PCR0,(CLKXM | CLKXP | CLKRP));

    /* configure srg to send 12MHz pulse from dsp peripheral clock */
    OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SRGR1, 0x0000);
    OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SRGR2, CLKSM);

    /* enable sample rate generator */
    w =3D OMAP_MCBSP_READ(OMAP1610_MCBSP3_BASE, SPCR2);
    OMAP_MCBSP_WRITE(OMAP1610_MCBSP3_BASE, SPCR2, (w | FREE | GRST));
    printk("Clock enabled to MCBSP1 & 3 \n");

    return 0;
}

inside tlv320aic23.c
So, I have to enable the clock some way for McBSP2 (I suppose), now I have
to found this manner.

On 10/16/07, nishanth menon <menon.nishanth@gmail.com> wrote:
>
> Luis,
> Sorry I could not be of more help...having not used omap5912, i am
> assuming similar behavior as rest of omaps..
>
> On 10/16/07, Lu=EDs Cargnini <lvcargnini@gmail.com> wrote:
> > yes we have pin muxing enable according with kernel conf
> Hmm.. that is interesting, I dont have the trm around, but, I am
> looking at the Data manual:
> http://focus.ti.com/lit/ds/symlink/omap5912.pdf
> Couple of suspects:
> a) mcbsp2 lines come out on multiple ball outs (Look at page 84 for a
> simple map based on package).
> b) Then we have: peripheral ownership register:
> FFFB:C890 MCBSP2_SSW_CONF McBSP2 Peirpheral Ownership Register 32 R/W 000=
0
> 0001h
> I dont know what this means, but i guess it means ARM/DSP owning the
> module..
>
> I do recollect that all folks used mcbsp1 as the base module.. if u
> enable mcbsp, the least u'd expect is framesync and clk lines
> toggling.. if that is not coming, there could be a wrong pin mux -
> configuring the alternate pin... this u'd need schematics to confirm.
>
> Regards,
> Nishanth Menon
>



--=20
---------------------------------------------------------------------------=
---
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Electrical Engineer Faculty @ PUCRS
Ipiranga Avenue, 6681 =96 Building 30
P.O. Box: 90619-900 =96 Porto Alegre/RS
Phone: +55 51 3320 3500  extension: 7696
---------------------------------------------------------------------------=
------
