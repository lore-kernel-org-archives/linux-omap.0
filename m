From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [PATCH V4 3/6] OMAPDSS: DSS: Cleanup cpu_is_xxxx checks
Date: Mon, 20 Aug 2012 16:06:44 +0530
Message-ID: <CAF0AtAtePhxTsoCyatfXWR+e4sc3WHmg=Wq_ZXkowoGpOg63FA@mail.gmail.com>
References: <1344859176-4512-1-git-send-email-cmahapatra@ti.com>
	<1345115913-6773-1-git-send-email-cmahapatra@ti.com>
	<1345211692.3158.160.camel@deskari>
	<1345452124.2684.7.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:36565 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751100Ab2HTKgp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Aug 2012 06:36:45 -0400
Received: by vbkv13 with SMTP id v13so5993619vbk.0
        for <linux-omap@vger.kernel.org>; Mon, 20 Aug 2012 03:36:44 -0700 (PDT)
In-Reply-To: <1345452124.2684.7.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, Aug 20, 2012 at 2:12 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Fri, 2012-08-17 at 16:54 +0300, Tomi Valkeinen wrote:
>> On Thu, 2012-08-16 at 16:48 +0530, Chandrabhanu Mahapatra wrote:
>> > All the cpu_is checks have been moved to dss_init_features function providing a
>> > much more generic and cleaner interface. The OMAP version and revision specific
>> > initializations in various functions are cleaned and the necessary data are
>> > moved to dss_features structure which is local to dss.c.
>> >
>> > Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>>
>> > +static int __init dss_init_features(struct device *dev)
>> > +{
>> > +   dss.feat = devm_kzalloc(dev, sizeof(*dss.feat), GFP_KERNEL);
>> > +   if (!dss.feat) {
>> > +           dev_err(dev, "Failed to allocate local DSS Features\n");
>> > +           return -ENOMEM;
>> > +   }
>> > +
>> > +   if (cpu_is_omap24xx())
>> > +           dss.feat = &omap24xx_dss_features;
>> > +   else if (cpu_is_omap34xx())
>> > +           dss.feat = &omap34xx_dss_features;
>> > +   else if (cpu_is_omap3630())
>> > +           dss.feat = &omap3630_dss_features;
>> > +   else if (cpu_is_omap44xx())
>> > +           dss.feat = &omap44xx_dss_features;
>> > +   else
>> > +           return -ENODEV;
>> > +
>> > +   return 0;
>> > +}
>>
>> This is not correct (and same problem in dispc). You allocate the feat
>> struct and assign the pointer to dss.feat, but then overwrite dss.feat
>> pointer with the pointer to omap24xx_dss_features (which is freed
>> later). You need to memcpy it.
>>

Ok.

>> I also get a crash on omap3 overo board when loading omapdss:
>

During recent tests I never saw the crash happen. The kernel used to
freeze during booting after printing
"Uncompressing Linux... done, booting the kernel."

> The crash happens because dss_get_clocks uses the feat stuff, but the
> dss_init_features is only called later. Did you test this? I can't see
> how that can work on any board.
>

Thanks for pointing that out. Correcting above fixed the problem.

> Also, in the current place you have dss_init_features call, in case
> there's an error you can't just return, you need to release the
> resources. The same problem is in the dispc.c.
>
>  Tomi
>

By releasing resources did you mean the dss.feat memory? I think
dss_init_features call is wrongly placed and should be placed at the
very beginning of the probe function.

-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
