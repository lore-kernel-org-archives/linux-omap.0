From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [net-next PATCH v4 1/5] net: cpsw: enhance pinctrl support
Date: Mon, 10 Jun 2013 17:48:16 +0200
Message-ID: <CACRpkdbKWRyBxUF1w82C8WUAvXM5hsUc6N-C+CcwXr8eCyviWQ@mail.gmail.com>
References: <51B0254B.4090304@ti.com>
	<20130606085049.GL31367@sirena.org.uk>
	<CACRpkdYxsXZBo1p6EefbE7n6XxYZCGokz-yCq03TTbGavaKEvg@mail.gmail.com>
	<20130607.004234.2007576325541054686.davem@davemloft.net>
	<51B1F2EB.80109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <51B1F2EB.80109@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: David Miller <davem@davemloft.net>, Mark Brown <broonie@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Hebbar Gururaja <gururaja.hebbar@ti.com>, Benoit Cousson <benoit.cousson@linaro.org>, Linux-OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 7, 2013 at 4:49 PM, Mugunthan V N <mugunthanvnm@ti.com> wrote:

>> If you want to merge the direct networking parts of this series into
>> another tree, I'm fine with that:
>>
>> Acked-by: David S. Miller <davem@davemloft.net>
>
> David
>
> Can you the below patch series as i have adopted pinctrl PM api in another
> series,
> this patch has direct usage of pinctrl_select_state apis
> http://marc.info/?l=linux-netdev&m=137054250018667&w=2
>
> Linus Walleij
>
> Please drop this patch series and take my other [atch set mentioned above
> with David's Ack.

Sure I didn't see David ACK the new versions explicitly but
since they're even less intrusive I'll apply them assuming
his ACK on these versions too...

Yours,
Linus Walleij
