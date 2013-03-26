From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.9-rc3
Date: Tue, 26 Mar 2013 18:29:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303261817540.23957@utopia.booyaka.com>
References: <alpine.DEB.2.00.1303181536230.29332@utopia.booyaka.com> <51482707.6020501@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39178 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760087Ab3CZS3l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Mar 2013 14:29:41 -0400
In-Reply-To: <51482707.6020501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Kristo, Tero" <t-kristo@ti.com>

Hi

On Tue, 19 Mar 2013, Santosh Shilimkar wrote:

> On Monday 18 March 2013 09:08 PM, Paul Walmsley wrote:
>
> > Test summary
> > ------------
> > 
> Thanks for the summary Paul. A usual, it is quite exhaustive.

Would that it were true.  These tests are really only very superficial.  
Here are some major missing areas:

- other devices (audio, video, etc.)
- stability testing - does the board hang or freeze across 24 hours to 
  a week of uptime?
- CPU DVFS
- current consumption during active, ret idle, off idle
- multiple bootloaders
- multiple rootfs originations (across boards that support several) -- 
  e.g., NFS, MMC, etc.

If I were basing anything off the mainline kernel, that's the minimum I'd 
like to see.

> > 
> > * 4430es2panda, 4460pandaes: pwrdm state mismatch on CAM, DSS, ABE
> > 
> I thought we discussed about boot-loader dependency already. 
> 
> > * 4460pandaes: pwrdm state mismatch on IVAHD, TESLA 
> > 
> Same here.

Have these issues been confirmed to be bootloader-related?

If so, then we can mark these as cases where the kernel isn't resetting 
devices properly.

> > * 4430es2panda: CORE, TESLA, IVAHD, L3INIT didn't enter target state
> >   - Probably due to lack of reset code for M3, DSP, SL2IF, FSUSB
> >     per discussion with Tero Kristo
> >   - Likely dependent on the bootloader version
> >     - fails with 2012.07-00136-g755de79
> > 
> Do you still see the issue after upgrading the boot-loader version ?

Haven't tried yet.

> > * 4460pandaes: chip not entering retention in dynamic idle
> >   - Presumably 4430es2panda also fails this
> >   - Suspend-to-RAM enters full chip retention
> > 
> Assuming dynmic idle is CPUIdle, core retention isn't supported
> in CPUDILE so it is expected

No, it's not CPUIdle.  It's simply echoing a power management timeout to 
the UART autosuspend sysfs entries.  You can see exactly what's done by 
checking the pm/ directory in the test logs, for example:

http://www.pwsan.com/omap/testlogs/test_v3.9-rc4/20130324120244/pm/

OMAP4 should be able to enter full-chip retention idle without CPUIdle, as 
OMAP3 does.  If the current kernel depends on CPUIdle to do this on OMAP4, 
that's a bug.

> > Other:
> > 
> > * 4430es2panda: omap_hwmod: l3_instr: _wait_target_disable failed
> >   - Unknown cause; could be due to the lack of hierarchical enable/disable
> >     in hwmod code
> >   - Jon Hunter reports this does not appear with the same X-loader/bootloader
> >     on his 4430ES2.3 Panda, so could be ES-level dependent
> I confirm Jon's observation even on my OMAP4430 ES2.3 SDP.

Thanks, I put this in the v3.9-rc4 README.


- Paul
