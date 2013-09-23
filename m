From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v3 5/5] dma: cppi41: add support for suspend and resume
Date: Mon, 23 Sep 2013 07:53:11 +0200
Message-ID: <523FD747.8060304@gmail.com>
References: <1379861404-8250-1-git-send-email-zonque@gmail.com> <1379861404-8250-6-git-send-email-zonque@gmail.com> <20130923040947.GV17188@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:46160 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab3IWFxP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Sep 2013 01:53:15 -0400
In-Reply-To: <20130923040947.GV17188@intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, sergei.shtylyov@cogentembedded.com, dan.j.williams@intel.com, balbi@ti.com, gregkh@linuxfoundation.org

On 23.09.2013 06:09, Vinod Koul wrote:
> On Sun, Sep 22, 2013 at 04:50:04PM +0200, Daniel Mack wrote:

>> +#ifdef CONFIG_PM_SLEEP
> ahhhh
>=20
>> +static int cppi41_suspend(struct device *dev)
>> +{
>> +	struct cppi41_dd *cdd =3D dev_get_drvdata(dev);
>> +
>> +	cppi_writel(0, cdd->usbss_mem + USBSS_IRQ_CLEARR);
>> +	disable_sched(cdd);
>> +
>> +	return 0;
>> +}
>> +
>> +static int cppi41_resume(struct device *dev)
>> +{
>> +	struct cppi41_dd *cdd =3D dev_get_drvdata(dev);
>> +	int i;
>> +
>> +	for (i =3D 0; i < DESCS_AREAS; i++)
>> +		cppi_writel(cdd->descs_phys, cdd->qmgr_mem + QMGR_MEMBASE(i));
>> +
>> +	init_sched(cdd);
>> +	cppi_writel(USBSS_IRQ_PD_COMP, cdd->usbss_mem + USBSS_IRQ_ENABLER)=
;
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(cppi41_pm_ops, cppi41_suspend, cppi41_resu=
me);
> Here is the macro in pm.h

[...]

> Now since you are using the macro there should be no need to wrap ifd=
ef around
> your code, the macro will take care of it.

Well yes, which is why I put the macro itself *outside* of the #ifdef
block. Without that #ifdef, however, and with CONFIG_PM_SLEEP unset, I =
get:

drivers/dma/cppi41.c:1043:12: warning: =91cppi41_suspend=92 defined but=
 not
used [-Wunused-function]
 static int cppi41_suspend(struct device *dev)
            ^
drivers/dma/cppi41.c:1053:12: warning: =91cppi41_resume=92 defined but =
not
used [-Wunused-function]
 static int cppi41_resume(struct device *dev)
            ^

=2E.. which doesn't surprise me much. Or do I still not get your point?


Thanks,
Daniel

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
