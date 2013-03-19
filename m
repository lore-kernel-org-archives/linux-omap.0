From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: OMAP baseline test results for v3.9-rc3
Date: Tue, 19 Mar 2013 14:21:19 +0530
Message-ID: <51482707.6020501@ti.com>
References: <alpine.DEB.2.00.1303181536230.29332@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44126 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755538Ab3CSIte (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Mar 2013 04:49:34 -0400
In-Reply-To: <alpine.DEB.2.00.1303181536230.29332@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Kristo, Tero" <t-kristo@ti.com>

+ Tero,

On Monday 18 March 2013 09:08 PM, Paul Walmsley wrote:
> 
> Here are some basic OMAP test results for Linux v3.9-rc3.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.9-rc3/20130314094808/
> 
> 
> Test summary
> ------------
> 
Thanks for the summary Paul. A usual, it is quite exhaustive. Few
questions and comments below.

[..]

> Failing tests: needing investigation
> ------------------------------------
> 

[..]

> PM tests:
> 
[..]

> 
> * 4430es2panda, 4460pandaes: pwrdm state mismatch on CAM, DSS, ABE
> 
I thought we discussed about boot-loader dependency already. 

> * 4460pandaes: pwrdm state mismatch on IVAHD, TESLA 
> 
Same here.

> * 4430es2panda: CORE, TESLA, IVAHD, L3INIT didn't enter target state
>   - Probably due to lack of reset code for M3, DSP, SL2IF, FSUSB
>     per discussion with Tero Kristo
>   - Likely dependent on the bootloader version
>     - fails with 2012.07-00136-g755de79
> 
Do you still see the issue after upgrading the boot-loader version ?

> * 4460pandaes: chip not entering retention in dynamic idle
>   - Presumably 4430es2panda also fails this
>   - Suspend-to-RAM enters full chip retention
> 
Assuming dynmic idle is CPUIdle, core retention isn't supported
in CPUDILE so it is expected

> 
> Other:
> 
> * 4430es2panda: omap_hwmod: l3_instr: _wait_target_disable failed
>   - Unknown cause; could be due to the lack of hierarchical enable/disable
>     in hwmod code
>   - Jon Hunter reports this does not appear with the same X-loader/bootloader
>     on his 4430ES2.3 Panda, so could be ES-level dependent
I confirm Jon's observation even on my OMAP4430 ES2.3 SDP.

Regards,
Santosh

