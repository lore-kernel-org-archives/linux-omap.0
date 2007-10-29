From: "Kyungmin Park" <kyungmin.park@samsung.com>
Subject: RE: oprofile on OMAP2: ARM11 PMU interrupts?
Date: Mon, 29 Oct 2007 09:48:35 +0900
Message-ID: <003701c819c5$765e6a90$e1ac580a@swcenter.sec.samsung.co.kr>
References: <472225F6.9070502@mvista.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742902530AF3@dlee13.ent.ti.com>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <3B6D69C3A9EBCA4BA5DA60D91302742902530AF3@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "'Woodruff, Richard'" <r-woodruff2@ti.com>, 'Kevin Hilman' <khilman@mvista.com>, 'Linux OMAP' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

FYI: Refer to the following article

http://blog.gustavobarbieri.com.br/2007/05/22/oprofile-and-maemo-n800/

I saw this article a month ago, but I also don't test it.
It needs the Oprofile modification.

Thank you,
Kyungmin Park

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-open-source-
> bounces@linux.omap.com] On Behalf Of Woodruff, Richard
> Sent: Saturday, October 27, 2007 5:53 AM
> To: Kevin Hilman; Linux OMAP
> Subject: RE: oprofile on OMAP2: ARM11 PMU interrupts?
> 
> Hi Kevin,
> 
> Yes, several people are using it locally on SDP2430 for measurements.  It is pretty neat.
> 
> Yes IRQ3 is correct I believe.
> 
> There is a patch around which makes it work on ML4.1 which someone did a while back.  Last comment
> I saw was Russell's base patch had a few mistakes when needed fixing.
> 
> I'll take a look for the path and send you a copy.  Perhaps you can push out fixes as your
> currently interested.
> 
> Regards,
> Richard W.
> 
> > Is anyone using oprofile on OMAP2?
> >
> > A quick test of the current code in current git doesn't seem to work.  I
> > see the PMU being configured, IRQ3 being registered but no interrupts
> > ever fire on that IRQ, and thus no data is collected.
> >
> > I tested on a 2420/H4 and 2430SDP with same results.  In both cases, the
> > IRQ is configured to IRQ3, which in the TRM says 'BENCH MPU emulation'.
> >  I have no idea what that means, but it doesn't sound like the ARM11 PMU
> > interrupt to me though.
> >
> > Any ideas?
> >
> > Kevin
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
