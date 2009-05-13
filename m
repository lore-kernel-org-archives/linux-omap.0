From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: ARM: CONFIG_FRAME_POINTER
Date: Wed, 13 May 2009 14:16:50 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A87396A21BE@dlee01.ent.ti.com>
References: <7B4574D56E4ADF438756313E9A172A87396257F0@dlee01.ent.ti.com>
	<87zldhaoco.fsf@deeprootsystems.com>
	<7B4574D56E4ADF438756313E9A172A87396A1DF6@dlee01.ent.ti.com>
	<8763g57ydn.fsf@deeprootsystems.com>
	<7B4574D56E4ADF438756313E9A172A87396A2052@dlee01.ent.ti.com>
 <87d4ac6fjw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38617 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760409AbZEMTQ4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 15:16:56 -0400
In-Reply-To: <87d4ac6fjw.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kevin,

> Just base it at Linus' master branch or the latest -rc tag.

Thanks. Patch sent. My post appears to be in a holding location as I am not a member of the linux-arm mailing list. I will let you know if I get any feedback. 

By the way, I found out that the real culprit of this problem was the following change:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=64dec40ddee9d36d7b83f8a0513fdeaffe260a0e;hp=a3c6018e565dc07cf3738ace6bbe412f97b1bba8

Cheers
Jon 
