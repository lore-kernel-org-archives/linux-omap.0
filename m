From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] MUSB HSET driver
Date: Wed, 23 May 2007 03:02:14 -0700
Message-ID: <200705230302.15259.david-b@pacbell.net>
References: <5DF83221BE20114E9C331F665ACBC0800305CC70@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5DF83221BE20114E9C331F665ACBC0800305CC70@dbde01.ent.ti.com>
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
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


> >A much cleaner approach is to just do this in userspace with
> >usbfs ... issuing control requests to the hub ports.  That
> >will work with *ANY* high speed controller.
> 
> I think Felipe Balbi will be looking into that aspect.
> 
> But how will that work for HSET tests with OPT card with OMAP as host.

The same way.  Those newish "key by VID/PID" test modes don't
do anything different ... they just change the user interface
for the test, so the (embedded) host requirements are even less.


> We still need to write a class driver that issues the TEST command
> to hub based on VID/PID sent by OPT. And that is what I am proposing. 
> Comments please.

Just look at the device IDs through usbfs, and use that to
decide what root hub USB_PORT_FEAT_TEST to set.  If you need
any ULPI stuff to implement those features, that should be
part of the root hub code.  (I can imagine that different
integrations of the hdrc core might have slightly different
requirements there, implying a platform hook...)

That is, you shouldn't need a kernel driver to do that stuff.

- Dave
