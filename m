From: Thomas Weber <thomas.weber.linux@googlemail.com>
Subject: Re: [PATCHv4 2/4] OMAP3: Devkit8000: Fix tps65930 pullup/pulldown
 configuration
Date: Thu, 20 Jan 2011 07:56:55 +0100
Message-ID: <4D37DCB7.9010505@gmail.com>
References: <1295425166-25540-1-git-send-email-weber@corscience.de> <1295425166-25540-3-git-send-email-weber@corscience.de> <20110119222126.GI4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110119222126.GI4957@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org, Daniel Morsing <daniel.morsing@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, charu@ti.com, sshtylyov@mvista.com
List-Id: linux-omap@vger.kernel.org

Am 19.01.2011 23:21, schrieb Tony Lindgren:
> * Thomas Weber <weber@corscience.de> [110119 00:18]:
>> From: Daniel Morsing <daniel.morsing@gmail.com>
>>
>> gpio7 on the tps65930 is used as an output on the devkit8000 and
>> gpio1 is not connected. Remove gpio7 and change gpio1 to pulldown
>>
>> Signed-off-by: Daniel Morsing <daniel.morsing@gmail.com>
> 
> I'll queue only this fix for now, looks like the other still need
> minor changes.
> 
> Tony
> --

Thanks.
