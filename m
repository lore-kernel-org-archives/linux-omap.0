From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: Section mismatch warnings 2.6.37-rc6
Date: Fri, 17 Dec 2010 09:39:12 +0800
Message-ID: <AANLkTimfe6MT7vyJ183cUzX_pt-2NTF+Lqde+EBSjy3_@mail.gmail.com>
References: <8BA6F139-2FD7-478B-A586-36934CACE9EA@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36585 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab0LQBje convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 20:39:34 -0500
Received: by vws16 with SMTP id 16so69724vws.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 17:39:34 -0800 (PST)
In-Reply-To: <8BA6F139-2FD7-478B-A586-36934CACE9EA@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Fri, Dec 17, 2010 at 7:53 AM, Elvis Dowson <elvis.dowson@mac.com> wr=
ote:
> Hi,
> =A0 =A0 =A0 When I build the linux mainline 2.6.37-rc6, I get 3 secti=
on mismatch warnings. What do they indicate?
>

That tells us these 3 functions need to check for the right usage of
'__init'. And which defconfig are you using?

> $ make ARCH=3Darm CROSS_COMPILE=3Darm-angstrom-linux-gnueabi- uImage =
-j6 LOCALVERSION=3D"" CONFIG_DEBUG_SECTION_MISMATCH=3Dy
>
> WARNING: vmlinux.o(.data+0x1b70): Section mismatch in reference from =
the variable etb_driver to the function .init.text:etb_probe()
> The variable etb_driver references
> the function __init etb_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the var=
iable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
>
> WARNING: vmlinux.o(.data+0x1bbc): Section mismatch in reference from =
the variable etm_driver to the function .init.text:etm_probe()
> The variable etm_driver references
> the function __init etm_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the var=
iable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
>
> WARNING: vmlinux.o(.data+0x3477c): Section mismatch in reference from=
 the variable twl_driver to the function .init.text:twl_probe()
> The variable twl_driver references
> the function __init twl_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the var=
iable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,
>
I've sent a patch to twl driver maintainer to fix that.

Thanks,
--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
