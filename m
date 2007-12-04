From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/3] ARM: OMAP: User GPLv2 for MMU,
	make checkpatch.pl happier
Date: Tue, 4 Dec 2007 17:24:24 +0900
Message-ID: <20071204082424.GA25292@linux-sh.org>
References: <20071203222651.GE4105@atomide.com>
	<5d5443650712032234u4fca1546la246bd633cb1cb50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <5d5443650712032234u4fca1546la246bd633cb1cb50@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 04, 2007 at 12:04:25PM +0530, Trilok Soni wrote:
> On Dec 4, 2007 3:56 AM, Tony Lindgren <tony@atomide.com> wrote:
> > I'm preparing the MMU patches for submission to arm-linux mailing
> > list, and Paul Mundt requested changing the MMU license to be
> > GPLv2. Can you please take a look at the attached patch and ack?
> 
> Good to see that MMU fwk going mainline, but I am concerned about the
> users of MMU fwk as of now, dspgw looks like may not be accepted to
> mainline yet, and OMAP2 camera driver is still not using the MMU fwk
> for it's MMU and IVA driver is no where in sight, in this case I don't
> know what purpose MMU fwk will serve in mainline code?
> 
Whether the IVA stuff ever materializes or whether the dspgateway
implementation and the camera driver ever become useful to the point of
merging or not are pretty separate issues in this regard. The main thing
here is that by exposing coherent interfaces for the MMUs in these parts,
it's possible for people to actually do something with the underlying
peripherals (as far as mapping things in and out of their respective
address spaces, and so on). So I would consider it useful from a
peripheral enabling point of view wholly independently from the rest.

Practically speaking, the toolchain mess for IVA and the DSP already mean
that there are significant barriers for people being able to easily do
anything with these blocks openly, and if there were actual motivation
for that to happen by the vendors pushing this, it would have happened a
long time ago. It's worth providing as much of an open interface to
playing with these various blocks as possible just so people have the
option of doing _something_ with them.

Additionally, if such a thing is never integrated, there's also zero push
for getting the guilty parties (ie, OMAP2 camera driver) playing well
with others. At this point I think the MMU framework stands by itself,
and I think you're taking a fairly optimistic outlook if you believe the
other drivers will get cleaned up first -- especially as the current
situation is not so different from where things were a couple of years
ago :-)
