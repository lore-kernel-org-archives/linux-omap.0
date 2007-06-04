From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: Re: SD response type 6 vs. 1
Date: Mon, 4 Jun 2007 20:55:17 +0200
Message-ID: <fb249edb0706041155w18a704c1t393a64bc3806c015@mail.gmail.com>
References: <fb249edb0706040841m222daab2xc7a4833e7b1c96cb@mail.gmail.com>
	<466456CC.1070408@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <466456CC.1070408@drzeus.cx>
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
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On 04/06/07, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> andrzej zaborowski wrote:
> > Hi,
> >  Linux has the same values for MMC_RSP_R1 and MMC_RSP_R6 thus making
> > the two response formats indistinguishable for mmc/sd hosts. Hardware
> > like my OMAP310 needs to know exactly whether to expect an R1 or R6
> > format, otherwise CMD3 fails.
> >
> > Sure it would be nice if it didn't care, but nevertheless, it's not a
> > hardware bug - the two formats are specified separately in SD specs
> > because they *are* different. So the hardware has full right to know
> > the right response type. Rather it's a hack to rely on R1 and R6
> > having the same size, like Linux does now. It would also be a hack to
> > allow the CMD3 to fail with CRC error and ignore the error, like
> > omap.c did before, because it makes an assumption that's not in the
> > OMAP specs.
>
> If you're referring to CERR, then I suggest you reread the specs. They
> even explicitly say its okay to ignore it.

If CERR is same as Card_Err bit in MMC_STAT, then I can't find
anything about ignoring it in OMAP310 TRM.

But the assumption here is different - that the only effect of
specifying a wrong response type is this bit getting set wrongly. The
assumption is wrong, the hardware can do anything it likes with the
information we gave it, including parsing the opcode - as long as it
conforms with TRM. Nowhere does it say that it's okay to pass R1 in
place of R6, and if it doesn't say this, the effect is defined as
"undefined". We should avoid this.

>
> Anyway, I'm not going into this discussion again without a valid
> argument as to why the suggest path won't work.
>
> >
> > The following is an ugly fix. It's ugly because host code should be
> > agnostic to opcodes, as mentioned by Pierre Ossman.
> > I believe this was already submitted by Carlos Aguiar and rejected by
> > Pierre, which resulted in leaving the driver broken on some boards.
>
> This just hides the fact that the host parses the data more than we want
> and expect it to do.

We expect what the docs say.

Regards,
Andrzej
