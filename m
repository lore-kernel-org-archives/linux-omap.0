From: Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH] Fix USB host on 1510/5910?
Date: Tue, 28 Mar 2006 20:05:19 +0100
Message-ID: <20060328190519.GS26949@earth.li>
References: <20060328164403.GL26949@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060328164403.GL26949@earth.li>
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

On Tue, Mar 28, 2006 at 05:44:03PM +0100, Jonathan McDowell wrote:
> I'm not quite sure if this is necessary or not. I've found I need it to
> get USB working correctly on the Amstrad E3, which is an OMAP5910. From
> my reading of ohci-omap.c usb_dc_ck is requested for the 1510 as well,
> and if it can't be obtained an error is returned.
> 
> Does anyone have USB working correctly on a 1510/5910 with latest git
> without something like the below?

Scratch that for the moment. I'm now getting:

ohci ohci: Unlink after no-IRQ?  Controller is probably using the wrong IRQ.

even with this patch, whereas it worked fine for 2.6.15-omap1.

I'd still like to know if anyone's having success with a 1510/5910 and
latest git though, as I've had someone else tell me they were seeing
similar problems on a platform that wasn't the E3 (unfortunately it was
on IRC and I don't have their details. :( ).

J.

-- 
 [           noodles is almost a national pastime in japan            ]
 [ http://www.blackcatnetworks.co.uk/ - IPv6 enabled ADSL/dialup/colo ]
