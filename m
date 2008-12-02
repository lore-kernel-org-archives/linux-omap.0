From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] TVP514x Driver with Review comments fixed
Date: Tue, 2 Dec 2008 00:26:29 -0800
Message-ID: <200812020026.29996.david-b@pacbell.net>
References: <19F8576C6E063C45BE387C64729E739403E904F18D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:43924 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750977AbYLBI0c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 03:26:32 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E739403E904F18D@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "davinci-linux-open-source-bounces@linux.davincidsp.com" <davinci-linux-open-source-bounces@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Jadav, Brijesh R" <brijesh.j@ti.com>, "Shah, Hardik" <hardik.shah@ti.com>, "Hadli, Manjunath" <mrh@ti.com>, "R, Sivaraj" <sivaraj@ti.com>, "Karicheri, Muralidharan" <m-karicheri2@ti.com>

On Monday 01 December 2008, Hiremath, Vaibhav wrote:
> [Hiremath, Vaibhav] We are almost on same page, but you are looking
> to implement this in probe function where we do have "id" straight
> coming as params.  

Yes ... you can't initialize the device before probe() since you
don't have the i2c_client handle.  And you mustn't initialize it
later, since you'll have registered the codec and other code will
expect it to be fully functional.

You could of course power the chip down, and then need to reinit
it later.  That should be a simple matter of making sure that the
chip setup logic is packaged so it can be called from probe() and
from whatever other routines need it.


> But for the devices like OMAP where power management is critical
> thing, I want to put the TVP to off state and bring it again whenever
> required (being used). For this, we do have ioctl interface called "
> ioctl_s_power" under V4L2-Int framework.    

Why would that be trouble though?  Just do it ...


> To get the sequence supported for registered chip (46/47/4xM), I need
> index under the I2C_table (client->driver->id_table[index]) which will
> give me the driver_data for registered chip.  

There I'm not following you *at all* ... is the issue that
for some reason v4l2_int_dev.priv can't just hold your
instance-specific structure? 

Remember I'm more on top of I2C stuff than V4L2, so if this
is really a V4l2 question I'm not the best person to answer.

In the I2C context, all the information you need can be
handed to you using id->driver-data, as I sketched earlier,
so the problem seems to be how to use (a) chip descriptors,
e.g. 46/46m2/47/47m1 differences, from id_driver_data; plus
(b) board descriptors, from i2c_client.dev.platform_data;
to create (c) an instance-specific driver structure which
exposes this v4l2 video decoder.  I've described (a) and (b),
and will defer to you and your colleagues on (c).

- Dave



