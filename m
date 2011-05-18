From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3] ARM: omap4: i2c reset regs postidle
Date: Wed, 18 May 2011 16:09:01 +0200
Message-ID: <87oc30t81u.fsf@ti.com>
References: <4DD15BD5.9010303@ti.com>
	<1305624381-22524-1-git-send-email-j.weitzel@phytec.de>
	<8762p94dr6.fsf@ti.com> <1305724078.6272.24.camel@lws-weitzel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:34052 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932648Ab1EROJT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 10:09:19 -0400
Received: by mail-ww0-f47.google.com with SMTP id 4so1617937wwk.28
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 07:09:17 -0700 (PDT)
In-Reply-To: <1305724078.6272.24.camel@lws-weitzel> (Jan Weitzel's message of
	"Wed, 18 May 2011 15:07:58 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: J.Weitzel@phytec.de
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, andy.green@linaro.org, patches@linaro.org, andy@warmcat.com, tony@atomide.com, peter.maydell@linaro.org, ben-linux@fluff.org

Jan Weitzel <J.Weitzel@phytec.de> writes:

> Am Dienstag, den 17.05.2011, 16:12 +0200 schrieb Kevin Hilman:
>> Jan Weitzel <j.weitzel@phytec.de> writes:
>> 
>> > omap4430 get i2c timeouts at each access after an NACK message.
>> > OMAP_I2C_FLAG_RESET_REGS_POSTIDLE fix it.
>> 
>> We need a little better changelog here.  Specifically, *why* does this
>> flag fix the problem?   What exactly is going wrong such that this fix
>> is needed.
>> 
>> Does this happen all the time?  only when off-mode is used?  etc.
> Yes all time. i2cdetect say "controller timed out" every two adresses.
>
>> Looking closer at how this flag is used in the driver, I think the
>> driver's usage of runtime PM is a bit broken.  I'm not sure if it's
>> related to this problem, but I'll send a short series in a little bit to
>> clean up the runtime PM usage, and get rid of the dev->idle flag which
>> duplicates usage counting already provided by runtime PM.
> In the isr OMAP_I2C_STAT_NACK set OMAP_I2C_CON_REG to OMAP_I2C_CON_STP,
> clearing all other flags. Maybe this is wrong?
>
> On OMAP3 the OMAP_I2C_CON_REG flags are set again in the
> OMAP_I2C_FLAG_RESET_REGS_POSTIDLE path of omap_i2c_unidle.
> I am not sure if this is also the right place for OMAP4 

Right, and I'm not sure either.  That's why we need a better
explanation/changelog about exactly what is happening and why this is
the right fix.

Kevin
