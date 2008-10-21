From: =?ISO-8859-1?Q?Ram=F3n_Finger_Lilienthal?= <ramon@instramed.com.br>
Subject: Problems compiling kernel
Date: Tue, 21 Oct 2008 11:43:18 -0200
Message-ID: <48FDDC76.40509@instramed.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fb02-07.mta.terra.com.br ([200.154.152.126]:46913 "EHLO
	fb02-07.mta.terra.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbYJUOLm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Oct 2008 10:11:42 -0400
Received: from sr01-10.mta.terra.com.br (sr01-10.mta.terra.com.br [200.154.152.29])
	by orilia.hst.terra.com.br (Postfix) with ESMTP id EE6141498065
	for <linux-omap@vger.kernel.org>; Tue, 21 Oct 2008 10:46:23 -0300 (BRT)
Received: from disraeli.terra.com.br (disraeli.terra.com.br [200.176.10.19])
	by bulimba.hst.terra.com.br (Postfix) with ESMTP id C3BC21A0001F9
	for <linux-omap@vger.kernel.org>; Tue, 21 Oct 2008 13:43:19 +0000 (UTC)
Received: from [192.168.1.120] (unknown [201.21.243.40])
	(authenticated user ramoninstramed@terra.com.br)
	by disraeli.terra.com.br (Postfix) with ESMTP id 7688E200036A
	for <linux-omap@vger.kernel.org>; Tue, 21 Oct 2008 13:43:17 +0000 (UTC)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux_omap <linux-omap@vger.kernel.org>

Dear fellows,

I am facing some compiling errors in my kernel.

My kernel version is:

VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 27
EXTRAVERSION =
NAME = Rotary Wombat

And I updated the source using "git pull" today,  before trying to 
compile the kernel.

I got these errors:

  MODPOST vmlinux.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/arm/plat-omap/built-in.o: In function `omap_verify_speed':
/home/ramon/work/linux-omap-2.6.new.teste/arch/arm/plat-omap/cpu-omap.c:46: 
undefined reference to `cpufreq_frequency_table_verify'
arch/arm/plat-omap/built-in.o: In function `omap_cpu_init':
/home/ramon/work/linux-omap-2.6.new.teste/arch/arm/plat-omap/cpu-omap.c:119: 
undefined reference to `cpufreq_frequency_table_cpuinfo'
/home/ramon/work/linux-omap-2.6.new.teste/arch/arm/plat-omap/cpu-omap.c:121: 
undefined reference to `cpufreq_frequency_table_get_attr'
arch/arm/plat-omap/built-in.o:(.data+0x91c): undefined reference to 
`cpufreq_freq_attr_scaling_available_freqs'
make: *** [.tmp_vmlinux1] Error 1

I looked in "plat-omap.c" and it calls the library cpufreq.h.
cpufreq.h has the prototipes of that undefined references and cpufreq.c 
has the impementations of it.

So, I don't understand why it is happening. By the way, I am a begginer 
in linux development.

Any help will be welcome.


-- 
Regards,
Eng. Ramon F. Lilienthal
Project Engineer
Instramed Ltda. - www.instramed.com.br
+55 (51) 33344199 ext. 213

