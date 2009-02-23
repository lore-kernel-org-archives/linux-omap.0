From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: Help- twl4030 audio driver for linux2.6.26 + OMAP2430
Date: Mon, 23 Feb 2009 14:34:26 +0200
Message-ID: <49A297D2.6080903@gmail.com>
References: <OFFFD173E7.3B237D8B-ON65257566.00433D9C-65257566.004396D1@lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f167.google.com ([209.85.220.167]:40561 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbZBWMeb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 07:34:31 -0500
Received: by fxm11 with SMTP id 11so1684140fxm.13
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2009 04:34:29 -0800 (PST)
In-Reply-To: <OFFFD173E7.3B237D8B-ON65257566.00433D9C-65257566.004396D1@lntinfotech.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mathews John <Mathews.John@lntinfotech.com>
Cc: linux-omap@vger.kernel.org

Mathews John said the following on 02/23/2009 02:18 PM:
> I am a newbie in linux, and i am trying to make audio working on OMAP-2430 
> board. Linux version used is linux-2.6.26. I am trying to find twl4030 
> audio driver in net. But couldn't get it. Can anybody please help me???
>
>   

Just follow [1] to get the code downloaded. then look at
sound/soc/codecs/twl4030.c (quick link - [2])
Regards,
Nishanth Menon
Ref:
[1] http://muru.com/linux/omap/README_OMAP_GIT
[2]
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blob;f=sound/soc/codecs/twl4030.c;h=ea370a4f86d5a2c74d97b176d977a55947ab120e;hb=HEAD
