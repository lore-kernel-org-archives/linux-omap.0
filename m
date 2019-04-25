From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC PATCH v3 net-next 01/11] net: ethernet: ti: cpts: use
 devm_get_clk_from_child
Date: Thu, 25 Apr 2019 14:18:52 +0200
Message-ID: <20190425121852.GA8117@lunn.ch>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
 <1556144667-27997-2-git-send-email-grygorii.strashko@ti.com>
 <20190424224607.GB23779@lunn.ch>
 <3aae7697-3b7f-492b-0600-b6d1382511c3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3aae7697-3b7f-492b-0600-b6d1382511c3@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>
List-Id: linux-omap@vger.kernel.org

> > Hi Grygorii
> > 
> > Does this break backwards compatibility for existing DT blobs?
> > Maybe you need to look in both the old and new locations?
> 
> No. It doesn't - default node is cpsw->dev->of_node.

O.K. great. Maybe mention this in the commit message if there is a v2.

     Thanks
        Andrew
