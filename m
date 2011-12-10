From: Andre Puschmann <andre.puschmann@tu-ilmenau.de>
Subject: Re: MMC not working reliably for Gumstix Overo Tide
Date: Sat, 10 Dec 2011 14:41:02 +0100
Message-ID: <jbvnhe$m22$1@dough.gmane.org>
References: <jbua2s$8qq$1@dough.gmane.org> <CAMP44s27Omkuhy9RUi-TfhjoWUr37XEYiSKnCcC=5Tk9UKpT9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:49755 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149Ab1LJNlV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Dec 2011 08:41:21 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1RZNAz-0007Yk-OY
	for linux-omap@vger.kernel.org; Sat, 10 Dec 2011 14:41:17 +0100
Received: from vpn12.rz.tu-ilmenau.de ([141.24.172.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 10 Dec 2011 14:41:17 +0100
Received: from andre.puschmann by vpn12.rz.tu-ilmenau.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 10 Dec 2011 14:41:17 +0100
In-Reply-To: <CAMP44s27Omkuhy9RUi-TfhjoWUr37XEYiSKnCcC=5Tk9UKpT9A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On 12/10/2011 02:24 AM, Felipe Contreras wrote:
> On Sat, Dec 10, 2011 at 2:45 AM, Andre Puschmann
> <andre.puschmann@tu-ilmenau.de> wrote:
>> I've got a Gumstix Overo Tide (OMAP 3530) based board here which doesn't
>> have NAND and therefore needs the MMC to boot.
>>
>> I've successfully built a kernel using Tony's master branch. The system
>> boots fine up to the point where the MMC driver loads (well, I guess
>> that is where the problem lies). I am using omap2plus_defconfig. The
>> weird thing is that sometimes the system hangs after printing "Waiting
>> for root device /dev/mmcblk0p2..." and sometimes after mounting the
>> rootfs. Any ideas? I've seen some probelms with MMC in the recent past,
>> could that be the cause?
> 
> Have you tried this in the command line? rootwait rootdelay=1

Jup, doesn't help, unfortunately.

-Andre

