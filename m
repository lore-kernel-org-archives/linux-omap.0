From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: EHCI on 2.6.32-rc5-git4 + patches
Date: Sun, 1 Nov 2009 09:42:50 -0600
Message-ID: <4551feaf0911010742j6b68113cgb2e4246ca8b26237@mail.gmail.com>
References: <4AEC544A.4000304@blueyonder.co.uk>
	 <5A47E75E594F054BAF48C5E4FC4B92AB0309C86298@dbde02.ent.ti.com>
	 <4AECCB34.9010003@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:56461 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbZKAPmp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Nov 2009 10:42:45 -0500
Received: by yxe17 with SMTP id 17so3868574yxe.33
        for <linux-omap@vger.kernel.org>; Sun, 01 Nov 2009 07:42:50 -0800 (PST)
In-Reply-To: <4AECCB34.9010003@blueyonder.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sboyce@blueyonder.co.uk
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> I am tried "beagleboard_defconfig" I downloaded, but when the .config
> was written at the start of the kernel build ....
> # CONFIG_USB_ARCH_HAS_EHCI is not set.
> " make CROSS_COMPILE=/opt/arm-2009q1/bin/arm-none-linux-gnueabi-" on
> Fedora 12.
> Regards
> Sid.

Hi Sid,

You need atleast the "ehci glue commit" from here to enable the option:

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=shortlog;h=refs/heads/ehci

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
