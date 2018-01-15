From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH 1/3] mfd/omap-usb-tll: Delete two error messages for a
 failed memory allocation in usbtll_omap_probe()
Date: Mon, 15 Jan 2018 16:38:43 +0100
Message-ID: <1ebb5ac5-aa4d-7c19-94db-210b518d562f@users.sourceforge.net>
References: <c048a681-70e4-ecdd-e0f8-48c8f1bb0ac4@users.sourceforge.net>
 <7719b4e7-1081-6fa4-6f14-f45cf062482d@users.sourceforge.net>
 <20180115134101.GA6711@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180115134101.GA6711@lenoch>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

>> @@ -258,7 +256,6 @@ static int usbtll_omap_probe(struct platform_device *pdev)
>>  						GFP_KERNEL);
>>  	if (!tll->ch_clk) {
>>  		ret = -ENOMEM;
>> -		dev_err(dev, "Couldn't allocate memory for channel clocks\n");
> 
> I'd either leave this one, just to know which allocation failed or better use
> something like this …

Are you aware on the structure for a Linux allocation failure report?

Regards,
Markus
