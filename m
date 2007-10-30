From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP: Fix usb gadget related compile errors and
	typo
Date: Tue, 30 Oct 2007 10:00:59 -0700
Message-ID: <200710301000.59813.david-b@pacbell.net>
References: <47263ACA.8010001@googlemail.com>
	<20071029201114.0CD6B4A69D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<47275DDC.7060002@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <47275DDC.7060002@googlemail.com>
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
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 30 October 2007, Dirk Behme wrote:
> gadget_is_otg() is defined as
> 
> static inline int gadget_is_otg(struct usb_gadget *g) { ...
> 
> and the call is
> 
> gadget_is_otg(udc->gadget)
> 
> Which fix do you propose for this?

http://marc.info/?l=linux-usb-devel&m=119343277601632&w=2

which is in the USB patch queue ... I thought I saw it
get sent to Linus recently, but maybe not.  It's not
in the kernel.org tree yet, unfortunately.

- Dave
