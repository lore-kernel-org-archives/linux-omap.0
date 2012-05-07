From: "Gutierrez, Juan" <jgutierrez@ti.com>
Subject: Re: [PATCH v2 3/3] omap: remoteproc: add support for a boot register
Date: Mon, 7 May 2012 10:54:21 -0500
Message-ID: <CADVn9RG5xn0G40ug5_fRNqZtwP_OszXzmQCvchZH+WwgWxb6Rg@mail.gmail.com>
References: <1334360392-1494-1-git-send-email-jgutierrez@ti.com>
 <1334360392-1494-4-git-send-email-jgutierrez@ti.com> <CAK=Wgbb4bJ22BYh444Xndaody7Q7Eoox3K7zvGCFmf6ZMHAa0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:54590 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757286Ab2EGPyn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 11:54:43 -0400
Received: by ggnm2 with SMTP id m2so42981ggn.41
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 08:54:42 -0700 (PDT)
In-Reply-To: <CAK=Wgbb4bJ22BYh444Xndaody7Q7Eoox3K7zvGCFmf6ZMHAa0w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Hi Ohad

Thanks for reviewing.

On Sun, May 6, 2012 at 6:21 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Hi Juan,
>
> Thanks for the patches ! it's exciting to see that support for OMAP's
> DSP is (relatively) easily achieved now. I hope your work can be a
> good basis for an OMAP3 port, too.
>
> Overall the patches look good, I have only some minor comments inline=
=2E
>
> And - sorry for the late response. I've just left for a (somewhat
> long) business trip when you posted this.
>
> On Sat, Apr 14, 2012 at 2:39 AM, Juan Gutierrez <jgutierrez@ti.com> w=
rote:
>> Some remote processors (like Omap4's DSP) need to explicitly
>> configure a boot address in a special register or memory
>> location
>
> Let's just slightly rephrase this to prevent confusion: some remote
> processors "need to have the boot address configured" in a special
> register (as opposed to "need to configure").
>
Ok, I will do it.

>> @@ -30,6 +30,7 @@ struct platform_device;
>> =C2=A0* @ops: start/stop rproc handlers
>> =C2=A0* @device_enable: omap-specific handler for enabling a device
>> =C2=A0* @device_shutdown: omap-specific handler for shutting down a =
device
>> + * @boot_reg: physical address of the control register for storing =
boot address
>> =C2=A0*/
>> =C2=A0struct omap_rproc_pdata {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name;
>> @@ -40,6 +41,7 @@ struct omap_rproc_pdata {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct rproc_ops *ops;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int (*device_enable) (struct platform_dev=
ice *pdev);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int (*device_shutdown) (struct platform_d=
evice *pdev);
>> + =C2=A0 =C2=A0 =C2=A0 u32 boot_reg;
>
> We might want to use an IORESOURCE_MEM resource instead, since we're
> dealing with a platform device anyway.
>
> The driver can then fetch the address using platform_get_resource.
>
Ok, I will investigate about this, and include it in next series

>> @@ -203,6 +215,9 @@ static int __devinit omap_rproc_probe(struct pla=
tform_device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>>
>> =C2=A0free_rproc:
>> + =C2=A0 =C2=A0 =C2=A0 if (oproc->boot_reg)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iounmap(oproc->bo=
ot_reg);
>> +err_ioremap:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0rproc_free(rproc);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
>> =C2=A0}
>
> I tend to call those cleanup snippets with names that indicate what t=
hey do.
>
> In this case I'd slightly prefer to keep calling the lower snippet
> with "free_rproc" and just name the new snippet with something like
> "unmap_bootreg". It's then a bit easier to read the code that calls
> into those snippets (the reader easily know which cleanup snippet is
> invoked by each 'goto').
>
Agree. I will do the change.

> Thanks,
> Ohad.



--=20
Thanks

juan gutierrez
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
