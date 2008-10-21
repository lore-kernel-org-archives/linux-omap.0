From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Problems compiling kernel
Date: Wed, 22 Oct 2008 02:17:25 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301B04166E6@dbde02.ent.ti.com>
References: <48FDDC76.40509@instramed.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41946 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbYJUUrk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Oct 2008 16:47:40 -0400
In-Reply-To: <48FDDC76.40509@instramed.com.br>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Ram=F3n_Finger_Lilienthal?= <ramon@instramed.com.br>, linux_omap <linux-omap@vger.kernel.org>

Ramon,

Can you confirm if you have CONFIG_CPU_FREQ_TABLE=3Dy in the .config?

The 'undefined' functions in your compile log are defined in drivers/cp=
ufreq/freq_table.c
If you look at Makefile in the same dir, this file is included in compi=
le based on the flag mentioned above.

Which platform are you building for?
Are you sure you haven't disabled CPU_FREQ manually?
If you haven't made any modifications the problem could be in the defco=
nfig?

Though, I believe that cpu-omap.c may also need to be updated to take c=
are of CONFIG_CPU_FREQ OR specifically CONFIG_CPU_FREQ_TABLE.

Best regards,
Sanjeev=20

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org=20
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ram=F3n=20
> Finger Lilienthal
> Sent: Tuesday, October 21, 2008 7:13 PM
> To: linux_omap
> Subject: Problems compiling kernel
>=20
> Dear fellows,
>=20
> I am facing some compiling errors in my kernel.
>=20
> My kernel version is:
>=20
> VERSION =3D 2
> PATCHLEVEL =3D 6
> SUBLEVEL =3D 27
> EXTRAVERSION =3D
> NAME =3D Rotary Wombat
>=20
> And I updated the source using "git pull" today,  before=20
> trying to compile the kernel.
>=20
> I got these errors:
>=20
>   MODPOST vmlinux.o
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/arm/plat-omap/built-in.o: In function `omap_verify_speed':
> /home/ramon/work/linux-omap-2.6.new.teste/arch/arm/plat-omap/c
> pu-omap.c:46:=20
> undefined reference to `cpufreq_frequency_table_verify'
> arch/arm/plat-omap/built-in.o: In function `omap_cpu_init':
> /home/ramon/work/linux-omap-2.6.new.teste/arch/arm/plat-omap/c
> pu-omap.c:119:=20
> undefined reference to `cpufreq_frequency_table_cpuinfo'
> /home/ramon/work/linux-omap-2.6.new.teste/arch/arm/plat-omap/c
> pu-omap.c:121:=20
> undefined reference to `cpufreq_frequency_table_get_attr'
> arch/arm/plat-omap/built-in.o:(.data+0x91c): undefined=20
> reference to `cpufreq_freq_attr_scaling_available_freqs'
> make: *** [.tmp_vmlinux1] Error 1
>=20
> I looked in "plat-omap.c" and it calls the library cpufreq.h.
> cpufreq.h has the prototipes of that undefined references and=20
> cpufreq.c has the impementations of it.
>=20
> So, I don't understand why it is happening. By the way, I am=20
> a begginer in linux development.
>=20
> Any help will be welcome.
>=20
>=20
> --
> Regards,
> Eng. Ramon F. Lilienthal
> Project Engineer
> Instramed Ltda. - www.instramed.com.br
> +55 (51) 33344199 ext. 213
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
