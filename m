From: Charles Manning <manningc2@actrix.gen.nz>
Subject: Re: [PATCH 1/2] mtd: Add nand_base feature to align subpage read buffers
Date: Wed, 19 Jan 2011 06:42:28 +1300
Message-ID: <201101190642.29009.manningc2@actrix.gen.nz>
References: <1294277942-1252-1-git-send-email-cdhmanning@gmail.com> <1294277942-1252-2-git-send-email-cdhmanning@gmail.com> <1295338423.2470.54.camel@koala>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.scorch.co.nz ([27.110.127.199]:41900 "HELO scorch.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752168Ab1ARRmd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jan 2011 12:42:33 -0500
In-Reply-To: <1295338423.2470.54.camel@koala>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind1@gmail.com
Cc: Charles Manning <cdhmanning@gmail.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

On Tuesday 18 January 2011 21:13:43 Artem Bityutskiy wrote:
> Hi,
>
> would it please be possible improve comments and the commit message and
> make them explain better which problem the patch solves, what is the
> problem with the current code, how exactly you solve the problem, and
> why your solution is the best among other alternative solutions?
>
> I think the below commit messages is too short and does not explain
> this.

OK. I will resubmit this done a different way. The patch I submitted does not 
work as generally as it should.


>
> On Thu, 2011-01-06 at 14:39 +1300, Charles Manning wrote:
> > Some nand controllers (eg. omap2) need to have their buffers u32 aligned
> > to use high speed transfer mechanisms.
> >
> > This commit provides a way to plug in an alignment function and provides
> > a 32-bit algnment function.
> >
> > Signed-off-by: Charles Manning <cdhmanning@gmail.com>
> > ---
> >  drivers/mtd/nand/nand_base.c |   22 +++++++++++++++++++++-
> >  include/linux/mtd/nand.h     |    5 +++--
> >  2 files changed, 24 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
> > index 1f75a1b..e8c2432 100644
> > --- a/drivers/mtd/nand/nand_base.c
> > +++ b/drivers/mtd/nand/nand_base.c
> > @@ -1156,6 +1156,22 @@ static int nand_read_page_swecc(struct mtd_info
> > *mtd, struct nand_chip *chip, }
> >
> >  /**
> > + * nand_align_subpage32 - function to align subpage read to 32-bits
> > + * @mtd:	mtd info structure
> > + * @buf:	pointer to pointer of buffer that needs to be aligned
> > + * @len:	pointer to length that needs to be aligned.
> > + */
> > +
>
> Why blank line here?
>
> > +void nand_align_subpage32(uint8_t **buf, int *len)
> > +{
> > +	int diff = (int)(*buf) & 3;
> > +	*buf =  *buf - diff;
>
> It is really not obvious that this buffer does not come from user-space,
> but it is some internal chip->buffers->databuf, so you actually can step
> back. Cold you please put some comment about this?
>
> > +	*len = *len + diff;
> > +	*len = (*len + 3) & ~3;
> > +}
> > +EXPORT_SYMBOL(nand_align_subpage32);
>
> In general, do you think it is a good thing that MTD NAND core always
> reads to internal buffer first, then copies the data to the user buffer?
> To me it looks like bad idea because we end up with unwanted overhead.
> There is a benefit - if you read the same NAND page twice, you get the
> data from the buffer the second time. But this does not work with
> sub-pages, and I think this MTD core is wrong place for this. If someone
> wants caching, he could use the Linux page cache as a layer on top of
> MTD core, instead of this castrated one NAND page cache.
>
> Anyway, what I want to say is that the current architecture is bad, IMO.
> Namely, this "always read to own buffer" thing is bad. But your patch
> relays on this, so if some one some day wants to improve MTD NAND core
> in this respect, he'll end up with more job.
>
> Is it possible to invent some solution which does not rely on the fact
> that you deal with an internal buffer, but instead, assumes that you may
> be dealing with a user buffer?
>
> > +
> > +/**
> >   * nand_read_subpage - [REPLACABLE] software ecc based sub-page read
> > function * @mtd:	mtd info structure
> >   * @chip:	nand chip info structure
> > @@ -1169,6 +1185,7 @@ static int nand_read_subpage(struct mtd_info *mtd,
> > struct nand_chip *chip, int start_step, end_step, num_steps;
> >  	uint32_t *eccpos = chip->ecc.layout->eccpos;
> >  	uint8_t *p;
> > +	uint8_t *b;
>
> The current style prefers
> uint8_t *p, *b;
> for some reasons.
>
> >  	int data_col_addr, i, gaps = 0;
> >  	int datafrag_len, eccfrag_len, aligned_len, aligned_pos;
> >  	int busw = (chip->options & NAND_BUSWIDTH_16) ? 2 : 1;
> > @@ -1222,7 +1239,10 @@ static int nand_read_subpage(struct mtd_info *mtd,
> > struct nand_chip *chip,
> >
> >  		chip->cmdfunc(mtd, NAND_CMD_RNDOUT,
> >  					mtd->writesize + aligned_pos, -1);
> > -		chip->read_buf(mtd, &chip->oob_poi[aligned_pos], aligned_len);
> > +		b =  &chip->oob_poi[aligned_pos];
> > +		if(chip->align_subpage)
> > +			chip->align_subpage(&b, &aligned_len);
> > +		chip->read_buf(mtd, b, aligned_len);
> >  	}
> >
> >  	for (i = 0; i < eccfrag_len; i++)
> > diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
> > index 63e17d0..6ea6177 100644
> > --- a/include/linux/mtd/nand.h
> > +++ b/include/linux/mtd/nand.h
> > @@ -474,6 +474,7 @@ struct nand_buffers {
> >   *			additional error status checks (determine if errors are
> >   *			correctable).
> >   * @write_page:		[REPLACEABLE] High-level page write function
> > + * @align_subpage:	[OPTIONAL] Aligns subpage read buffer.
> >   */
>
> Would it please be possible to add more comments to the code about this
> align_subpage stuff, for people who try to read it in the future?


