From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH v2] net: cpsw: fix obtaining mac address for am3517
Date: Fri, 01 Mar 2019 14:52:45 +0000
Message-ID: <yw1ximx26402.fsf@mansr.com>
References: <1477668756-2651-1-git-send-email-jhofstee@victronenergy.com>
        <20161028155213.2t3nwwe3lqaynaer@atomide.com>
        <d8ad5cab-5183-cddf-fa9a-4e7b9b8c9377@victronenergy.com>
        <20161028181914.mskebckucukzhxhz@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161028181914.mskebckucukzhxhz@atomide.com> (Tony Lindgren's
        message of "Fri, 28 Oct 2016 11:19:14 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jeroen Hofstee <jhofstee@victronenergy.com>, netdev@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "open list:TI ETHERNET SWITCH DRIVER (CPSW)" <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Jeroen Hofstee <jhofstee@victronenergy.com> [161028 11:19]:
>> Hello Tony,
>> 
>> On 28-10-16 17:52, Tony Lindgren wrote:
>> > * Jeroen Hofstee <jhofstee@victronenergy.com> [161028 08:33]:
>> > > Commit b6745f6e4e63 ("drivers: net: cpsw: davinci_emac: move reading mac
>> > > id to common file") did not only move the code for an am3517, it also
>> > > added the slave parameter, resulting in an invalid (all zero) mac address
>> > > being returned for an am3517, since it only has a single emac and the slave
>> > > parameter is pointing to the second. So simply always read the first and
>> > > valid mac-address for a ti,am3517-emac.
>> > And others davinci_emac.c users can have more than one. So is the
>> > reason the slave parameter points to the second instance because
>> > of the location in the hardware?
>> 
>> Sort of, the slave parameter gets determined by the fact if there is one
>> or two register range(s) associated with the davinci_emac. In davinci_emac.c
>> 
>>     res_ctrl = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>     ...
>>     rc = davinci_emac_try_get_mac(pdev, res_ctrl ? 0 : 1,
>>                           priv->mac_addr);
>> 
>> So it there are two ranges, the slave param becomes 0. It there is only one,
>> it
>> will be 1. Since the am3517 only has a single regs entry it ends up with
>> slave 1,
>> while there is only a single davinci_emac.
>
> OK thanks for clarifying it:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

What happened to this patch?

-- 
Måns Rullgård
