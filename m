From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] USB: Fix OTG HNP for hub.c
Date: Tue, 29 May 2007 14:26:46 -0700
Message-ID: <20070529212646.GE27603@atomide.com>
References: <11804401622277-git-send-email-felipebalbi@users.sourceforge.net>
	<31e679430705291224h5f1e8552paf8bff92f97f7f3f@mail.gmail.com>
	<20070529203458.GB27603@atomide.com>
	<200705291411.01343.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200705291411.01343.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070529 14:11]:
> On Tuesday 29 May 2007, Tony Lindgren wrote:
> > * Felipe Balbi <felipebalbi@users.sourceforge.net> [070529 12:25]:
> > > Hi,
> > >
> > > On 5/29/07, David Brownell <david-b@pacbell.net> wrote:
> > >> On Tuesday 29 May 2007, Felipe Balbi wrote:
> > >> > From: Tony Lindgren <tony@atomide.com>
> > >> >
> > >> > This patch makes makes OTG Host Negotiation Protocol (HNP)
> > >> > to behave.
> > >>
> > >> Not really.  It makes it strongly *MIS* behave in fact,
> > >> since it always kicks off HNP ... even when it should not
> > >> do so, because the device is in the whitelist.  (Called
> > >> the "Targeted Peripherals List", TPL, in jargonese.)
> > >>
> > >> The two blocks of code are in the wrong order ...
> > 
> > Hmm, are you sure about that? My patch is based on
> > USB_TG_1-3.pdf and playing with usbcv13.exe and two N800s.
> > 
> > I'm under the impression that if the peripheral supports HNP, the
> > host must offer HNP at least once during the session.
> 
> See section 6.8.1.4 of the OTG 1.2 spec which says that the A-device
> first sets up communication with the B-device, when it's on the TPL.
> 
> You might be thinking about the later part of 6.8.1.4 which says
> that "before ending the session" the A-device gives the B-device
> an opportunity to be the master.  That may be a "new" requirement,
> added by OTG 1.2 and not in OTG 1.0a.  But in any case, that's
> after having done normal "work" (if any).

But HNP can also be offered early in addition to autosuspend
(which I have missed). Does "sets up communications with b-device"
really mean use it as a peripheral? Or does it mean set up
communications to configure b-device?

If the b-device has b_host mode enabled, it does not want to be
a peripheral at that point.

> The mechanism for that is to enter the A_SUSPEND state after
> enabling HNP.  Right now I'd expect autosuspend to make that
> happen ... that's a new mechanism, we may need to re-evaluate
> stting B_HNP_ENABLE that early.
> 
> 
> > And as I understand, the whitelist is for peripherals the host
> > supports, with HNP or no HNP.
> 
> Yes ... and see 6.8.1.4 too.  Devices NOT on the whitelist get
> the A_BUS_REQ = FALSE treatment, triggering HNP or disconnect.
> 
> But ones on the whitelist keep A_BUS_REQ = TRUE until they're
> done getting work done.

Yes, I still don't see a conflict with my patch and 6.8.1.4,
if we assume communcations with b-device means just configure it.

> > With my patch, we offer to do HNP right in the beginning of the
> > session. Then the peripheral can use it or not use depending if
> > HNP is enabled on peripheral.
> 
> There are two requirements.  For HNP the only requirement is to
> try it by the end of the session.  But for devices that have not
> been blacklisted, there's another requirement:  first, set up
> normal communication with that peripheral.

Hmmm, I ended up doing it this way to get usbcv13.exe OTG tests
to pass. I guess it boils down what "sets up communication with
b-device" means.

> > >> A more limited patch would help.  Specifically, just
> > >> fixing whatever bug was seen in the original code,
> > >> rather than abstracting it into a new subroutine and
> > >> changing the logic while doing so.
> > 
> > Dave, did you ever get HNP working with any device and test
> > it with usbcv13.exe and OPT?
> 
> HNP was certainly working on H2 back around 2.6.10/11 using
> the original OPT ... that's before usbcv13.exe or the very
> latest (mucho expensivo, high speed capable) OPT hardware.

OK, that's good to hear.

> I believe the OMAP tree has code changes in isp1301_omap (from
> TI) which allegedly made it work on H3, but broke it on H2.
> (The OMAP1 OTG core changed a bit between OMAP 1611 and 1710.)
> Those changes have not yet gone upstream, on the grounds that
> they'd be a regression.
> 
> I may take that H2 out of storage and see how it behaves
> on current kernels ... it's possible that usbcore changes
> have broken that support.

Yeh, I suspect it will fail at least usbcv13.exe OTG tests.

Regards,

Tony
