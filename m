From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] Initial support for OMAP3 Thunder board
Date: Thu, 10 Dec 2009 22:52:45 +0200
Message-ID: <20091210205245.GA27900@nokia.com>
References: <4B21593C.9060409@dmhome.net>
 <20091210204821.GV24013@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62822 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758130AbZLJUwz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Dec 2009 15:52:55 -0500
Content-Disposition: inline
In-Reply-To: <20091210204821.GV24013@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Daniel Toussaint <daniel@dmhome.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Dec 10, 2009 at 09:48:22PM +0100, ext Tony Lindgren wrote:
>> See attached patch for this board:
>> http://www.technexion.com/index.php/thunder
>> The patch contains board file, support for an LCD panel under DSS2
>> and support for Alsa sound.
>
>Cool. Can you please split the the patches into following
>separate patches:
>
>1. Add minimal board support
>2. Add defconfig
>3. Add ASoC support
>4. Add DSS2 support
>
>Then please run all the patches through scripts/checkpatch.pl --strict
>and fix the errors and warnings.
>
>And please make sure things keep compiling through the
>all the patches, otherwise git bisect will break.

if possible, please run sparse as well.

-- 
balbi
