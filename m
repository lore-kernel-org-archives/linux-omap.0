From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 3/3] omap: remoteproc: add support for a boot register
Date: Mon, 7 May 2012 18:05:17 +0300
Message-ID: <CAK=WgbYHxh7tJhzApEWrkjQmkJGMWpnXynTPH5QUDnJ-TnVaYw@mail.gmail.com>
References: <1334360392-1494-1-git-send-email-jgutierrez@ti.com>
 <1334360392-1494-4-git-send-email-jgutierrez@ti.com> <CAK=Wgbb4bJ22BYh444Xndaody7Q7Eoox3K7zvGCFmf6ZMHAa0w@mail.gmail.com>
 <CADVn9RFOBdw0_19ErT6qEpy7325TG7wWkDfJtdF-6jq74z3nFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:53470 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757056Ab2EGPFj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 11:05:39 -0400
Received: by ghrr11 with SMTP id r11so4354726ghr.19
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 08:05:38 -0700 (PDT)
In-Reply-To: <CADVn9RFOBdw0_19ErT6qEpy7325TG7wWkDfJtdF-6jq74z3nFw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gutierrez, Juan" <jgutierrez@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Hi Juan,

On Mon, May 7, 2012 at 5:38 PM, Gutierrez, Juan <jgutierrez@ti.com> wro=
te:
>> > @@ -40,6 +41,7 @@ struct omap_rproc_pdata {
>> > =A0 =A0 =A0 =A0const struct rproc_ops *ops;
>> > =A0 =A0 =A0 =A0int (*device_enable) (struct platform_device *pdev)=
;
>> > =A0 =A0 =A0 =A0int (*device_shutdown) (struct platform_device *pde=
v);
>> > + =A0 =A0 =A0 u32 boot_reg;
>>
>> We might want to use an IORESOURCE_MEM resource instead, since we're
>> dealing with a platform device anyway.
>>
>> The driver can then fetch the address using platform_get_resource.
>
> Ok, Do you mean using resource table to get the boot_reg address, rig=
ht?

Sorry for the confusion - I meant using a 'struct resource' as the
standard way to pass this kind of information to platform drivers.

=46or example take a look how omap2_mbox_probe uses
platform_get_resource to retrieve the parameters which it then feeds
to ioremap.

Using this standard approach will probably make life easier when we
migrate to DT, too.

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
