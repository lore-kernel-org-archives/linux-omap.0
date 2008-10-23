From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Problems compiling kernel
Date: Thu, 23 Oct 2008 21:06:38 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301B049A4EA@dbde02.ent.ti.com>
References: <48FDDC76.40509@instramed.com.br>
 <B85A65D85D7EB246BE421B3FB0FBB59301B04166E6@dbde02.ent.ti.com>
 <48FF2502.2010208@instramed.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41281 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155AbYJWPg4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Oct 2008 11:36:56 -0400
In-Reply-To: <48FF2502.2010208@instramed.com.br>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Ram=F3n_Finger_Lilienthal?= <ramon@instramed.com.br>, linux_omap <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Ram=F3n Finger Lilienthal [mailto:ramon@instramed.com.br]=20
> Sent: Wednesday, October 22, 2008 6:35 PM
> To: Premi, Sanjeev; linux_omap
> Subject: Re: Problems compiling kernel
>=20
> Dear Sanjeev,
>=20
> Thanks for your help.
>=20
> Now, I am building for omap5912osk, and we have a new board=20
> omap5912 based.  I hope in some months changing my efforts to OMAP35.
>=20
> Part of my .config file is listed below. The flag=20
> CONFIG_CPU_FREQ_TABLE was set to "m", I changed to "y". I=20
> tried to compile again, but the error still happening.
> I took a look at .config after compiling and=20
> CONFIG_CPU_FREQ_TABLE got back to "m" (automatically).
>=20
> =3D=3D=3D=3D .config  =3D=3D=3D
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=3Dy
> CONFIG_CPU_FREQ_TABLE=3Dm
> # CONFIG_CPU_FREQ_DEBUG is not set
> CONFIG_CPU_FREQ_STAT=3Dm
> CONFIG_CPU_FREQ_STAT_DETAILS=3Dy
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set #=20
> CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set #=20
> CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set #=20
> CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set=20
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy=20
> CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dm=20
> CONFIG_CPU_FREQ_GOV_USERSPACE=3Dm=20
> CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dm CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dm
>=20
> #
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> After, i changed the flags CONFIG_CPU_FREQ_TABLE=3Dy and=20
> CONFIG_CPU_FREQ_STAT=3Dy.
> Then that error didn't occurred again, but another error happened:
>=20
> =3D=3D=3D=3D
>   CHK     include/linux/compile.h
>   CC [M]  drivers/net/b44.o
>   Kernel: arch/arm/boot/Image is ready
>   LD      arch/arm/boot/compressed/vmlinux
>   OBJCOPY arch/arm/boot/zImage
>   Kernel: arch/arm/boot/zImage is ready
>   Building modules, stage 2.
>   MODPOST 1059 modules
> FATAL: drivers/net/b44: sizeof(struct ssb_device_id)=3D6 is not=20
> a modulo of the size of section __mod_ssb_device_table=3D16.
> Fix definition of struct ssb_device_id in mod_devicetable.h

Did you change this driver?

> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> =3D=3D=3D=3D
I did not see this problem on my working branch based off tag v2.6.26-o=
map2.
(I built for omap_osk_5912_defconfig)

However, I do see many section mismatches:

WARNING: arch/arm/mach-omap1/built-in.o(.data+0x26c): Section mismatch =
in reference from the variable omap1_clk_functions to the function .ini=
t.text:omap1_clk_disable_unused()
The variable omap1_clk_functions references
the function __init omap1_clk_disable_unused()
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_con=
sole,

  LD      vmlinux.o
  MODPOST vmlinux.o
WARNING: vmlinux.o(.text+0x2a68): Section mismatch in reference from th=
e function cpu_init() to the function .init.text:dump_cpu_info()
The function cpu_init() references
the function __init dump_cpu_info().
This is often because cpu_init lacks a __init
annotation or the annotation of dump_cpu_info is wrong.

WARNING: vmlinux.o(.text+0x14af74): Section mismatch in reference from =
the function smc_drv_probe() to the function .init.text:smc_probe()
The function smc_drv_probe() references
the function __init smc_probe().
This is often because smc_drv_probe lacks a __init
annotation or the annotation of smc_probe is wrong.

