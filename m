From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw-phy-sel: check
 bus_find_device() ret value
Date: Wed, 16 May 2018 02:07:01 +0300
Message-ID: <CAHp75VdXjiis9R6a1EZO9q3fawB_nSmJhqRSvv_7yggTr-EBOA@mail.gmail.com>
References: <20180515230149.6547-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180515230149.6547-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, May 16, 2018 at 2:01 AM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> This fixes klockworks warnings: Pointer 'dev' returned from call to
> function 'bus_find_device' at line 179 may be NULL and will be dereferenced
> at line 181.

> +               dev_err(dev, "unable to find platform device for %s\n",
> +                       of_node_full_name(node));

Sorry, isn't %pOF works for this?

-- 
With Best Regards,
Andy Shevchenko
