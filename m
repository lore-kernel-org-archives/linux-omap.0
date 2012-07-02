From: Kevin Hilman <khilman@ti.com>
Subject: Re: 3.5-rc3: vdd_mpu_iva warnings
Date: Mon, 02 Jul 2012 14:19:49 -0700
Message-ID: <87zk7h5096.fsf@ti.com>
References: <WC20120618103957.6103F2@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:38415 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755780Ab2GBVTn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jul 2012 17:19:43 -0400
Received: by ggnf1 with SMTP id f1so4335996ggn.25
        for <linux-omap@vger.kernel.org>; Mon, 02 Jul 2012 14:19:42 -0700 (PDT)
In-Reply-To: <WC20120618103957.6103F2@terrafix.co.uk> (Joe Woodward's message
	of "Mon, 18 Jun 2012 11:39:57 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Joe Woodward" <jw@terrafix.co.uk> writes:

> I have a GUMSTIX Overo AirSTORM module (AM3703-based).
>
> When booting the kernel the following features are listed:
> OMAP3630 ES1.2 (l2cache neon isp 192mhz_clk )
>
> After booting I get the following (repeating every few seconds):
>
> [   81.122558] voltdm_scale: No voltage scale API registered for vdd_mpu_iva
> [   81.130340] platform mpu.0: omap_target: unable to scale voltage up.
>

BTW, after boot, can you run the shell snippet below.  This should run
the board through MPU DVFS for all the available OPPs:

Thanks,

Kevin


cd /sys/devices/system/cpu/cpu0/cpufreq
cat scaling_available_frequencies
cat scaling_cur_freq
echo userspace > scaling_governor

mpu_reg=regulator.3
for freq in `cat scaling_available_frequencies`; do
  echo ${freq} > scaling_setspeed
  echo -n "current freq: "
  cat scaling_cur_freq
  echo -n "current voltage: "
  cat /sys/class/regulator/${mpu_reg}/microvolts
  sleep 2
done
