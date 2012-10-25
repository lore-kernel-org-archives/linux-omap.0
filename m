From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 7/8] i2c: add 'transferred' field to struct i2c_msg
Date: Thu, 25 Oct 2012 15:42:02 +0200
Message-ID: <20121025154202.41f3cbba@endymion.delvare>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
	<1350899218-13624-8-git-send-email-balbi@ti.com>
	<20121025145748.760c218b@endymion.delvare>
	<20121025131459.GG28061@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:4359 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965376Ab2JYNmX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 09:42:23 -0400
In-Reply-To: <20121025131459.GG28061@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, w.sang@pengutronix.de, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-i2c@vger.kernel.org, ben-linux@fluff.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Thu, 25 Oct 2012 14:14:59 +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 25, 2012 at 02:57:48PM +0200, Jean Delvare wrote:
> > Hi Felipe, Shubhrajyoti,
> > 
> > On Mon, 22 Oct 2012 12:46:57 +0300, Felipe Balbi wrote:
> > > From: Shubhrajyoti D <shubhrajyoti@ti.com>
> > > 
> > > In case of a NACK, it's wise to tell our clients
> > > drivers about how many bytes were actually transferred.
> > > 
> > > Support this by adding an extra field to the struct
> > > i2c_msg which gets incremented the amount of bytes
> > > actually transferred.
> > > 
> > > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > >  include/uapi/linux/i2c.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
> > > index 0e949cb..4b35c9b 100644
> > > --- a/include/uapi/linux/i2c.h
> > > +++ b/include/uapi/linux/i2c.h
> > > @@ -77,6 +77,7 @@ struct i2c_msg {
> > >  #define I2C_M_NO_RD_ACK		0x0800	/* if I2C_FUNC_PROTOCOL_MANGLING */
> > >  #define I2C_M_RECV_LEN		0x0400	/* length will be first received byte */
> > >  	__u16 len;		/* msg length				*/
> > > +	__u16 transferred;	/* actual bytes transferred             */
> > >  	__u8 *buf;		/* pointer to msg data			*/
> > >  };
> > 
> > On the principle I am fine with this, however you also need to define
> > who should initialize this field, and to what value.
> 
> You also miss one very very very big point.  This will break every I2C
> using userspace program out there unless it is rebuilt - this change will
> require the exact right version of those userspace programs for the
> kernel that they're being used on.

How that? The extra field is added in a hole, so we don't change the
struct size nor the relative positions of existing fields. Why would
user-space care?

-- 
Jean Delvare
