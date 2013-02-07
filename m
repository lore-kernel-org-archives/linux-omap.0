From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: DT GPMC SRAM and NOR flash support ?
Date: Thu, 07 Feb 2013 09:51:31 +0000
Message-ID: <51137923.4070301@mimc.co.uk>
References: <510BF3D3.3000304@mimc.co.uk> <510BF766.5090608@ti.com> <510C19FC.8090906@mimc.co.uk> <5111304C.7090706@mimc.co.uk> <511134C8.8000008@ti.com> <511137CF.1090706@mimc.co.uk> <51113C74.4070607@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:48115 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751962Ab3BGJvc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Feb 2013 04:51:32 -0500
In-Reply-To: <51113C74.4070607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Afzal Mohammed <afzal@ti.com>

Okay ... I have made some progress, but it's not ideal.

Currently I've hacked the GPMC DT driver (gpmc_probe_dt(), etc) so it now handles setting up the
chip selects and timings for NOR devices, e.g.

		gpmc: gpmc@50000000 {
			status = "okay";
			ranges = <0 0 0x08000000 0x08000000>;	/* CS0: NOR 16M */
			
			nor@0,0 {
				compatible = "spansion,s29gl064n90t", "cfi-flash";
				reg = <0 0 0>;
				bank-width = <2>;

				gpmc,sync-clk = <0>;
				gpmc,cs-on = <10>;
				gpmc,cs-rd-off = <150>;
				gpmc,cs-wr-off = <150>;
				gpmc,adv-on = <10>;
				gpmc,adv-rd-off = <10>;
				gpmc,adv-wr-off = <10>;
				gpmc,oe-on = <30>;
				gpmc,oe-off = <150>;
				gpmc,we-on = <30>;
				gpmc,we-off = <150>;
				gpmc,rd-cycle = <150>;
				gpmc,wr-cycle = <150>;
				gpmc,access = <130>;
				gpmc,page-burst-access = <10>;
				gpmc,cycle2cycle-diff = <1>;
				gpmc,cycle2cycle-same = <1>;
				gpmc,cycle2cycle-delay = <10>;
				gpmc,wr-data-mux-bus = <60>;
			};
		};

But the physmap driver (of_flash_probe()) is unable to use this information.  It seems that although
I can call of_flash_probe() from my NOR setup code, the platform_device being reference is wrong.

The platform_device passed to my gpmc_probe_nor_child() routine from gpmc_probe_dt() points to my
gpmc entry (above), but the physmap probe requires its own DT entry (rather than a node child such
as my NOR entry with the GPMC device entry).

So I need to have any extra entry in the DT file as follows:-

	nor-flash@08000000 {
		compatible = "spansion,s29gl064n90t", "cfi-flash";
		reg = <0x08000000 0x00800000>;
		bank-width = <2>;
	};

So the GPMC entry handles all the chip select and timing setup, but the 2nd entry is the only one
the physmap driver can see.

Would it be acceptable to re-code of_flash_probe() to allow either a child device_node to be passed
or a platform_device ?

Cheers
Mark J.
