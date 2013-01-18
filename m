From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] am33xx: cpsw: default to ethernet hwaddr from efuse if not defined in dt
Date: Fri, 18 Jan 2013 14:27:20 +0100
Message-ID: <87ip6uiptz.fsf@dell.be.48ers.dk>
References: <1358370073-32545-1-git-send-email-jacmet@sunsite.dk>
	<loom.20130117T105358-639@post.gmane.org>
	<87a9s7lq09.fsf@dell.be.48ers.dk>
	<CAAfrEwYGMwVfxD2z6xKfzyn-252B2UT0AuxD36rZsct11Pi52w@mail.gmail.com>
	<87obgmkhs2.fsf@dell.be.48ers.dk>
	<CAAfrEwaoFxRON0dJceMXeGEG-=tgUmqThEcwid2wiiLWTJYE-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:55857 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab3ARN1Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jan 2013 08:27:24 -0500
Received: by mail-ea0-f174.google.com with SMTP id 1so1443738eaa.5
        for <linux-omap@vger.kernel.org>; Fri, 18 Jan 2013 05:27:23 -0800 (PST)
In-Reply-To: <CAAfrEwaoFxRON0dJceMXeGEG-=tgUmqThEcwid2wiiLWTJYE-A@mail.gmail.com>
	(Michal Bachraty's message of "Fri, 18 Jan 2013 13:22:32 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michal Bachraty <michal.bachraty@gmail.com>, linux-omap@vger.kernel.org

>>>>> "Michal" == Michal Bachraty <michal.bachraty@gmail.com> writes:

Hi,

 Michal> I'm ok with your changes. Have you tried to set MAC from
 Michal> u-boot? I haven't seen any code for that purpose in cpsw. I
 Michal> tried put MAC with kernel command parameter (in u-boot), but
 Michal> nothing happen.

I didn't actually try, but mainline U-Boot has support for updating the
mac-address properties if you:

 - build U-Boot with dt support (CONFIG_OF_LIBFDT)
 - use a seperate .dtb file
 - add aliases called ethernet{0,1} to the 2 cpsw slaves in the dts
   (this should arguable be done in am33xx.dtsi) - E.G.:

 aliases {
   ..
   ethernet0 = &cpsw_emac0;
   ethernet1 = &cpsw_emac1;
 };

Then U-boot will set the mac-address properties to the content of the
ethaddr / eth1addr environment variables. See fdt_fixup_ethernet() for
details.

-- 
Bye, Peter Korsgaard
