From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Mistral AM37x (with AM3715) devel board networking broken
Date: Sun, 7 Nov 2010 00:32:17 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930233D96C6C@dbde02.ent.ti.com>
References: <E1PEkZb-0003Te-AB@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49813 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901Ab0KFTGE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Nov 2010 15:06:04 -0400
In-Reply-To: <E1PEkZb-0003Te-AB@amazonia.comcast.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rick Bronson <rick@efn.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "srinath@mistralsolutions.com" <srinath@mistralsolutions.com>

> From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] On Behalf Of Rick Bronson [rick@efn.org]
> Sent: Saturday, November 06, 2010 8:50 PM
> To: linux-omap@vger.kernel.org
> Cc: srinath@mistralsolutions.com
> Subject: Mistral AM37x (with AM3715) devel board networking broken
> 
> Hi,
> 
>   Should I be able to use the latest omap-linux-2.6 on this board?  I
> tried:
> 
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> cd linux-omap-2.6; make omap2plus_defconfig ARCH=arm; make
> 
>   I get some warnings when it boots but it fails to setup the
> networking (smsc911x) correctly.  The boot log is here
> http://www.efn.org/~rick/pub/boot1.log
> 
>   Just wondered if anyone has any ideas?
> 
[sp] On first looks I would suspect the u-boot. 2009.11 seems to be quite old.
     Can you try using version 2010.09?

~sanjeev
> 
>   Thanks much for any help.
> 
>   Rick
>                                                                    _
>                                                                   | |
>                                                                   / /__
> .----------------------------------------------------------._____/ (___)
> | Rick Bronson    rick at efn dot org    Tel 541-485-7264  |       (___)
> | Amazonia Computing http://www.efn.org/~rick      __ o    |_____  (___)
> | 5050 Donald Street       Embedded Linux         _`\<,    |     \_(___)
> | Eugene, OR  97405     Software Engineering   __( )/( )__ |
> `----------------------------------------------------------'
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
