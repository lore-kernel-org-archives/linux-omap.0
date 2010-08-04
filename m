From: Cyril Chemparathy <cyril@ti.com>
Subject: Re: [PATCH 1/8] netdev: separate out davinci mdio controller code
Date: Tue, 03 Aug 2010 20:44:41 -0400
Message-ID: <4C58B7F9.6010608@ti.com>
References: <1280842313-3743-1-git-send-email-cyril@ti.com> <1280842313-3743-2-git-send-email-cyril@ti.com> <27F9C60D11D683428E133F85D2BB4A53043F3C8C2A@dlee03.ent.ti.com>
Reply-To: cyril@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043F3C8C2A@dlee03.ent.ti.com>
Sender: netdev-owner@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Govindarajan, Sriramakrishnan" <srk@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Omar,

[...]
>> +	while ((reg = __raw_readl(&regs->user[0].access)) & USERACCESS_GO)
>> +		;
> 
> potential infinite loop? I saw another place in your series using time_after, might fit in here too.
[...]
>> +	while ((__raw_readl(&regs->control) & CONTROL_IDLE) == 0)
>> +		;
> 
> Ditto

Thanks.  Will modify.

Regards
Cyril.
