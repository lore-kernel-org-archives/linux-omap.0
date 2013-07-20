From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [net-next PATCH 1/1] drivers: net: cpsw: add support to show
 hw stats via ethtool get_regs
Date: Sat, 20 Jul 2013 13:30:07 +0530
Message-ID: <51EA4387.9070301@ti.com>
References: <1374242841-17141-1-git-send-email-mugunthanvnm@ti.com> <20130719.173202.1362261343675979678.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20130719.173202.1362261343675979678.davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 7/20/2013 6:02 AM, David Miller wrote:
> From: Mugunthan V N <mugunthanvnm@ti.com>
> Date: Fri, 19 Jul 2013 19:37:21 +0530
>
>> Add support to show CPSW hardware statistics to user via ethtool get_regs
>> ops so user can find if there were any error reported or the system is
>> over loaded duing hagh data rate transfer.
>>
>> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> This is not the correct way to provide this functionality.  ->get_regs()
> is for dumping the raw hardware registers to userspace for low level
> debugging purposes, not for providing HW specific statistics.
>
> The correct thing to do is provide an appropriate implementation of
> the ->get_strings() and ->get_ethtool_stats() methods.
Will change the implementation and resubmit the patch.

Regards
Mugunthan V N
