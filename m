From: Arno Steffen <arno.steffen@googlemail.com>
Subject: Re: [Q] No message from Kernel (Howto start debug?)
Date: Thu, 28 Jul 2011 18:13:22 +0200
Message-ID: <CAACX+R3dGQQrMei5q9gS4nCnn0f7FmecON9pm1XMM7Z3xjkMCw@mail.gmail.com>
References: <CAACX+R297j07GXRtLBCFuSyHTmk4sMXQiUt8YwN7KH6A8251jA@mail.gmail.com>
	<5d52501338122438f9712b01f5b6de81@mail.gmail.com>
	<CAACX+R37F4G9To3QT97-jODcdmgTiE-9_cTvoS1Z+89n-N_icg@mail.gmail.com>
	<CAACX+R1Qtzn1uTX4aHg1cSRuBR+29_Tek08RhTU2DVmiH7UP3Q@mail.gmail.com>
	<accf999739ee7850d7e468c522a2342f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:60737 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154Ab1G1QNX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jul 2011 12:13:23 -0400
Received: by pzk37 with SMTP id 37so4772620pzk.1
        for <linux-omap@vger.kernel.org>; Thu, 28 Jul 2011 09:13:22 -0700 (PDT)
In-Reply-To: <accf999739ee7850d7e468c522a2342f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org

2011/7/28 Sricharan R <r.sricharan@ti.com>:
>>-----Original Message-----
>>From: Arno Steffen [mailto:arno.steffen@googlemail.com]
>>Sent: Thursday, July 28, 2011 9:13 PM
>>To: Sricharan R
>>Subject: Re: [Q] No message from Kernel (Howto start debug?)
>>
>>2011/7/28 Arno Steffen <arno.steffen@googlemail.com>:
>>> 2011/7/28 Sricharan R <r.sricharan@ti.com>:
>>>> =A0If you are stuck with Starting kernel ... and do not see
>>>> =A0 "Uncompressing Linux... done, booting the kernel" means could =
have
>>>> crashed before your kernel in case of uImage.
>>>> =A0Check the arch_id that you are passing from the bootloader.
>>>>
>>>> Also enable early printk.
>>>>
>>>> >From what I understand kernel starts with start_kernel()).
>>>>>What is best way to find out which part is failing? At which point=
 I
>>>>>do a printk to see what's going on, or at least set a GPIO Pin of =
the
>>>>>processor?
>>>>>How to debug without any external tools like JTAG.
>>>>>--
>>>>>To unsubscribe from this list: send the line "unsubscribe linux-om=
ap"
> in
>>>>>the body of a message to majordomo@vger.kernel.org
>>>>>More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>>>>
>>>> Thanks,
>>>> =A0Sricharan
>>>>
>>>
>>> You are absolutly right! The strange thing is, uboot can boot my ol=
d
>>> kernel out of NAND flash.
>>> And with the old kernel I can also boot via ethernet. Yepp, probabl=
y
>>> the arch-id. I will check this.
>>> Thanks
>>> Arno
>>>
>>
>>To optimistic. :(
>>It seems that I have set the MACHINE_START in a proper way.
>>What can prevent this message in uboot? Why it can uncompressing the
>>old uImages, but not the new one?
>
> Is the uncompressing done by u-boot in your case?
>
> I have seen that the uncompress algorithm is built on
> Top the Image. U-boot simply jumps to that location and
> Rest is taken care by the uncompresser. It also sets up the
> Serial port according to the arch
> and prints " Uncompressing Linux... done, booting the kernel".
>
> The serial port number is used for early prints by kernel.
>
> Also check if your load address passed from u-boot is correct?
>
>>Seems I have to dig into uboot.
>>Thanks
>>-Arno
>

Mh, so it's not a uboot issue. Checking the outputs (see below) are
identical, except Linux version and the new image is a bit smaller.
Where does the uncompressor knows about which serial port to use?

Bytes transferred =3D 1587592 (183988 hex)
## Booting kernel from Legacy Image at 80000000 ...
   Image Name:   Linux-2.6.37
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1587528 Bytes =3D  1.5 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Thanks
-Arno
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
