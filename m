From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: SD response type 6 vs. 1
Date: Mon, 04 Jun 2007 20:15:40 +0200
Message-ID: <466456CC.1070408@drzeus.cx>
References: <fb249edb0706040841m222daab2xc7a4833e7b1c96cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0706040841m222daab2xc7a4833e7b1c96cb@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: andrzej zaborowski <balrogg@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

andrzej zaborowski wrote:
> Hi,
>  Linux has the same values for MMC_RSP_R1 and MMC_RSP_R6 thus making
> the two response formats indistinguishable for mmc/sd hosts. Hardware
> like my OMAP310 needs to know exactly whether to expect an R1 or R6
> format, otherwise CMD3 fails.
>
> Sure it would be nice if it didn't care, but nevertheless, it's not a
> hardware bug - the two formats are specified separately in SD specs
> because they *are* different. So the hardware has full right to know
> the right response type. Rather it's a hack to rely on R1 and R6
> having the same size, like Linux does now. It would also be a hack to
> allow the CMD3 to fail with CRC error and ignore the error, like
> omap.c did before, because it makes an assumption that's not in the
> OMAP specs.

If you're referring to CERR, then I suggest you reread the specs. They
even explicitly say its okay to ignore it.

Anyway, I'm not going into this discussion again without a valid
argument as to why the suggest path won't work.

>
> The following is an ugly fix. It's ugly because host code should be
> agnostic to opcodes, as mentioned by Pierre Ossman.
> I believe this was already submitted by Carlos Aguiar and rejected by
> Pierre, which resulted in leaving the driver broken on some boards.

This just hides the fact that the host parses the data more than we want
and expect it to do.

>
> A more correct and more intrusive fix would look like this:

Afraid not. The response type specifies format, not semantical contents.

The correct fix has already been discussed, but I have seen zero
attempts at implementing it:

http://linux.omap.com/pipermail/linux-omap-open-source/2007-April/009500.html

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
