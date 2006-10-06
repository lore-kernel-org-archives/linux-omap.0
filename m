From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Recent git kernels and OSK
Date: Fri, 06 Oct 2006 11:58:18 +0200
Message-ID: <452628BA.4000907@gmail.com>
References: <4521941B.2020102@balister.org> <45226BC5.9050201@gmail.com>
	<452280A5.5080805@gmail.com> <452378FA.9050604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <452378FA.9050604@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Dirk Behme wrote:
> Doing some more debugging (with low level debug disabled now) shows that 
> at least until "ARM: OMAP: DSPGW: mailbox log cleanup" [1] everything is 
> okay. Then, with all changes including "ARM: OMAP: DSPGW: Peripheral 
> (kfunc) control" [2] it seems to be broken.

After some additional hours of debugging it's a really
simple bug: A strcmp() mismatch which results in
omap_dsp->mbox being a NULL pointer.

In mach-omap1/mailbox.c the mailbox name is .name = "DSP"
while in plat-omap/dsp/dsp_core.c function  dsp_mbox_init()
asks for "dsp". omap2 is correct, there .name is "dsp".

Patch follows.

There are still some open questions:

Mailbox related:

* Why does

if (IS_ERR(omap_dsp->mbox)) {

in arch/arm/plat-omap/dsp/dsp_core.c in dsp_mbox_init()
doesn't catch NULL pointer (omap_dsp->mbox == NULL)?

- Why does system crash later if omap_dsp->mbox being NULL
is caught correctly? E.g. using

if (omap_dsp->mbox == NULL) {

instead of IS_ERR above results in

...
<3>failed to get mailbox handler for DSP.
<7>omapdsp: unmapping in ARM MMU, v=0xe0fff000, sz=0x1000
<1>Unable to handle kernel paging request at virtual address
b0000ffc
...

LowLevel debug related:

- Why does LowLevel debug only works if omap_writew(reg,
SOFT_REQ_REG) is disabled in mach-omap1/clock.c ?

Cheers

Dirk
