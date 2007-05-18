From: "Josh Ostrander" <jostrand@gmail.com>
Subject: Re: Bridge vs DSP/BIOS Link
Date: Fri, 18 May 2007 13:14:56 -0400
Message-ID: <8f4c83bc0705181014w58887aa7x263ab85f2fc876d0@mail.gmail.com>
References: <3B6D69C3A9EBCA4BA5DA60D913027429FD0A30@dlee13.ent.ti.com>
	<464B2F9C.8010100@css-design.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <464B2F9C.8010100@css-design.us>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Thnaks for the insight and the quick responses!  I am leaning more
twords using the DSP/BIOS Link since our application will have very
basic needs for communicating with the dsp.  Just load/unloading DSP
images and message/streaming data control between the GPP and DSP.

Although I am intrigued by the DSP Node structure that you get with
DSPBridge.  If I had more complicated GPP/DSP needs I would probably
be leaning towards that.

On 5/16/07, Steve Poulsen <spoulsen@css-design.us> wrote:
> Josh,
>
> Based on experience with the two, the piece that I would add is this.
>
> There seems to be two packages that you can go download now for the OMAP
> (5912 to be specific, but others' experience may vary).
>
> DSP/BIOS Link (ARM and DSP code):
>
> I was able to download the software and for the most part get it
> going.   There were pieces missing (invalid links for components in the
> docs) and getting it to work for Linux 2.6 required several
> modifications.  In the end, it seems to be a good low-level (relatively
> speaking) method for sending messages.
>
> DSP Bridge (ARM and DSP code):
>
> This code is also available (DSP gateway per Richard's response) and
> seems to be a very different approach.  I did some looking into it and
> it seemed too complex for our needs.   I also had some concern as to how
> the DSP memory map was exposed, but I did not follow up through this
> much because of the first problem.
>
> In short, I came to the conclusion that to get either one of them
> working on the board requires a substantial effort.  DSP/BIOS Link
> required changes just to get it to build and more to make it not crash.
> I expect DSP Bridge may be more up-to-date, but it still is a large
> piece of software so there should be some effort here to learn about
> it.   You could get lucky with it and have things go quickly and
> smoothly, but I would not count on it.   Finally, after much time on
> both of these, we developed our own custom messaging using the
> mailboxes.  For our single-application system, this seemed to be the
> best approach, without much overhead.
>
> BTW, the OMAP patched kernel for 2.6 includes the bridge.   I have not
> fully tested it, but the parts that I have (init, mmu, clocks), seem to
> work well.
>
> Steve
>
>
> Woodruff, Richard wrote:
> >> Curious if anyone knows what the difference is between the
> >> DSPBridge OMAP DSP driver and the DSP/BIOS Link driver.  I
> >> did see a question posted about a year ago on this mailing
> >> list but sadly there was no response.  This is what I know:
> >>
> >
> > Well a complete answer is to much to write and I wouldn't do it justice
> > as I don't know the whole picture.  But in short:
> >
> > Give OMAPs ARM+DSP/s architecture TI has done reference implementations
> > of bridge and link for the major operating systems as required by
> > demand.
> >
> > Bridge came first.  The bridge framework and associated pieces go up
> > high into an OS and do some media management aspects.  There are bridge
> > pieces on the ARM side and the DSP side (in addition to DSP BIOS).  The
> > sum of this is a large and complex package aimed at rich multimedia,
> > codec's and the like all fall in here as well.  If you look at
> > http://www.khronos.org/ you get the idea of what gets logically bundled
> > with full solution (OpenMax, ...).
> >
> > For some customers bridge and upper related layers were to much given
> > their needs.  For these customers a "link" was created it does many of
> > the lower layers of the bridge function.  It doesn't try and integrate
> > as high up and doesn't provide the same level of features.
> >
> > For Linux reference bridges do exist and they have evolved over time.
> > Customers have used this either directly or as a reference in
> > implementations of their own bridges.  Links also do exist for Linux.
> > If you look inside products you likely will find a few different ones
> > about.  At the bottom they are similar as you go up and they integrate
> > in to multimedia they diverge.
> >
> > The low layer concepts between the bridges are similar.  The use of
> > mailbox hardware to exchange messages, idea of a DSP at the other end
> > likely running DSP BIOS, DSP-MMU usage, you need to
> > init/load/create&control-xmit-recv-data-streams.  Across OMAP1-2-3 the
> > DSP block's capabilities have been going up.  So you find the upper
> > layers of the bridge growing.
> >
> > Nokia did contribute their version of bridge/link a couple years back
> > (dspgateway).  This is used in their 770 and 800 products.
> >
> > Hope that helps.
> >
> > Regards,
> > Richard W.
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
> >
>
>
