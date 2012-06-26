From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v3 4/4] memory: emif: add device tree support to emif
 driver
Date: Tue, 26 Jun 2012 10:49:54 +0530
Message-ID: <4FE9467A.2050906@ti.com>
References: <1339669764-27244-1-git-send-email-santosh.shilimkar@ti.com> <1339669764-27244-5-git-send-email-santosh.shilimkar@ti.com> <20120614154820.GG17140@kroah.com> <CAMQu2gx5CCDyrvozX06neBnA8J2heg+HL7DOewDm5voxqbpetw@mail.gmail.com> <CAMQu2gy7oj-+1qCteAFMXEeOL-Wdrs6e4gKWM=HsOukXcPuv-A@mail.gmail.com> <20120625182830.GA23850@kroah.com> <CAMQu2gxDG=69X7UQPUoTLP5h1ZLpHngp=3C4vSDOS6L-N2XZSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:58137 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750809Ab2FZFUC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 01:20:02 -0400
Received: by obbuo19 with SMTP id uo19so11942069obb.39
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 22:20:00 -0700 (PDT)
In-Reply-To: <CAMQu2gxDG=69X7UQPUoTLP5h1ZLpHngp=3C4vSDOS6L-N2XZSw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Aneesh V <aneesh@ti.com>

On Tuesday 26 June 2012 10:39 AM, Shilimkar, Santosh wrote:
>>> +#if defined(CONFIG_OF)
>>> >  >  +static const struct of_device_id emif_of_match[] = {
>>> >  >  +             { .compatible = "ti,emif-4d" },
>>> >  >  +             { .compatible = "ti,emif-4d5" },
>>> >  >  +             {},
>>> >  >  +};
>>> >  >  +MODULE_DEVICE_TABLE(of, emif_of_match);
>>> >  >  +#endif
>>> >  >  +
>>> >  >    static struct platform_driver emif_driver = {
>>> >  >         .remove         = __exit_p(emif_remove),
>>> >  >         .shutdown       = emif_shutdown,
>>> >  >         .driver = {
>>> >  >                 .name = "emif",
>>> >  >  +#if defined(CONFIG_OF)
>>> >  >  +             .of_match_table = of_match_ptr(emif_of_match),
>>> >  >  +#endif
>> >
>> >  Are these two still #if defined needed?
>> >
>> >  Also, what about the IS_DEFINED macro?
>> >
> Yes. To avoid the build break in !DT build.
>

No, infact of_match_ptr is there just so you can avoid a
#ifdef around and not break !CONFIG_OF.
