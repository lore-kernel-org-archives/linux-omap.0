From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 01/23] I2C: TWL4030: checkpatch.pl fixes for
	twl4030-core.c
Date: Fri, 11 Apr 2008 12:11:08 +0300
Message-ID: <20080411091108.GB7338@gandalf.research.nokia.com>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com> <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com> <010C7BAE6783F34D9AC336EE5A01A08805D6500C@dbde01.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32813 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758450AbYDKJMP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 05:12:15 -0400
Content-Disposition: inline
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08805D6500C@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Fri, Apr 11, 2008 at 02:23:05PM +0530, ext Gadiyar, Anand wrote:
> >  static int __init twl4030_init(void)
> >  {
> > -	int res;
> > -
> > -	if ((res = i2c_add_driver(&twl4030_driver))) {
> > -		printk(KERN_ERR "TWL4030: Driver registration failed\n");
> > -		return res;
> > -	}
> > -
> > -	pr_info(KERN_INFO "TWL4030: Driver registration complete.\n");
> > -
> > -	return 0;
> > +	return i2c_add_driver(&twl4030_driver);
> >  }
> 
> You're losing the failure print here. Not sure if it matters, but I'm pointing it out anyway.

i2c subsystem will print it out for usb. No need to leave it here :)

if you follow i2c_add_driver, you'll get to
drivers/i2c/i2c-core.c:i2c_register_driver()

int i2c_register_driver(struct module *owner, struct i2c_driver *driver)
{

[...]

	mutex_lock(&core_lock);

	pr_debug("i2c-core: driver [%s] registered\n", driver->driver.name);

[...]

	return 0;
}

-- 
	- Balbi
