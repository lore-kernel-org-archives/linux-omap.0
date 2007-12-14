From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH Resend 2/3] ARM: OMAP: Add support for TWL4030 USB
 Transceiver on OMAP34xx
Date: Fri, 14 Dec 2007 09:57:41 -0800
Message-ID: <20071214175741.2B1761667CD@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <010C7BAE6783F34D9AC336EE5A01A088050666B7@dbde01.ent.ti.com>
	<ade8ea70e5b901631efb9478f651600a@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <ade8ea70e5b901631efb9478f651600a@felipebalbi.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: me@felipebalbi.com, gadiyar@ti.com
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > +				printk(KERN_ERR "twl4030_usb: i2c write failed,"
> > +						"line %d\n", __LINE__);
>
> The second line has no log level defined. Change it to:
> 				printk(KERN_ERR "twl4030_usb: i2c write failed,"
> 					KERN_ERR "line %d\n", __LINE__);

No, don't change.  But do add the missing space after the comma.

The message should not come out as "... failed,<3>line..." 
