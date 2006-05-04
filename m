From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP: Fix tlv320aic23.c
Date: Thu, 4 May 2006 07:51:44 -0700
Message-ID: <200605040751.45417.david-b@pacbell.net>
References: <4452384E.7080409@gmail.com> <20060503125606.GG30376@atomide.com>
	<4458F966.40504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <4458F966.40504@gmail.com>
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

On Wednesday 03 May 2006 11:41 am, Dirk Behme wrote:

> WARNING: "usb_disconnect" [drivers/usb/host/ohci-hcd.ko]
> undefined!

Of course, it hasn't been exported for a while now.


> ...
> 
> Any ideas about USB? Seems that it comes from
> drivers/usb/host/ohci-omap.c

I see a curious and pointless routine, ohci_omap_host_enable(), which
isn't called from anywhere I can see, which wants usb_disconnect().

Try deleting that routine.

- Dave
