From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: RE: [PATCH 4/4] mtd: nand: omap2: Add data correction support
Date: Fri, 5 Oct 2012 08:51:50 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3E9B8A65@DBDE01.ent.ti.com>
References: <1349274589-11389-1-git-send-email-avinashphilip@ti.com>
 <1349274589-11389-5-git-send-email-avinashphilip@ti.com>
 <20121003192044.GB27502@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Ivan Djelic <ivan.djelic@parrot.com>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>, "artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, "tony@atomide.com" <tony@atomide.com>, "Mohammed, Afzal" <afzal@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 04, 2012 at 15:51:03, Philip, Avinash wrote:
> On Thu, Oct 04, 2012 at 00:50:45, Ivan Djelic wrote:
> > On Wed, Oct 03, 2012 at 03:29:49PM +0100, Philip, Avinash wrote:
> > > ELM module can be used for error correction of BCH 4 & 8 bit. Also
> > > support read & write page in one shot by adding custom read_page &
> > > write_page methods. This helps in optimizing code.
> > > 
> > > New structure member "is_elm_used" is added to know the status of
> > > whether the ELM module is used for error correction or not.
> > > 
> > > Note:
> > > ECC layout of BCH8 uses 14 bytes for 512 byte of data to make compatible
> > > with RBL ECC layout, even though the requirement was only 13 byte. This
> > > results a common ecc layout across RBL, U-boot & Linux.
> > > 
> > 
> > See a few comments below,
> > 
> > (...)
> > > +static int omap_elm_correct_data(struct mtd_info *mtd, u_char *dat,
> > > +                               u_char *read_ecc, u_char *calc_ecc)
> > > +{
> > > +       struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
> > > +                       mtd);
> > > +       int eccsteps = info->nand.ecc.steps;
> > > +       int i , j, stat = 0;
> > > +       int eccsize, eccflag, size;
> > > +       struct elm_errorvec err_vec[ERROR_VECTOR_MAX];
> > > +       u_char *ecc_vec = calc_ecc;
> > > +       enum bch_ecc type;
> > > +       bool is_error_reported = false;
> > > +
> > > +       /* initialize elm error vector to zero */
> > > +       memset(err_vec, 0, sizeof(err_vec));
> > > +       if (info->nand.ecc.strength == BCH8_MAX_ERROR) {
> > > +               size = BCH8_SIZE;
> > > +               eccsize = BCH8_ECC_OOB_BYTES;
> > > +               type = BCH8_ECC;
> > > +       } else {
> > > +               size = BCH4_SIZE;
> > > +               eccsize = BCH4_SIZE;
> > > +               type = BCH4_ECC;
> > > +       }
> > > +
> > > +       for (i = 0; i < eccsteps ; i++) {
> > > +               eccflag = 0;    /* initialize eccflag */
> > > +
> > > +               for (j = 0; (j < eccsize); j++) {
> > > +                       if (read_ecc[j] != 0xFF) {
> > > +                               eccflag = 1;    /* data area is flashed */
> > 
> > Just a reminder: this way of checking if a page has been programmed is not robust to bitflips,
> > so you may get into trouble with UBIFS on a fairly recent device.

Sorry I missed this point.

Here we were checking data in spare area (only in ecc layout 14*4 for BCH8) is 0xFF. If all data
in spare area is 0xFF, conclude that the page is erased & no need of error correction. In case
of bit flip present in spare area, page will be reported as uncorrectable.
But I am not understand understand " trouble with UBIFS on a fairly recent device".
Can you little elaborativ

Thanks
Avinash 

