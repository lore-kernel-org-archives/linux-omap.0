From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Problems booting Filesystem
Date: Mon, 10 Mar 2008 22:18:50 +0200
Message-ID: <20080310201849.GF4459@kedavra.cpe.vivax.com.br>
References: <ae36f8040803101227i6be46d20y6bbc49b06deb4f7d@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:59490 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757457AbYCJUQi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2008 16:16:38 -0400
Content-Disposition: inline
In-Reply-To: <ae36f8040803101227i6be46d20y6bbc49b06deb4f7d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lu?s Vit?rio Cargnini <lvcargnini@gmail.com>
Cc: linux-omap@vger.kernel.org

On Mon, Mar 10, 2008 at 04:27:40PM -0300, Lu?s Vit?rio Cargnini wrote:
> Dear Fellows:
> I'm trying to boot my new filesystem but I'm having the following problems:
> FIXME: Clock "tc2_ck" seems unused
> Disabling unused clock "tc1_ck"...  done
> Skipping reset check for DSP domain clock "dsptim_ck"
> Skipping reset check for DSP domain clock "dspxor_ck"
> Skipping reset check for DSP domain clock "dspper_ck"
> List of all partitions:
> 0100       8192 ram0 (driver?)
> 0101       8192 ram1 (driver?)
> 0102       8192 ram2 (driver?)
> 0103       8192 ram3 (driver?)
> 0104       8192 ram4 (driver?)
> 0105       8192 ram5 (driver?)
> 0106       8192 ram6 (driver?)
> 0107       8192 ram7 (driver?)
> 0108       8192 ram8 (driver?)
> 0109       8192 ram9 (driver?)
> 010a       8192 ram10 (driver?)
> 010b       8192 ram11 (driver?)
> 010c       8192 ram12 (driver?)
> 010d       8192 ram13 (driver?)
> 010e       8192 ram14 (driver?)
> 010f       8192 ram15 (driver?)
> 1f00        128 mtdblock0 (driver?)
> 1f01        128 mtdblock1 (driver?)
> 1f02       2048 mtdblock2 (driver?)
> 1f03      30464 mtdblock3 (driver?)
> No filesystem could mount root, tried:  ext2
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(31,3)
> 
> someone could help with this issue?
> 
> my filesystem have 16M, the image file.
> I'm using the latest version of mkfs.jffs2, from git of mtd-utils

you should add your .config here.
Why is it creating so many partitions on ram? and where's the driver for
that ?

Did you change the kernel somewhat ?

please attach .config

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
