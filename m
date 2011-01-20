From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] ARM: oprofile: Always allow backtraces
Date: Thu, 20 Jan 2011 15:31:34 +0300
Message-ID: <4D382B26.9030801@ru.mvista.com>
References: <1295470473-1095-1-git-send-email-kauppi@papupata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42087 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924Ab1ATMcp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 07:32:45 -0500
Received: by ewy5 with SMTP id 5so186968ewy.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 04:32:44 -0800 (PST)
In-Reply-To: <1295470473-1095-1-git-send-email-kauppi@papupata.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ari Kauppi <kauppi@papupata.org>
Cc: robert.richter@amd.com, Matt Fleming <matt@console-pimps.org>, Will Deacon <will.deacon@arm.com>, Richard Purdie <rpurdie@rpsys.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello.

On 19-01-2011 23:54, Ari Kauppi wrote:

> Always allow backtrace when using oprofile on ARM, even if a PMU
> isn't present.

> Restores functionality originally introduced in
> 1b7b56982fdcd9d85effd76f3928cf5d6eb26155 by Richard Purdie.

    You're lacking the commit summary specified in parens which Linus asked to 
add.

> Signed-off-by: Ari Kauppi<kauppi@papupata.org>
> Cc: Richard Purdie<rpurdie@rpsys.net>
> Cc: Will Deacon<will.deacon@arm.com>
> Cc: Matt Fleming<matt@console-pimps.org>

WBR, Sergei
