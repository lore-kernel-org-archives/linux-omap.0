From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: N810: latest linux-omap-2.6.git master
Date: Wed, 13 May 2009 12:12:19 +0300
Message-ID: <20090513121219.43206b03.jhnikula@gmail.com>
References: <200905091745.06435.luke@dashjr.org>
	<20090512100658.86a99e98.jhnikula@gmail.com>
	<200905121818.13785.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:55832 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbZEMJKf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 05:10:35 -0400
Received: by an-out-0708.google.com with SMTP id d40so699731and.1
        for <linux-omap@vger.kernel.org>; Wed, 13 May 2009 02:10:36 -0700 (PDT)
In-Reply-To: <200905121818.13785.luke@dashjr.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke Dashjr <luke@dashjr.org>
Cc: linux-omap@vger.kernel.org

On Tue, 12 May 2009 18:18:13 -0500
Luke Dashjr <luke@dashjr.org> wrote:

> > For me mmc is working. I'm booting through the modified initfs with
> > official major number 179 for /dev/mmcblk* device nodes.
> 
> Modified initfs? Is there something needed beyond copying the
> filesystem's modules?
> 
Actually I'm not using modules from initfs at all nor updating them but
I have compiled the ext2 in so that initfs can mount the ext2 formatted
root from mmc (flasher --set-root-device=mmc).

This device node update to initfs is required since Maemo 2.6.21
kernel & initfs are using major number 254 for mmcblk whereas newer
kernels are using 179.

I basically copied initfs from running system or fiasco image, I don't
remember, modified it on desktop and then created new jffs2 image out
of it. That can be then flashed with "flasher -f -n initfs.jffs2".

I think it would be possible to boot modified initfs also from another
mmc partition so that initfs on NAND can be intact.


-- 
Jarkko
