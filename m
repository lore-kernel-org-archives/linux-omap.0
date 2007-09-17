From: "arun c" <arun.edarath@gmail.com>
Subject: Re: PRCM settings
Date: Mon, 17 Sep 2007 13:23:45 +0530
Message-ID: <c656a4d20709170053o680f08b5o46161f897d031bd3@mail.gmail.com>
References: <c656a4d20709140331p3150b1f4q5e211ed9bc784930@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901E0CDBA@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742901E0CDBA@dlee13.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 9/14/07, Woodruff, Richard <r-woodruff2@ti.com> wrote:
> > I use 2430 sdp board.
> >
> > My ram grade is 133. Can i use PRCM 5a configuration in
> > X-loader sucessfully?? or i must use some ratio with a
> > ram grade less than 133(like PRCM #3)??
>
> Yes 5a is fine and will give you maximum DDR performance.
>
> One good point about #5a over #3 is the CPU to memory ration for #5a is 1-to-2 instead of 1-to-3 like in #3.  Depending on your system it might be more important to have a faster DDR as compared to faster processor speed.
>
> Though you would not be doing it with the above, it has been my experience that DDR usually over clocks pretty well at nominal temperatures.  So it is likely #2 (best non-bin'ed speed) would function for performance testing.
>
> Regards,
> Richard W.
>
>
Hi,

But the problem is that on my board kernel is not booting with PRCM #5a with
ramdisk (My board is 2430 sdp with pop memory).
Board boots fine with nfs. But as its not booting with ramdisk @133
i fear to use this speed to avoid any run time corruptions.

So i reduced core clock freq from 532 to 494(fref=13 so my dpll equ is
core_clock=(26*266)/(13+1)). With this reduced clock and L3 running at 123Mhz
everything is working fine.

That's why i asked, for ram grade 133 whether we must use speed (L3 clock)
less than 133?? ... Or it is some other problem like u-boot
uncompression problem??

When i boot with L3 @133MHz with ramdisk i see upto this on console
then nothing.
(Ramdisk is at 0x81600000 size 4M)
# bootm

                Booting image at 80000000 ...
                        Image Name:   Linux-2.6.19-omap1
                        Image Type:   ARM Linux Kernel Image (uncompressed)
                        Data Size:    1241932 Bytes =  1.2 MB
                        Load Address: 80008000
                        Entry Point:  80008000
                        Verifying Checksum ... OK
                Starting kernel ...

                Uncompressing
Linux...........................................................
                .....................................................
done, booting the kernel.



Regards
Arun
