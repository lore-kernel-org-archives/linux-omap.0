From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/5] I2C: LM8323: Introduce lm8323 keypad driver
Date: Wed, 9 Apr 2008 21:05:58 +0300
Message-ID: <20080409180557.GA15913@kedavra.cpe.vivax.com.br>
References: <1207742644-6260-1-git-send-email-felipe.balbi@nokia.com> <1207742644-6260-2-git-send-email-felipe.balbi@nokia.com> <20080409121124.GS7338@gandalf.research.nokia.com> <fb249edb0804091026h796d373bn7ad2a58a2edb6e0d@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48629 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898AbYDISEK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 14:04:10 -0400
Content-Disposition: inline
In-Reply-To: <fb249edb0804091026h796d373bn7ad2a58a2edb6e0d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: andrzej zaborowski <balrogg@gmail.com>
Cc: felipe.balbi@nokia.com, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Stone <daniel.stone@nokia.com>

On Wed, Apr 09, 2008 at 07:26:31PM +0200, andrzej zaborowski wrote:

[...]


> >  +       time = strict_strtoul(buf, 10, &res);
> >  +       /* Numbers only, please. */
> >  +       if (buf && *buf != '\n' && *(buf + 1) != '\0')
> >  +               return -EINVAL;
> 
> The condition doesn't look correct, for example it rejects "55\n\0"
> but accepts NULL.

Well, this is not my driver and i just moved to strict_stroul cuz
checkpatch asked me to. I'll take a closer look tomorrow but if you can
come up with a better solution for this, I'll ack.

btw, good catch, i didn't had too much time to work on this but still
the driver is working fine.

> >  +       i2c_set_clientdata(client, lm);
> >  +       lm->client = client;
> >  +       lm8323_pdata = client->dev.platform_data;
> >  +       if (!lm8323_pdata)
> >  +               return -EINVAL; /* ? */
> 
> Here lm remains allocated and is lost.  Not that it bothers me, but
> probably not what was intended.

You mean the error handling?

if (!lm8323_pdata) {
	kfree(lm);
	return -EINVAL;
}

fixing tomorrow.

> >  +fail8:
> >  +       device_remove_file(&client->dev, &dev_attr_disable_kp);
> >  +fail7:
> >  +       free_irq(lm->irq, lm);
> >  +fail6:
> >  +       if (lm->pwm3.enabled)
> >  +               led_classdev_unregister(&lm->pwm3.cdev);
> >  +fail5:
> >  +       if (lm->pwm2.enabled)
> >  +               led_classdev_unregister(&lm->pwm2.cdev);
> >  +fail4:
> >  +       if (lm->pwm1.enabled)
> >  +               led_classdev_unregister(&lm->pwm1.cdev);
> >  +fail3:
> >  +fail2:
> >  +       kfree(lm);
> >  +       return err;
> >  +}
> ...
> 
> Question not really related to this patchset, but in the TSC2005
> driver some averaging and limit checks are done to the ADC values.
> Shouldn't that be done in userspace instead?  (The ADS784x and TSC2301
> drivers do the same evidently.)

Now that's not really up to me, but if we move it now it probably won't
provide the feature n810 needs. I mean, n810 is designed on top of the
features provided by driver, the application probably expects the driver
to do the averaging and limit checks so at least for tsc2005 I think
it's not a good idea to change due to application requirements.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
