From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: EHCI on 2.6.32-rc5-git4 + patches
Date: Mon, 2 Nov 2009 19:28:47 -0600
Message-ID: <4551feaf0911021728s6587dffchd716ff1241b0373b@mail.gmail.com>
References: <4AEC544A.4000304@blueyonder.co.uk>
	 <5A47E75E594F054BAF48C5E4FC4B92AB0309C86298@dbde02.ent.ti.com>
	 <4AECCB34.9010003@blueyonder.co.uk>
	 <4551feaf0911010742j6b68113cgb2e4246ca8b26237@mail.gmail.com>
	 <4AEE19F4.70000@blueyonder.co.uk> <20091102070409.GA17351@nokia.com>
	 <4AEF8294.4000108@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.223.180]:65282 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757521AbZKCB2m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Nov 2009 20:28:42 -0500
Received: by iwn10 with SMTP id 10so3789590iwn.4
        for <linux-omap@vger.kernel.org>; Mon, 02 Nov 2009 17:28:47 -0800 (PST)
In-Reply-To: <4AEF8294.4000108@blueyonder.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sboyce@blueyonder.co.uk
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> I tried that and various others to get other than the hub enumerated, no
> luck so far with kernels I have built - no lights on the hub. I am now
> rebuilding after following the config for the working narcissus build,
> EHCI looks much the same, so here's hoping.
> I have another 16G MMC card I am trying on after cross compiling on a
> Fedora 12 VirtualBox VM.
> Regards
> Sid.

Hi Sid

I eventually got ehci working today on my tree on launchpad.  But it's
not that small of a patch once i added all the mach to plat changes...

However, this commit made all the difference for me, it's currently
missing from tmlind's tree, the beagleboard needs it to enable power
to the ehci..

http://patchwork.kernel.org/patch/55703/

Regards,
-- 
Robert Nelson
http://www.rcn-ee.com/
