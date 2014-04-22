From: Nishanth Menon <nm@ti.com>
Subject: Re: regressions in linux-next?
Date: Tue, 22 Apr 2014 10:13:10 -0500
Message-ID: <53568706.1050204@ti.com>
References: <53566C20.6000208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36401 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756896AbaDVPNL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2014 11:13:11 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id s3MFDAob030882
	for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2014 10:13:10 -0500
Received: from DLEE70.ent.ti.com (dlee70.ent.ti.com [157.170.170.113])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id s3MFDAjr023564
	for <linux-omap@vger.kernel.org>; Tue, 22 Apr 2014 10:13:10 -0500
In-Reply-To: <53566C20.6000208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>

Logs with with DEBUG_LL and early printk below:
Thread: http://marc.info/?t=139817273800014&r=1&w=2

On 04/22/2014 08:18 AM, Nishanth Menon wrote:
> next-20140422-omap2plus_defconfig
>  1:  am335x-sk:  Boot FAIL: http://slexy.org/raw/s2gh6XsLve
>  2: am3517-evm:  Boot PASS: http://slexy.org/raw/s2MTkdzPnb
>  3:  am37x-evm:  Boot PASS: http://slexy.org/raw/s2SJwrVat8
>  4: am43xx-epos:  Boot PASS: http://slexy.org/raw/s2184jfKlq
>  5: am43xx-gpevm:  Boot FAIL: http://slexy.org/raw/s21qIYDHqa
>> known
>  6: BeagleBoard-XM:  Boot FAIL: http://slexy.org/raw/s21EyANlGX

>  7: beagleboard-vanilla:  Boot FAIL: http://slexy.org/raw/s20lc3icwS

>  8: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2ykosQg6C
>  9: beaglebone:  Boot PASS: http://slexy.org/raw/s2DN9gqlmo
> 10: craneboard:  Boot FAIL: http://slexy.org/raw/s21bP0auhl
> 11: DRA7xx-EVM:  Boot FAIL: http://slexy.org/raw/s2rBG0C1x6
looks like my fdt_high was 0xFFFFFFFF and fdt was at 0x80f80000 :( so
got stomped all over...

Time for me to verify every platform again.


-- 
Regards,
Nishanth Menon
