From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [11/12] ARM: OMAP2+: add missing of_node_put after
 of_device_is_available
Date: Sun, 14 Apr 2019 18:38:25 +0200
Message-ID: <903ec107-46ed-f19f-56a7-c20031247503@web.de>
References: <1550928043-14889-12-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550928043-14889-12-git-send-email-Julia.Lawall@lip6.fr>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

> @@ -250,8 +250,10 @@ static int __init omapdss_init_of(void)
>  	if (!node)
>  		return 0;
>
> -	if (!of_device_is_available(node))
> +	if (!of_device_is_available(node)) {
> +		of_node_put(node);
>  		return 0;
> +	}
>
>  	pdev =3D of_find_device_by_node(node);

Is there a need to put the node also in subsequent if branches
for complete exception handling in this function implementation?

Regards,
Markus
