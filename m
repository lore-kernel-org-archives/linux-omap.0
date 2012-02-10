From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP34xx
Date: Fri, 10 Feb 2012 07:10:06 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317C957F@DBDE01.ent.ti.com>
References: <20120208231551.GA9009@kroah.com>
 <alpine.DEB.2.00.1202081648510.9540@utopia.booyaka.com>
 <20120209004731.GA11343@kroah.com> <4F3374F0.3080002@bitmer.com>
 <20120209133739.GB2590@sirena.org.uk> <20120209183624.GJ1426@atomide.com>
 <20120209193442.GA1767@rexfeany.com> <87hayzzjlv.fsf@ti.com>
 <alpine.DEB.2.00.1202091919200.12732@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42175 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752826Ab2BJHKk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Feb 2012 02:10:40 -0500
In-Reply-To: <alpine.DEB.2.00.1202091919200.12732@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>
Cc: Rex Feany <rfeany@laeos.net>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg KH <gregkh@linuxfoundation.org>, Grazvydas Ignotas <notasas@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Fri, Feb 10, 2012 at 07:49:47, Paul Walmsley wrote:
> 
> Kevin and I just doublechecked OMAP37xx BeagleBoard xM here with Tony's 
> testing branch; it works.
> 

I tried it on AM37x EVM, it did worked for me but I have some observations,


1) [root@arago /]# cat /tmp/pm_debug/count
usbhost_pwrdm (ON),OFF:434,RET:466,INA:0,ON:901,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm (ON),OFF:3,RET:2,INA:0,ON:6,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:3,RET:2,INA:0,ON:6,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm (ON),OFF:434,RET:466,INA:0,ON:901,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
neon_pwrdm (ON),OFF:434,RET:466,INA:0,ON:901,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:434,RET:466,INA:0,ON:901,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
iva2_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0


The OFF counter for MPU/NEON/DSS/USB is getting incremented to huge value. Is it expected?
Another observation is, if I include DSS driver into the kernel then I get proper count numbers for dss_pwrdm. (not tried same for usb though)

2) Missing clockdomain in usb clock -

[root@arago /]# dmesg | grep -ir hwmod
[    0.114868] omap_hwmod: usbtll_fck: missing clockdomain for usbtll_fck.
...

3)  Not sure how this can be handled, since from TWL regulator output perspective it is NA. I enabled DUMMY_REGILATOR option and tried it, it works.


[root@arago /]# dmesg | grep -ir fail
[    0.166717] dpll3_m2_clk rate change failed: -22
[    0.828521] sharp_ls_panel display0: failed to set lcd brightness
[    1.672454] smsc911x smsc911x.0: Failed to get supply 'vdd33a': -19
...


Thanks,
Vaibhav
> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

