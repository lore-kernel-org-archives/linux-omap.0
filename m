From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 3/4] ARM: OMAP3: cm-t35: fix audio
Date: Wed, 19 Oct 2011 15:56:34 +0200
Message-ID: <4E9ED712.8090408@compulab.co.il>
References: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il> <1319017160-20391-4-git-send-email-grinberg@compulab.co.il> <4E9EAE69.6010305@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:53897
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752774Ab1JSN4r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Oct 2011 09:56:47 -0400
In-Reply-To: <4E9EAE69.6010305@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Sergei,

On 10/19/11 13:03, Sergei Shtylyov wrote:
> Hello.
> 
> On 19-10-2011 13:39, Igor Grinberg wrote:
> 
>> TWL4030 audio codec is not being registered if no platform data is
>> supplied. Plovide platform data for the TWL4030 audio codec.
> 
>    s/Plovide/Provide/. Perhaps a committer can fix this typo.

This one is really nice ;)
Thanks

-- 
Regards,
Igor.
