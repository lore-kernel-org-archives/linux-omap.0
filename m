From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Fri, 19 Oct 2012 17:56:48 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210191752210.14522@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com> <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com> <20121019170149.GG1493@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52304 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab2JSR4t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 13:56:49 -0400
In-Reply-To: <20121019170149.GG1493@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Felipe,

On Fri, 19 Oct 2012, Felipe Balbi wrote:

> On Fri, Oct 19, 2012 at 04:55:38PM +0000, Paul Walmsley wrote:
> > On Thu, 18 Oct 2012, Paul Walmsley wrote:
> > 
> > > Here are some basic OMAP test results for Linux v3.7-rc1.
> > > Logs and other details at http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/
> > 
> > > Failing tests: needing investigation
> > > ------------------------------------
> > >
> > > Boot tests:
> > 
> > * 3530ES3 Beagle: I2C timeouts during userspace init
> >   - May be related to the threaded IRQ conversion of the I2C driver
> >   - Unknown cause
> 
> Doesn't seem like it's related to threaded IRQ. It says:
> 
> [   23.673858] omap_i2c omap_i2c.1: timeout waiting for bus ready
> 
> at that time we didn't even program the transfer yet, meaning we're not
> even on wait_for_completion_timeout() inside omap_i2c_xfer_msg(). This
> happens before:
> 
> > static int omap_i2c_wait_for_bb(struct omap_i2c_dev *dev)
> > {
> > 	unsigned long timeout;
> > 
> > 	timeout = jiffies + OMAP_I2C_TIMEOUT;
> > 	while (omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG) & OMAP_I2C_STAT_BB) {
> > 		if (time_after(jiffies, timeout)) {
> > 			dev_warn(dev->dev, "timeout waiting for bus ready\n");
> 
> it' stopping here. And that's called...
> 
> > 			return -ETIMEDOUT;
> > 		}
> > 		msleep(1);
> > 	}
> > 
> > 	return 0;
> > }
> 
> [...]
> 
> > static int
> > omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
> > {
> > 	struct omap_i2c_dev *dev = i2c_get_adapdata(adap);
> > 	int i;
> > 	int r;
> > 
> > 	r = pm_runtime_get_sync(dev->dev);
> > 	if (IS_ERR_VALUE(r))
> > 		goto out;
> > 
> > 	r = omap_i2c_wait_for_bb(dev);
> 
> right here. For whatever reason, the bus is kept busy (or at least the
> driver thinks so).
> 
> Looking closely at the logs I see that definitely I2C was working during
> early boot (we managed to mount file system on SD card and twl got
> initialized properly). But then we have a long time where I2C isn't
> used, so it probably suspended in between.
> 
> Then RTC wanted to read a register, I2C woke up, restored context, but
> bus was kept busy, for whatever reason.
> 
> Does it happen all the time on multiple boots or is it ramdom ?

Just ran six boot tests here; it occurred in five of them.  Then tried 
five boot tests on v3.6 and the error didn't show up in any of them.  
Abbreviated log at the bottom.

Would be happy to send along a copy of the userspace that was used if it 
would be useful to you.


- Paul

paul@nozomi:~$ egrep '(version 3\.|timeout waiting)' 3530es3beagle_log.txt 
[    0.000000] Linux version 3.7.0-rc1 (paul@nozomi) (gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50) ) #1 SMP Wed Oct 17 20:58:00 MDT 2012
[    0.000000] Linux version 3.7.0-rc1 (paul@nozomi) (gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50) ) #1 SMP Wed Oct 17 20:58:00 MDT 2012
[   22.710418] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   23.726074] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    0.000000] Linux version 3.7.0-rc1 (paul@nozomi) (gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50) ) #1 SMP Wed Oct 17 20:58:00 MDT 2012
[   22.804351] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   23.819976] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    0.000000] Linux version 3.7.0-rc1 (paul@nozomi) (gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50) ) #1 SMP Wed Oct 17 20:58:00 MDT 2012
[   22.805419] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   23.821044] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    0.000000] Linux version 3.7.0-rc1 (paul@nozomi) (gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50) ) #1 SMP Wed Oct 17 20:58:00 MDT 2012
[   22.820648] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   23.836273] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    0.000000] Linux version 3.7.0-rc1 (paul@nozomi) (gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50) ) #1 SMP Wed Oct 17 20:58:00 MDT 2012
[   22.858978] omap_i2c omap_i2c.1: timeout waiting for bus ready
[   23.874603] omap_i2c omap_i2c.1: timeout waiting for bus ready
[    0.000000] Linux version 3.6.0 (paul@nozomi) (gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50) ) #1 SMP Wed Oct 17 20:42:23 MDT 2012
[    0.000000] Linux version 3.6.0 (paul@nozomi) (gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50) ) #1 SMP Wed Oct 17 20:42:23 MDT 2012
[    0.000000] Linux version 3.6.0 (paul@nozomi) (gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50) ) #1 SMP Wed Oct 17 20:42:23 MDT 2012
[    0.000000] Linux version 3.6.0 (paul@nozomi) (gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50) ) #1 SMP Wed Oct 17 20:42:23 MDT 2012
[    0.000000] Linux version 3.6.0 (paul@nozomi) (gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50) ) #1 SMP Wed Oct 17 20:42:23 MDT 2012

