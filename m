From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix usb gadget related compile errors and
	typo
Date: Thu, 1 Nov 2007 02:00:36 -0700
Message-ID: <20071101090036.GC780@atomide.com>
References: <47263ACA.8010001@googlemail.com>
	<20071029201114.0CD6B4A69D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<47275DDC.7060002@googlemail.com>
	<200710301000.59813.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200710301000.59813.david-b@pacbell.net>
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

* David Brownell <david-b@pacbell.net> [071030 10:15]:
> On Tuesday 30 October 2007, Dirk Behme wrote:
> > gadget_is_otg() is defined as
> > 
> > static inline int gadget_is_otg(struct usb_gadget *g) { ...
> > 
> > and the call is
> > 
> > gadget_is_otg(udc->gadget)
> > 
> > Which fix do you propose for this?
> 
> http://marc.info/?l=linux-usb-devel&m=119343277601632&w=2
> 
> which is in the USB patch queue ... I thought I saw it
> get sent to Linus recently, but maybe not.  It's not
> in the kernel.org tree yet, unfortunately.

Pushing Dave's fix today.

Tony
