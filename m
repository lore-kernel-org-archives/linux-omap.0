From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v6 net-next 02/13] net: ethernet: ti: cpsw: allow
 untagged traffic on host port
Date: Mon, 11 Nov 2019 14:38:30 -0800 (PST)
Message-ID: <20191111.143830.839461521636004353.davem@davemloft.net>
References: <20191109151525.18651-1-grygorii.strashko@ti.com>
        <20191109151525.18651-3-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191109151525.18651-3-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: f.fainelli@gmail.com, netdev@vger.kernel.org, ilias.apalodimas@linaro.org, andrew@lunn.ch, ivan.khoronzhuk@linaro.org, jiri@resnulli.us, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, m-karicheri2@ti.com, ivecera@redhat.com, robh+dt@kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Sat, 9 Nov 2019 17:15:14 +0200

> +	ale->p0_untag_vid_mask =
> +		devm_kmalloc_array(params->dev, BITS_TO_LONGS(VLAN_N_VID),
> +				   sizeof(unsigned long),
> +				   GFP_KERNEL);
> +

devm_kmalloc_array() can fail and you must check the return value and
cleanup with -ENOMEM if necessary.
