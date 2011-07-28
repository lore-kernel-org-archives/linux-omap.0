From: Arno Steffen <arno.steffen@googlemail.com>
Subject: Re: [Q] No message from Kernel (Howto start debug?)
Date: Thu, 28 Jul 2011 16:18:51 +0200
Message-ID: <CAACX+R0-vUP1z9DoS69iv2gX=YCKanousEHATzot0sSi-S9cEQ@mail.gmail.com>
References: <CAACX+R297j07GXRtLBCFuSyHTmk4sMXQiUt8YwN7KH6A8251jA@mail.gmail.com>
	<20110728132629.GH9069@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:61357 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007Ab1G1OSw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 10:18:52 -0400
Received: by pzk37 with SMTP id 37so4624316pzk.1
        for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 07:18:51 -0700 (PDT)
In-Reply-To: <20110728132629.GH9069@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, gary@mlbassoc.com
Cc: linux-omap@vger.kernel.org

That has been good points. I've tried both, but with no result so far.

boot_nfs_nand=3Dtftpboot 0x80000000 uImage; set bootargs
${bootargs_fs1}; run addip; bootm 0x80000000 ethaddr=3D00:11:22:33:44:5=
5
bootcmd=3Drun boot_nfs_nand
bootargs=3Dmem=3D128M console=3DttyO2,115200 noinitrd root=3D/dev/mtdbl=
ock6
rootfstype=3Djffs2
bootargs_fs1=3Dmem=3D128M console=3DttyO2,115200 noinitrd
root=3D/dev/mtdblock6 rootfstype=3Djffs2 debug earlyprintk
- Arno


2011/7/28 Felipe Balbi <balbi@ti.com>:
> On Thu, Jul 28, 2011 at 03:15:20PM +0200, Arno Steffen wrote:
>> Maybe you are so kind to give me a hint:
>>
>> Try to migrate from Kernel 33 to 37. Currently I don't see any messa=
ge after
>>
>> =A0 Verifying Checksum ... OK
>> =A0 =A0Loading Kernel Image ... OK
>> OK
>>
>> Starting kernel ...
>>
>> From what I understand kernel starts with start_kernel()).
>> What is best way to find out which part is failing? At which point I
>> do a printk to see what's going on, or at least set a GPIO Pin of th=
e
>> processor?
>> How to debug without any external tools like JTAG.
>
> try to enable CONFIG_DEBUG_LL and CONFIG_EARLY_PRINTK, then add "debu=
g
> earlyprintk" to your command line. See if that helps showing more deb=
ug
> messages.
>
> --
> balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
