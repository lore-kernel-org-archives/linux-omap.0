From: Cyril Chemparathy <cyril@ti.com>
Subject: Re: [PATCH 6/8] netdev: separate out davinci cpdma controller code
Date: Tue, 03 Aug 2010 20:46:41 -0400
Message-ID: <4C58B871.8070107@ti.com>
References: <1280842313-3743-1-git-send-email-cyril@ti.com> <1280842313-3743-7-git-send-email-cyril@ti.com> <27F9C60D11D683428E133F85D2BB4A53043F3C8C2B@dlee03.ent.ti.com>
Reply-To: cyril@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53612 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932121Ab0HDAqp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Aug 2010 20:46:45 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043F3C8C2B@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Govindarajan, Sriramakrishnan" <srk@ti.com>

Hi Omar,

[...]
>> +	if (ctlr->channels[chan_num])
>> +		goto err_chan_busy;
> 
> Mem leaking 'chan'
> 

Thanks.  Will modify for v2.

Regards
Cyril.
