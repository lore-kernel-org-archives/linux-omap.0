From: Srikar <ext-srikar.1.bhavanarayana@nokia.com>
Subject: Re: [PATCH 2/2] enabled vdda_dac regulator support tvout on rx51
Date: Wed, 22 Dec 2010 13:51:06 +0200
Message-ID: <4D11E62A.4060701@nokia.com>
References: <1290700343-26640-1-git-send-email-ext-srikar.1.bhavanarayana@nokia.com> <1290700343-26640-2-git-send-email-ext-srikar.1.bhavanarayana@nokia.com> <20101125161112.GB15099@sirena.org.uk> <4CEF8453.3070904@nokia.com> <20101126125949.GD30360@rakim.wolfsonmicro.main> <20101126174517.GE2990@atomide.com> <20101127101852.GA27579@opensource.wolfsonmicro.com> <20101129181830.GC17222@atomide.com> <20101129183703.GS30360@rakim.wolfsonmicro.main> <20101130173954.GO17222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:62306 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826Ab0LVLv1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Dec 2010 06:51:27 -0500
In-Reply-To: <20101130173954.GO17222@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, jhnikula@gmail.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org

Updated version of patch of this is available at

https://patchwork.kernel.org/patch/424731/



On 11/30/2010 07:39 PM, ext Tony Lindgren wrote:
> * Mark Brown <broonie@opensource.wolfsonmicro.com> [101129 10:27]:
>> On Mon, Nov 29, 2010 at 10:18:31AM -0800, Tony Lindgren wrote:
>>> * Mark Brown <broonie@opensource.wolfsonmicro.com> [101127 02:10]:
>>>> Yeah.  Some of it will need to be __devinitdata for hotpluggable things
>>>> but most of it should be __initdata.  I'll update the regulator API to
>>>> copy the constraints before the next merge window.
>>> OK sounds good to me.
>> FWIW the patch is "regulator: Copy constraints from regulators when
>> initialising them", posted for review today.
> Great, once that merges we'll start checking what can be __init or
> __init_or_module for the omap board-*.c files.
>
> Tony

