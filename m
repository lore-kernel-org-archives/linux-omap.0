From: Felipe Balbi <balbi@ti.com>
Subject: Re: Does omap git have support for overo board.
Date: Tue, 8 Feb 2011 14:04:03 +0200
Message-ID: <20110208120403.GC14073@legolas.emea.dhcp.ti.com>
References: <4D512702.9040708@e-consystems.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:52594 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752491Ab1BHMEK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 07:04:10 -0500
Received: by yxd5 with SMTP id 5so2216937yxd.34
        for <linux-omap@vger.kernel.org>; Tue, 08 Feb 2011 04:04:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D512702.9040708@e-consystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mohamed Thalib H <mohamed@e-consystems.com>
Cc: linux-omap@vger.kernel.org

On Tue, Feb 08, 2011 at 04:50:34PM +0530, Mohamed Thalib H wrote:
> Hi all,
> 
> I have pull the latest git from "http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=summary".
> But couldn't find config file for overo . So I used
> "omap2plus_defconfig" and made sure the overo board is selected.
> 
> But the board didn't boot. It stopped after uncompressing kernel .
> 
> Bytes transferred = 3011064 (2df1f8 hex)
> ## Booting kernel from Legacy Image at 82000000 ...
>    Image Name:   Linux-2.6.38-rc2-13606-g448e9a6-
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    3011000 Bytes =  2.9 MB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
> 
> Starting kernel ...
> 
> Uncompressing Linux... done, booting the kernel. <---- Hangs after this.
> 
> Does the mainline has the support for overo board. Or am I missing
> something.

Last I checked it was working. Maybe you need to change bootargs ? At
least console has changed from ttyS2 to ttyO2, care to change that and
check ?

-- 
balbi
