From: Bryan Wu <bryan.wu@analog.com>
Subject: Re: [PATCH] [MUSB] musb_hdrc: disable sending PING packet in host
	mode.
Date: Fri, 21 Dec 2007 11:01:51 +0800
Message-ID: <1198206111.6693.16.camel@roc-laptop>
References: <1198159845.6319.1.camel@roc-laptop>
	<200712201457.34851.david-b@pacbell.net>
Reply-To: bryan.wu@analog.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200712201457.34851.david-b@pacbell.net>
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
Cc: linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


On Thu, 2007-12-20 at 14:57 -0800, David Brownell wrote:
> On Thursday 20 December 2007, Bryan Wu wrote:
> > From: Bryan Wu <bryan.wu@analog.com>
> > Date: Thu, 20 Dec 2007 15:25:34 +0800
> > Subject: [PATCH] [MUSB] musb_hdrc: disable sending PING packet in host
> > mode.
> > 
> > Some High Speed USB stick does not answer PING pakcet correctly, so
> > the USB enumeration will fail in MUSB host mode.
> > 
> > Disable using PING packet in host mode, almost all the USB stick
> > enumeration is OK on Blackfin BF54x/BF52x platform. I hope this is
> > a common problem in other MUSB platform.
> > 
> > This bug is tracked here:
> > https://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_id=141&tracker_item_id=3778
> 
> The referenced PNG images aren't listed in that bug report.  :)
> 

The bug was reported by a customer and I also found a USB stick
reproducing the bug. So the PNG pictures were attached in our forum at
following URL:
https://blackfin.uclinux.org/gf/project/uclinux-dist/forum/?action=ForumBrowse&forum_id=39&_forum_action=ForumMessageBrowse&thread_id=24780


> 
> > Signed-off-by: Bryan Wu <bryan.wu@analog.com>
> > ---
> >  drivers/usb/musb/musb_host.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> > index 2ad2ed9..34a2991 100644
> > --- a/drivers/usb/musb/musb_host.c
> > +++ b/drivers/usb/musb/musb_host.c
> > @@ -1112,6 +1112,8 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
> >                                 csr = MUSB_CSR0_H_STATUSPKT
> >                                         | MUSB_CSR0_TXPKTRDY;
> >  
> > +                       csr |= MUSB_CSR0_H_DIS_PING;
> > +
> 
> Is PING actually allowed for control endpoints?  I'm not
> entirely sure this wouldn't be a case of "make the driver
> follow the specs"... don't have time just now to check
> what the USB 2.0 spec says.
> 

Yes, according to USB 2.0 spec, the control and bulk endpoints of
High-Speed devices should answer NAK/ACK to PING packet. I think the
MUSB driver follows the spec without my patch. But some USB sticks are
not follows this, the control endpoint never answer ACK to PING, always
NAK. This endless NAK will be stopped by MUSB upper USB stack by
resetting. So this kind USB sticks can not enumerate with MUSB driver.

I test the same problem USB sticks on Linux PC host. There is no PING
for control endpoint.
Because in EHCI spec, there is a status bit named PING status bit in the
qTD.  You can found it in Section 4.11 "Ping Control" of the EHCI spec.
EHCI HCD can choose ping or not.

Do you know how to decide to ping or not in MUSB?
I have an idea: the USB_NAKLIMIT0 should be set to some value, when we
got NAK timeout interrupt, we can disable PING. When enumerating normal
USB stick, there is no NAK timeout, because PING is efficient for
handshaking. While problem USB stick will generate NAK timeout
interrupt, we disable PING for this kind of USB device enumeration.

Thanks
Regards,
-Bryan
