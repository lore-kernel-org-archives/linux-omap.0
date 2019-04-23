From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 01/19] net: ethernet: ti: convert to SPDX
 license identifiers
Date: Tue, 23 Apr 2019 15:58:25 +0200
Message-ID: <20190423135825.GE3371@lunn.ch>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556024950-20752-2-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 23, 2019 at 04:08:52PM +0300, Grygorii Strashko wrote:
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2006, 2007 Eugene Konev
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.

Hi Grygorii

Your SPDX says version 2. The text says version 2 or later. You need
to add a + .

     Andrew
