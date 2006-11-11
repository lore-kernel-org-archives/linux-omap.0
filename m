From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix for mailbox and dsp module (repost)
Date: Sat, 11 Nov 2006 02:10:58 +0200
Message-ID: <20061111001058.GQ26185@atomide.com>
References: <7AF192DA69C59243838FF62851F64F550321230D@toebe101.NOE.Nokia.com>
	<7AF192DA69C59243838FF62851F64F5503242297@toebe101.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <7AF192DA69C59243838FF62851F64F5503242297@toebe101.NOE.Nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Toshihiro.Kobayashi@nokia.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Toshihiro.Kobayashi@nokia.com <Toshihiro.Kobayashi@nokia.com> [061110 06:49]:
> Reposting with S-O-B.
> 
> Signed-off-by: Toshihiro Kobayashi <toshihiro.kobayashi@nokia.com>
> 
> >-----Original Message-----
> >From: Kobayashi Toshihiro (Nokia-NRC/Tokyo) 
> >Sent: Wednesday, November 08, 2006 8:01 PM
> >To: 'linux-omap-open-source@linux.omap.com'; Doyu Hiroshi 
> >(Nokia-M/Helsinki)
> >Subject: [PATCH] ARM: OMAP: Fix for mailbox and dsp module
> >
> >Fix to build DSP Gateway as a module.
> >
> >After this fix, modules regarding mailbox will be built as follows.
> >
> >arch/arm/mach-omap[12]/mailbox.o -> mailbox_mach.ko
> >arch/arm/plat-omap/mailbox.o ->mailbox.ko

Thanks, pushing.

Tony
