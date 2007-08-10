From: Dirk Behme <dirk.behme@googlemail.com>
Subject: WARNING at kernel/irq/resend.c:70 check_irq_resend() on OSK
Date: Fri, 10 Aug 2007 19:00:09 +0200
Message-ID: <46BC9999.30805@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Frist, thanks for updating the kernel! Tested on OSK, everything looks 
okay.

While booting on OSK, I get stuff below. Any idea? Note that kernel 
goes on booting and nothing feels broken.

Best regards

Dirk

...
Initializing OMAP McBSP system
omap_dsp_init() done
USB: hmc 16, usb2 alt 0 wires
i2c_omap i2c_omap.1: bus 1 rev2.2 at 100 kHz
tps65010: version 2 May 2005
WARNING: at kernel/irq/resend.c:70 check_irq_resend()
[<c0028ffc>] (dump_stack+0x0/0x14) from [<c0074218>] 
(check_irq_resend+0x64/0)
[<c00741b4>] (check_irq_resend+0x0/0x10c) from [<c00737ac>] 
(enable_irq+0x9c/)
  r7:c031e834 r6:00000048 r5:80000013 r4:c0256684
[<c0073710>] (enable_irq+0x0/0xe8) from [<c0157994>] 
(tps65010_work+0x230/0x2)
  r5:c031e600 r4:c031e788
[<c0157764>] (tps65010_work+0x0/0x260) from [<c001b6e4>] 
(tps65010_probe+0x27)
  r5:c025d124 r4:c031e600
[<c001b468>] (tps65010_probe+0x0/0x2c8) from [<c01544dc>] 
(i2c_probe_address+)
  r7:00000048 r6:00000048 r5:c031e834 r4:00000000
[<c015440c>] (i2c_probe_address+0x0/0x120) from [<c0155640>] 
(i2c_probe+0x1bc)
[<c0155484>] (i2c_probe+0x0/0x1d4) from [<c001b36c>] 
(tps65010_scan_bus+0x3c/)
[<c001b330>] (tps65010_scan_bus+0x0/0x50) from [<c0155168>] 
(i2c_register_dri)
  r4:c031e834
[<c01550a8>] (i2c_register_driver+0x0/0x108) from [<c001b3b4>] 
(tps_init+0x34)
  r6:c001fa00 r5:c025d124 r4:00000002
[<c001b380>] (tps_init+0x0/0xe8) from [<c00087c0>] 
(kernel_init+0xb8/0x284)
  r6:c001fa00 r5:00000000 r4:c0020404
[<c0008708>] (kernel_init+0x0/0x284) from [<c00508d0>] (do_exit+0x0/0x924)
Time: 32k_counter clocksource has been installed.
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
...
