From: =?ISO-8859-1?Q?Ram=F3n_Finger_Lilienthal?= <ramon@instramed.com.br>
Subject: Re: Problems compiling kernel
Date: Wed, 22 Oct 2008 11:05:06 -0200
Message-ID: <48FF2502.2010208@instramed.com.br>
References: <48FDDC76.40509@instramed.com.br> <B85A65D85D7EB246BE421B3FB0FBB59301B04166E6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sr05-03.mta.terra.com.br ([200.154.152.62]:49611 "EHLO
	sr05-03.mta.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbYJVNFL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2008 09:05:11 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301B04166E6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, linux_omap <linux-omap@vger.kernel.org>

Dear Sanjeev,

Thanks for your help.

Now, I am building for omap5912osk, and we have a new board omap5912=20
based.  I hope in some months changing my efforts to OMAP35.

Part of my .config file is listed below. The flag CONFIG_CPU_FREQ_TABLE=
=20
was set to "m", I changed to "y". I tried to compile again, but the=20
error still happening.
I took a look at .config after compiling and CONFIG_CPU_FREQ_TABLE got=20
back to "m" (automatically).

=3D=3D=3D=3D .config  =3D=3D=3D
#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_TABLE=3Dm
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=3Dm
CONFIG_CPU_FREQ_STAT_DETAILS=3Dy
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dm
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dm
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dm
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dm

#
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

After, i changed the flags CONFIG_CPU_FREQ_TABLE=3Dy and=20
CONFIG_CPU_FREQ_STAT=3Dy.
Then that error didn't occurred again, but another error happened:

=3D=3D=3D=3D
  CHK     include/linux/compile.h
  CC [M]  drivers/net/b44.o
  Kernel: arch/arm/boot/Image is ready
  LD      arch/arm/boot/compressed/vmlinux
  OBJCOPY arch/arm/boot/zImage
  Kernel: arch/arm/boot/zImage is ready
  Building modules, stage 2.
  MODPOST 1059 modules
=46ATAL: drivers/net/b44: sizeof(struct ssb_device_id)=3D6 is not a mod=
ulo=20
of the size of section __mod_ssb_device_table=3D16.
=46ix definition of struct ssb_device_id in mod_devicetable.h
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2
=3D=3D=3D=3D

Again, thanks for your help

Regards,
Eng. Ramon F. Lilienthal
Project Engineer
Instramed Ltda. - www.instramed.com.br
+55 (51) 33344199 ext. 213



Premi, Sanjeev wrote:
> Ramon,
>
> Can you confirm if you have CONFIG_CPU_FREQ_TABLE=3Dy in the .config?
>
> The 'undefined' functions in your compile log are defined in drivers/=
cpufreq/freq_table.c
> If you look at Makefile in the same dir, this file is included in com=
pile based on the flag mentioned above.
>
> Which platform are you building for?
> Are you sure you haven't disabled CPU_FREQ manually?
> If you haven't made any modifications the problem could be in the def=
config?
>
> Though, I believe that cpu-omap.c may also need to be updated to take=
 care of CONFIG_CPU_FREQ OR specifically CONFIG_CPU_FREQ_TABLE.
>
> Best regards,
> Sanjeev=20
>
>  =20
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org=20
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ram=F3n=20
>> Finger Lilienthal
>> Sent: Tuesday, October 21, 2008 7:13 PM
>> To: linux_omap
>> Subject: Problems compiling kernel
>>
>> Dear fellows,
>>
>> I am facing some compiling errors in my kernel.
>>
>> My kernel version is:
>>
>> VERSION =3D 2
>> PATCHLEVEL =3D 6
>> SUBLEVEL =3D 27
>> EXTRAVERSION =3D
>> NAME =3D Rotary Wombat
>>
>> And I updated the source using "git pull" today,  before=20
>> trying to compile the kernel.
>>
>> I got these errors:
>>
>>   MODPOST vmlinux.o
>>   GEN     .version
>>   CHK     include/linux/compile.h
>>   UPD     include/linux/compile.h
>>   CC      init/version.o
>>   LD      init/built-in.o
>>   LD      .tmp_vmlinux1
>> arch/arm/plat-omap/built-in.o: In function `omap_verify_speed':
>> /home/ramon/work/linux-omap-2.6.new.teste/arch/arm/plat-omap/c
>> pu-omap.c:46:=20
>> undefined reference to `cpufreq_frequency_table_verify'
>> arch/arm/plat-omap/built-in.o: In function `omap_cpu_init':
>> /home/ramon/work/linux-omap-2.6.new.teste/arch/arm/plat-omap/c
>> pu-omap.c:119:=20
>> undefined reference to `cpufreq_frequency_table_cpuinfo'
>> /home/ramon/work/linux-omap-2.6.new.teste/arch/arm/plat-omap/c
>> pu-omap.c:121:=20
>> undefined reference to `cpufreq_frequency_table_get_attr'
>> arch/arm/plat-omap/built-in.o:(.data+0x91c): undefined=20
>> reference to `cpufreq_freq_attr_scaling_available_freqs'
>> make: *** [.tmp_vmlinux1] Error 1
>>
>> I looked in "plat-omap.c" and it calls the library cpufreq.h.
>> cpufreq.h has the prototipes of that undefined references and=20
>> cpufreq.c has the impementations of it.
>>
>> So, I don't understand why it is happening. By the way, I am=20
>> a begginer in linux development.
>>
>> Any help will be welcome.
>>
>>
>> --
>> Regards,
>> Eng. Ramon F. Lilienthal
>> Project Engineer
>> Instramed Ltda. - www.instramed.com.br
>> +55 (51) 33344199 ext. 213
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe=20
>> linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>>    =20
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>  =20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
