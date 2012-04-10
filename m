From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: omap-hsmmc build broken with OF enabled in latest kernel
Date: Tue, 10 Apr 2012 19:42:20 +0530
Message-ID: <CANrkHUaterZdjgz12KA+J2D4KURaiPuu-AvxYjk5mhFju7eJYg@mail.gmail.com>
References: <20120410095444.GO24211@n2100.arm.linux.org.uk>
	<87obqzwuog.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:48188 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754338Ab2DJOMY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Apr 2012 10:12:24 -0400
Received: by lbom4 with SMTP id m4so3193927lbo.11
        for <linux-omap@vger.kernel.org>; Tue, 10 Apr 2012 07:12:20 -0700 (PDT)
In-Reply-To: <87obqzwuog.fsf@laptop.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Rajendra Nayak <rnayak@ti.com>, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org, "S, Venkatraman" <svenkatr@ti.com>

On Tue, Apr 10, 2012 at 7:33 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Tue, Apr 10 2012, Russell King - ARM Linux wrote:
>> This commit:
>>
>> commit 46856a68dcb5f67c779d211fd6bcb5d7a2a7f19b
>> Author: Rajendra Nayak <rnayak@ti.com>
>> Date: =A0 Mon Mar 12 20:32:37 2012 +0530
>>
>> =A0 =A0 mmc: omap_hsmmc: Convert hsmmc driver to use device tree
>>
>> =A0 =A0 Define dt bindings for the ti-omap-hsmmc, and adapt the driv=
er to extract
>> =A0 =A0 data (which was earlier passed as platform_data) from device=
 tree.
>>
>> =A0 =A0 Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> =A0 =A0 Acked-by: Rob Herring <rob.herring@calxeda.com>
>> =A0 =A0 Signed-off-by: Chris Ball <cjb@laptop.org>
>>
>> breaks omap-hsmmc compilation:
>>
>> drivers/mmc/host/omap_hsmmc.c:1745: error: expected ',' or ';' befor=
e 'extern'
>>
>> +#ifdef CONFIG_OF
>> +static u16 omap4_reg_offset =3D 0x100;
>> +
>> +static const struct of_device_id omap_mmc_of_match[] =3D {
>> ...
>> +}
>> +MODULE_DEVICE_TABLE(of, omap_mmc_of_match);
>>
>> There should be a ';' after the }.
>
> Thanks, and sorry for breaking the build. =A0I've pushed a fix to mmc=
-next
> and will send it out to Linus.
>
> Surprisingly, this patch does not break my build with gcc-4.6.0 --
> and I've just checked that line 1745 is being compiled by purposefull=
y
> introducing an(other) error to it, which *did* break my build. =A0I w=
onder
> what's going on there; presumably it's the reason that no-one else sa=
w
> this earlier.

Build fails iff omap_hsmmc is built as a module.
Adding ';' fixes and uncovers another build error due to unexported
variable allnodes, will send a RFC patch shortly.

ERROR: "allnodes" [drivers/mmc/host/omap_hsmmc.ko] undefined!
make[3]: *** [__modpost] Error 1

>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
