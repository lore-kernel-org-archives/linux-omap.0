From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: linux-next: manual merge of the omap_dss2 tree with the omap
 tree
Date: Tue, 17 Nov 2009 03:08:28 +0000
Message-ID: <4B0213AC.6050502@blueyonder.co.uk>
References: <20091116160402.deb0cc82.sfr@canb.auug.org.au>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:34152 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752085AbZKQDI3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Nov 2009 22:08:29 -0500
Received: from [172.23.170.145] (helo=anti-virus03-08)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1NAEQk-0005uE-Kx
	for linux-omap@vger.kernel.org; Tue, 17 Nov 2009 03:08:34 +0000
Received: from [94.171.130.58] (helo=[192.168.10.2])
	by asmtp-out5.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1NAEQk-0001N6-2M
	for linux-omap@vger.kernel.org; Tue, 17 Nov 2009 03:08:34 +0000
In-Reply-To: <20091116160402.deb0cc82.sfr@canb.auug.org.au>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 16/11/09 05:04, Stephen Rothwell wrote:
> Hi Tomi,
> 
> Today's linux-next merge of the omap_dss2 tree got a conflict in
> arch/arm/configs/omap_3430sdp_defconfig between the omap tree and the
> omap_dss2 tree.
> 
> I just used the version from the omap tree as I can't figure out anything
> better, sorry.

In every incarnation, EHCI support is missing " default y if
ARCH_OMAP34XX" in drivers/usb/Kconfig
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

