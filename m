From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [RFC PATCH net-next 2/4] net: 8021q: vlan_core: allow use list of vlans for real device
Date: Fri, 19 Oct 2018 13:22:20 +0200
Message-ID: <878t2up4er.fsf@miraculix.mork.no>
References: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
        <20181016182035.18234-3-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016182035.18234-3-ivan.khoronzhuk@linaro.org> (Ivan
        Khoronzhuk's message of "Tue, 16 Oct 2018 21:20:33 +0300")
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: grygorii.strashko@ti.com, davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com
List-Id: linux-omap@vger.kernel.org

Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org> writes:

> @@ -236,6 +239,13 @@ __vlan_find_dev_deep_rcu(struct net_device *real_dev,
>  	return NULL;
>  }
>=20=20
> +static inline int
> +vlan_for_each(struct net_device *dev,
> +	      int (*action)(struct net_device *dev, int vid, void *arg),
> +	      void *arg)
> +{
> +}
> +


This stub should return 0, shouldn't it?


Bj=C3=B8rn
