From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] sysfs: symlink: export sysfs_create_link_nowarn()
Date: Thu, 15 Mar 2018 11:38:33 +0300
Message-ID: <45cb657e-78c9-6a22-337c-c68306215e00@cogentembedded.com>
References: <20180314222624.12744-1-grygorii.strashko@ti.com>
 <20180314222624.12744-2-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314222624.12744-2-grygorii.strashko@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello!

On 3/15/2018 1:26 AM, Grygorii Strashko wrote:

> The sysfs_create_link_nowarn() is going to be used in phylib framework in
> suseuent patch which can be built as module. Hence, export

    Subsequent.

> sysfs_create_link_nowarn() to avoid build errors.
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Fixes: a3995460491d ("net: phy: Relax error checking on sysfs_create_link()")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
[...]

MBR, Sergei
