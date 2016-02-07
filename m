From: Emil Goode <emil.fsw-k26UujxPaJg@public.gmane.org>
Subject: Re: wl12xx regression on 4.5 (was: Re: linux-4.5-rc1 TI pandboard-es
 wifi wlcore locks and reset)
Date: Sun, 7 Feb 2016 23:05:39 +0100
Message-ID: <20160207220538.GA4464@lianli>
References: <CANfgCY2nHh+vZ=JOimJdKKKs2JgM-c7m+3ePZtS3XhqyXNkDUQ@mail.gmail.com>
 <CANfgCY2zVXrLGv=YDpNvqhhoj5U2kgqZ_VV1EBPVK78grra84Q@mail.gmail.com>
 <20160202043448.GA9514@earth>
 <CANfgCY21zzinD48DOHaZdkGdDWpuAtJN1T8ofmdwM=P4f-7=Yw@mail.gmail.com>
 <20160202160538.GA19990@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160202160538.GA19990@earth>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ross Green <rgkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello,

On Tue, Feb 02, 2016 at 05:05:38PM +0100, Sebastian Reichel wrote:
> On Tue, Feb 02, 2016 at 04:41:13PM +1100, Ross Green wrote:
> > On Tue, Feb 2, 2016 at 3:34 PM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > > On Mon, Feb 01, 2016 at 11:38:38PM +1100, Ross Green wrote:
> > >> On Mon, Jan 25, 2016 at 11:47 PM, Ross Green <rgkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > >> > Just tried the new kernel release on faithful pandaboard es with the
> > >> > new 4.5-rc1 release.
> > >> >
> > >> > There is a problem with the wifi modules once the modules are loaded.
> > >> > Looks like the wifi firmware gets loaded put no response after that
> > >> > causing recovery action.
> > >> >
> > >> > the kernel 4.4 works quite happily with this board.
> > >> >
> > >> > Here is a dmesg dump in the attachment.
> > >> >
> > >> > Anyone have any ideas here?
> >
> > [...]
> > 
> > If I get time, this evening, I'll see if I can give a bisect a try.
> 
> On N950 [wl1271 via SPI, using extra patches to init from DT] I get wifi
> working again on 4.5-rc1 with 3719c17e1816 ("wlcore/wl18xx: fw logger
> over sdio") reverted.

Reverting the changes in wlcore_set_partition() as below seem to help.

Best regards,

Emil Goode

8<--------

--- a/drivers/net/wireless/ti/wlcore/io.c
+++ b/drivers/net/wireless/ti/wlcore/io.c
@@ -175,14 +175,15 @@ int wlcore_set_partition(struct wl1271 *wl,
 	if (ret < 0)
 		goto out;
 
+	/*
+	 * We don't need the size of the last partition, as it is
+	 * automatically calculated based on the total memory size and
+	 * the sizes of the previous partitions.
+	 */
 	ret = wlcore_raw_write32(wl, HW_PART3_START_ADDR, p->mem3.start);
 	if (ret < 0)
 		goto out;
 
-	ret = wlcore_raw_write32(wl, HW_PART3_SIZE_ADDR, p->mem3.size);
-	if (ret < 0)
-		goto out;
