From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/4] ARM: OMAP3: cm-t35: fix audio
Date: Wed, 19 Oct 2011 15:03:05 +0400
Message-ID: <4E9EAE69.6010305@ru.mvista.com>
References: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il> <1319017160-20391-4-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:44969 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750725Ab1JSLD7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Oct 2011 07:03:59 -0400
In-Reply-To: <1319017160-20391-4-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello.

On 19-10-2011 13:39, Igor Grinberg wrote:

> TWL4030 audio codec is not being registered if no platform data is
> supplied. Plovide platform data for the TWL4030 audio codec.

    s/Plovide/Provide/. Perhaps a committer can fix this typo.

> Signed-off-by: Igor Grinberg<grinberg@compulab.co.il>

WBR, Sergei

