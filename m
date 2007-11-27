From: David Brownell <david-b@pacbell.net>
Subject: Re: [Question] Can g_midi run on musb_gadget?
Date: Tue, 27 Nov 2007 01:16:34 -0800
Message-ID: <200711270116.34801.david-b@pacbell.net>
References: <1196136265.7177.17.camel@roc-laptop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1196136265.7177.17.camel@roc-laptop>
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
To: bryan.wu@analog.com
Cc: Ben Williamson <ben.williamson@greyinnovation.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Monday 26 November 2007, Bryan Wu wrote:
> Hi folks,
> 
> I am still testing and trying to enable some gadget drivers over
> musb_gadget driver for Blackfin BF54x.
> 
> Does someone test g_midi over MUSB gadget driver?

Not I.


> Actually, current g_midi only supports full speed, then the MUSB gadget
> will make g_midi usb_gadget_register_driver (in musb_gadget.c) function
> call fail as below:

Which is appropriate, it only has full speed descriptors.

Feel free to submit a patch teaching it how to do high speed...

- Dave
