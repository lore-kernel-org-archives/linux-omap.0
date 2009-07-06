From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: User/kernel memory split
Date: Mon, 6 Jul 2009 15:55:48 +0530
Message-ID: <01c701c9fe24$2339d440$LocalHost@wipultra793>
References: <017301c9fe1f$91b92100$LocalHost@wipultra793> <B85A65D85D7EB246BE421B3FB0FBB59301D84C009A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49700 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224AbZGFK0K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Jul 2009 06:26:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

----- Original Message ----- 
From: "Dasgupta, Romit" <romit@ti.com>


Hemanth,
                   Why do you want the split? Do you have physical mem > 1G 
in your system?

We want to fit 512MB RAM on 2.6.27 Kernel which doesnot have highmem option.
We also donot want to disturb the current I/O memory map

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner@vger.kernel.org] On Behalf Of V, Hemanth
>Sent: Monday, July 06, 2009 3:23 PM
>To: linux-arm-kernel@lists.arm.linux.org.uk; linux-omap@vger.kernel.org
>Subject: User/kernel memory split
>
>Hi All
>
>Has anyone tried 3.5G/1.5G user/kernel memory split.
>Are there any know issues in this.
>
>Thanks
>Hemanth
>
>
>arch/arm/Kconfig
>choice
>        prompt "Memory split"
>        default VMSPLIT_3G
>        help
>          Select the desired split between kernel and user memory.
>
>          If you are not absolutely sure what you are doing, leave this
>          option alone!
>
>        config VMSPLIT_3G
>                bool "3G/1G user/kernel split"
>        config VMSPLIT_2G
>                bool "2G/2G user/kernel split"
>        config VMSPLIT_1G
>                bool "1G/3G user/kernel split"
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html


