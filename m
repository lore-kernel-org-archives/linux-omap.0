From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 3/3] omap: remoteproc: add support for a boot register
Date: Sun, 6 May 2012 14:21:42 +0300
Message-ID: <CAK=Wgbb4bJ22BYh444Xndaody7Q7Eoox3K7zvGCFmf6ZMHAa0w@mail.gmail.com>
References: <1334360392-1494-1-git-send-email-jgutierrez@ti.com> <1334360392-1494-4-git-send-email-jgutierrez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37609 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab2EFLWE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 May 2012 07:22:04 -0400
Received: by yhmm54 with SMTP id m54so3654415yhm.19
        for <linux-omap@vger.kernel.org>; Sun, 06 May 2012 04:22:03 -0700 (PDT)
In-Reply-To: <1334360392-1494-4-git-send-email-jgutierrez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juan Gutierrez <jgutierrez@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Hi Juan,

Thanks for the patches ! it's exciting to see that support for OMAP's
DSP is (relatively) easily achieved now. I hope your work can be a
good basis for an OMAP3 port, too.

Overall the patches look good, I have only some minor comments inline.

And - sorry for the late response. I've just left for a (somewhat
long) business trip when you posted this.

On Sat, Apr 14, 2012 at 2:39 AM, Juan Gutierrez <jgutierrez@ti.com> wro=
te:
> Some remote processors (like Omap4's DSP) need to explicitly
> configure a boot address in a special register or memory
> location

Let's just slightly rephrase this to prevent confusion: some remote
processors "need to have the boot address configured" in a special
register (as opposed to "need to configure").

> @@ -30,6 +30,7 @@ struct platform_device;
> =A0* @ops: start/stop rproc handlers
> =A0* @device_enable: omap-specific handler for enabling a device
> =A0* @device_shutdown: omap-specific handler for shutting down a devi=
ce
> + * @boot_reg: physical address of the control register for storing b=
oot address
> =A0*/
> =A0struct omap_rproc_pdata {
> =A0 =A0 =A0 =A0const char *name;
> @@ -40,6 +41,7 @@ struct omap_rproc_pdata {
> =A0 =A0 =A0 =A0const struct rproc_ops *ops;
> =A0 =A0 =A0 =A0int (*device_enable) (struct platform_device *pdev);
> =A0 =A0 =A0 =A0int (*device_shutdown) (struct platform_device *pdev);
> + =A0 =A0 =A0 u32 boot_reg;

We might want to use an IORESOURCE_MEM resource instead, since we're
dealing with a platform device anyway.

The driver can then fetch the address using platform_get_resource.

> @@ -203,6 +215,9 @@ static int __devinit omap_rproc_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0return 0;
>
> =A0free_rproc:
> + =A0 =A0 =A0 if (oproc->boot_reg)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(oproc->boot_reg);
> +err_ioremap:
> =A0 =A0 =A0 =A0rproc_free(rproc);
> =A0 =A0 =A0 =A0return ret;
> =A0}

I tend to call those cleanup snippets with names that indicate what the=
y do.

In this case I'd slightly prefer to keep calling the lower snippet
with "free_rproc" and just name the new snippet with something like
"unmap_bootreg". It's then a bit easier to read the code that calls
into those snippets (the reader easily know which cleanup snippet is
invoked by each 'goto').

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
