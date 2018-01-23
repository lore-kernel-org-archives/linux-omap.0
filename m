From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [3/3] mfd/omap-usb-tll: Return an error code only as a constant
 in usbtll_omap_probe()
Date: Tue, 23 Jan 2018 15:43:09 +0100
Message-ID: <a3048e12-86d8-6c68-5021-35b7f6474264@users.sourceforge.net>
References: <c048a681-70e4-ecdd-e0f8-48c8f1bb0ac4@users.sourceforge.net>
 <367e77d8-3a65-2c12-5e79-75a626b65f41@users.sourceforge.net>
 <20180122155057.7eiu53l6xjls6uga@dell> <20180123130440.lgfoeq4rzsa2e4gk@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123130440.lgfoeq4rzsa2e4gk@dell>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ladislav Michl <ladis@linux-mips.org>
List-Id: linux-omap@vger.kernel.org

>> Applied, thanks.
> 
> This patch does not apply.
> 
> Please rebase and resend.

Did you notice that this update suggestion could eventually be superseded
by the software change “[PATCH v2] mfd: omap-usb-tll: Allocate driver data at once”?

https://lkml.org/lkml/2018/1/23/277
https://patchwork.kernel.org/patch/10165339/
https://lkml.kernel.org/r/<20180115202505.GA2628@lenoch>

Regards,
Markus