WARNING: vmlinux.o(.data+0x14dc): Section mismatch in reference from th=
e variable omap1_clk_functions to the function .init.text:omap1_clk_dis=
able_unused()
The variable omap1_clk_functions references
the function __init omap1_clk_disable_unused()
If the reference is valid then annotate the
variable with __init* (see linux/init.h) or name the variable:
*driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_con=
sole,


>=20
> Again, thanks for your help
>=20
> Regards,
> Eng. Ramon F. Lilienthal
> Project Engineer
> Instramed Ltda. - www.instramed.com.br
> +55 (51) 33344199 ext. 213
>=20
>=20
>=20
> Premi, Sanjeev wrote:
> > Ramon,
> >
> > Can you confirm if you have CONFIG_CPU_FREQ_TABLE=3Dy in the .confi=
g?
> >
> > The 'undefined' functions in your compile log are defined in=20
> > drivers/cpufreq/freq_table.c If you look at Makefile in the=20
> same dir, this file is included in compile based on the flag=20
> mentioned above.
> >
> > Which platform are you building for?
> > Are you sure you haven't disabled CPU_FREQ manually?
> > If you haven't made any modifications the problem could be=20
> in the defconfig?
> >
> > Though, I believe that cpu-omap.c may also need to be=20
> updated to take care of CONFIG_CPU_FREQ OR specifically=20
> CONFIG_CPU_FREQ_TABLE.
> >
> > Best regards,
> > Sanjeev
> >
> >  =20
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org=20
> >> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of=20
> Ram=F3n Finger=20
> >> Lilienthal
> >> Sent: Tuesday, October 21, 2008 7:13 PM
> >> To: linux_omap
> >> Subject: Problems compiling kernel
> >>
> >> Dear fellows,
> >>
> >> I am facing some compiling errors in my kernel.
> >>
> >> My kernel version is:
> >>
> >> VERSION =3D 2
> >> PATCHLEVEL =3D 6
> >> SUBLEVEL =3D 27
> >> EXTRAVERSION =3D
> >> NAME =3D Rotary Wombat
> >>
> >> And I updated the source using "git pull" today,  before trying to=
=20
> >> compile the kernel.
> >>
> >> I got these errors:
> >>
> >>   MODPOST vmlinux.o
> >>   GEN     .version
> >>   CHK     include/linux/compile.h
> >>   UPD     include/linux/compile.h
> >>   CC      init/version.o
> >>   LD      init/built-in.o
> >>   LD      .tmp_vmlinux1
> >> arch/arm/plat-omap/built-in.o: In function `omap_verify_speed':
> >> /home/ramon/work/linux-omap-2.6.new.teste/arch/arm/plat-omap/c
> >> pu-omap.c:46:=20
> >> undefined reference to `cpufreq_frequency_table_verify'
> >> arch/arm/plat-omap/built-in.o: In function `omap_cpu_init':
> >> /home/ramon/work/linux-omap-2.6.new.teste/arch/arm/plat-omap/c
> >> pu-omap.c:119:=20
> >> undefined reference to `cpufreq_frequency_table_cpuinfo'
> >> /home/ramon/work/linux-omap-2.6.new.teste/arch/arm/plat-omap/c
> >> pu-omap.c:121:=20
> >> undefined reference to `cpufreq_frequency_table_get_attr'
> >> arch/arm/plat-omap/built-in.o:(.data+0x91c): undefined=20
> reference to=20
> >> `cpufreq_freq_attr_scaling_available_freqs'
> >> make: *** [.tmp_vmlinux1] Error 1
> >>
> >> I looked in "plat-omap.c" and it calls the library cpufreq.h.
> >> cpufreq.h has the prototipes of that undefined references and=20
> >> cpufreq.c has the impementations of it.
> >>
> >> So, I don't understand why it is happening. By the way, I am a=20
> >> begginer in linux development.
> >>
> >> Any help will be welcome.
> >>
> >>
> >> --
> >> Regards,
> >> Eng. Ramon F. Lilienthal
> >> Project Engineer
> >> Instramed Ltda. - www.instramed.com.br
> >> +55 (51) 33344199 ext. 213
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap"=20
> >> in the body of a message to majordomo@vger.kernel.org More=20
> majordomo=20
> >> info at  http://vger.kernel.org/majordomo-info.html
> >>
> >> --
> >>    =20
> > To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap"=20
> > in the body of a message to majordomo@vger.kernel.org More=20
> majordomo=20
> > info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> >  =20
>=20
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
