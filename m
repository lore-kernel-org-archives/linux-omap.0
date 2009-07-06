From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: User/kernel memory split
Date: Mon, 6 Jul 2009 15:48:13 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301D84C009A@dbde02.ent.ti.com>
References: <017301c9fe1f$91b92100$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49271 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892AbZGFKSc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jul 2009 06:18:32 -0400
In-Reply-To: <017301c9fe1f$91b92100$LocalHost@wipultra793>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "V, Hemanth" <hemanthv@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hemanth,
                   Why do you want the split? Do you have physical mem > 1G in your system?

Thanks,
-Romit


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

