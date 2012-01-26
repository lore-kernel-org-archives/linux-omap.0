From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: No console output (omap-3.2 branch)
Date: Thu, 26 Jan 2012 11:27:01 +0100
Message-ID: <CAAfyv36-WvcZS=rSwyutuXjh-CKZdBSR=5zZ4d0zN6FBXOFttw@mail.gmail.com>
References: <jbvod7$rj2$1@dough.gmane.org>
	<4F207EFE.1010902@yahoo.com>
	<jfr8vc$i8f$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48212 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab2AZK1C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jan 2012 05:27:02 -0500
Received: by vcbgb30 with SMTP id gb30so259864vcb.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Jan 2012 02:27:01 -0800 (PST)
In-Reply-To: <jfr8vc$i8f$1@dough.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andre Puschmann <andre.puschmann@tu-ilmenau.de>
Cc: linux-omap@vger.kernel.org

On Thu, Jan 26, 2012 at 11:13 AM, Andre Puschmann
<andre.puschmann@tu-ilmenau.de> wrote:
> On 01/25/2012 11:15 PM, Frank Agius wrote:
>> On 12/10/2011 8:55 AM, Andre Puschmann wrote:
>>> Hi list, Steve,
>>>
>>> I am trying to boot a kernel I built (using omap2plus_defconfig) ba=
sed
>>> on Steve's omap-3.2 branch without much success.
>>>
>>> I don't get any console output after Uboot finished uncompressing t=
he
>>> kernel. Is there anything I need to configure? The kernel image bas=
ed on
>>> Tony's tree boots fine on the same hardware (Gumstix Overo Tide)
>>> (despite having MMC issues as mentioned earlier).
>>
>> I ran into the same problem you described. Steve's tree has some pat=
ches
>> that are not in mainline 3.2. =C2=A0I tracked the hang down to one o=
f those
>> patches that added support for 720Mhz capable hardware. =C2=A0The
>> kernel reads the status register and determines that the CPU can sup=
port
>> 720Mhz (omap3_check_features). =C2=A0From what I can tell, the check=
 is done
>> correctly (variable status in omap3_check_features is set to 0x08, w=
hich
>> looks like the right bit for 720Mhz support). =C2=A0Since the kernel=
 thinks
>> that 720Mhz is supported, it calls omap3_opp_enable_720Mhz (file
>> opp3xx_data.c). =C2=A0The kernel dies silently when it calls the opp=
 enable
>> for 720Mhz, at or near line 178:
>>
>> 176 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pdev =3D=
 &oh_mpu->od->pdev;
>> 177
>> 178 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D op=
p_enable(&pdev->dev, 720000000);
>>
>> That's as far as I can take the debug. =C2=A0I'm going to disable th=
e check
>> for 720Mhz in my local tree until this can get sorted out.
>
Could this be related to same problem? :
http://marc.info/?l=3Dlinux-omap&m=3D132756359017621&w=3D2
> Just wanted to mention that the bug is still present here, too.
> Interestingly, the same code seems to work in the omap-3.0pm tree and
> the kernel boots fine. So disabling 720MHz support might just hide th=
e
> real cause.
>
> -Andre
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml

marek

--=20
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
=46reelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
