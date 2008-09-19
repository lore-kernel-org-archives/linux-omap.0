From: twebb <taliaferro62@gmail.com>
Subject: Re: getting 2.6.25 from git to run on omap35x evm
Date: Fri, 19 Sep 2008 14:29:54 -0400
Message-ID: <dbdb2ea60809191129k17dd8710j8c10cc17eb0dd637@mail.gmail.com>
References: <dbdb2ea60809171136v5a380989mf57aca6ff1df5aba@mail.gmail.com>
	 <ADBD1DC1-66B1-4EE2-92D8-051C5B91FC1C@student.utwente.nl>
	 <dbdb2ea60809171223h7ef92c3dg6a4d41f29b9b8c1e@mail.gmail.com>
	 <1f11a5490809171236k52fcc05q74ce5dfe1882d5cb@mail.gmail.com>
	 <dbdb2ea60809171311g13631826m4b46a881ebbb1ae5@mail.gmail.com>
	 <FCCFB4CDC6E5564B9182F639FC356087022A2BAB54@dbde02.ent.ti.com>
	 <dbdb2ea60809190824w507aa4f4j5754b0b73d2664fe@mail.gmail.com>
	 <98D88699-2EF7-4976-95BE-65CCD490C135@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:19228 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbYISS3z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 14:29:55 -0400
Received: by wa-out-1112.google.com with SMTP id j37so419293waf.23
        for <linux-omap@vger.kernel.org>; Fri, 19 Sep 2008 11:29:54 -0700 (PDT)
In-Reply-To: <98D88699-2EF7-4976-95BE-65CCD490C135@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

>
> The irq 369 problem is present on l-o git as well, no idea what's causing
> it. Basically: 2.6.26 is awesome, 2.6.27rc is broken crap[1].
>
> regards,
>
> Koen
>
> [1] At least on beagle and evm, overo seems to work after a musb patch
>

Which is awesome, 2.6.26 on omapzoom.git or on linux-omap git?

I try linux-omap git (tag = v2.6.26-omap2) and have problems mounting
rootfs.  Appears to be trying to mount root via NFS and ignoring
kernel command line specifying the mtdblock...

Kernel command line: mem=128M console=ttyS0,115200n8 noinitrd root=/dev/mtdblock
4 rw rootfstype=jffs2 ip=192.168.1.200:192.168.1.123:192.168.1.2:255.255.255.0::
eth0:on

Thanks,
twebb
