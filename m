From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v5 net-next 04/12] net: ethernet: ti: cpsw: move set of
 common functions in cpsw_priv
Date: Fri, 1 Nov 2019 18:55:56 +0200
Message-ID: <57f4ad69-b865-85c9-3342-e44bdc267ace@ti.com>
References: <20191024100914.16840-1-grygorii.strashko@ti.com>
 <20191024100914.16840-5-grygorii.strashko@ti.com>
 <20191025130109.GB10212@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191025130109.GB10212@lunn.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 25/10/2019 16:01, Andrew Lunn wrote:
> On Thu, Oct 24, 2019 at 01:09:06PM +0300, Grygorii Strashko wrote:
>> As a preparatory patch to add support for a switchdev based cpsw driver,
>> move common functions to cpsw-priv.c so that they can be used across both
>> drivers.
> 
> Hi Grygorii
> 
> Bike shedding, but it seems odd to move common code into a private
> file. How common is the current code in cpsw-common.c?

cpsw-common.c is used between cpsw and davinci_emac.c and, as of now, contains
only code to retrieve MAC addr from eFuse regs.
cpsw_priv.x were added intentionally as code moved to these files only used
by ald and new CPSW drivers. This also allows to avoid build/link issues.

-- 
Best regards,
grygorii
