From: "Foale, Jeff" <j-foale@ti.com>
Subject: RE: OMAP2430: MUSB: Ethernet Gadget Issue
Date: Wed, 5 Dec 2007 16:10:53 -0600
Message-ID: <F3AC19E99E5D024AB9E6FB2A01683D8A02D46D68@dlee10.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


I noticed some comments in the musb_gadget.c code:

		/* REVISIT for high bandwidth, MUSB_TXCSR_P_INCOMPTX
		 * probably rates reporting as a host error
		 */
The MUSB_TXCSR_P_INCOMPTX flag is set on the bad transfer. It seems to
not be handled correctly (at all).

Jeff



-----Original Message-----
From: Foale, Jeff=20
Sent: Thursday, November 29, 2007 2:04 PM
To: 'David Brownell'; linux-omap-open-source@linux.omap.com
Subject: RE: OMAP2430: MUSB: Ethernet Gadget Issue

We discovered the root cause is that on the OMAP TX side, a DMA transfer
is initiated but never completes due to the completion interrupt never
happening.

We still do not know why the interrupt doesn't happen.

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
David Brownell
Sent: Friday, November 23, 2007 2:27 PM
To: linux-omap-open-source@linux.omap.com
Subject: Re: OMAP2430: MUSB: Ethernet Gadget Issue

Your test scenario sounds not unlike the "run TTCP in both
directions" test, except that it uses UDP.  The last time
I ran that test with the MUSB code was with DaVinci ... at
that time, it worked OK.  That's older RTL than found in
the OMAP chips, and thus "different bugs".

Not entirely for kicks, it would be good to know whether
the use of TTCP vs your test program matters.  TCP does
have some flow control, afster all!


On Wednesday 21 November 2007, Hunter, Jon wrote:
>	=20
> When I run the applications one at a time, they will run all night and
> all is well. However, when I run them at the same time the transfer
will
> stop after anywhere from a few secs to a few minutes. When the
transfers
> stop I observe the the MUSB driver is no longer generating interrupts
> (viewing the /proc/interrupts). It appears to be some short of race
> condition but I have not been able to track down exactly when things
> stop.

A "cat /proc/driver/musb_hdrc" to see various state should
be informative.

- Dave




_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
