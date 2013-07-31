From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] of: provide of_platform_unpopulate()
Date: Wed, 31 Jul 2013 11:28:24 -0500
Message-ID: <51F93B28.3030001@gmail.com>
References: <1374257691-31981-1-git-send-email-bigeasy@linutronix.de>  <51EBF33A.4050207@gmail.com> <51EC4908.4040504@gmail.com>  <CACxGe6sqv2Wsp26MWqqs9W_eWO3tjs-+2z3z8fC=2fe-BjJvkA@mail.gmail.com> <1375090382.3859.38.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375090382.3859.38.camel@pasglop>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Grant Likely <grant.likely@linaro.org>, George Cherian <george.cherian@ti.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, Felipe Balbi <balbi@ti.com>, Roger Quadros <rogerq@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Vivek Gautam <gautam.vivek@samsung.com>
List-Id: linux-omap@vger.kernel.org

On 07/29/2013 04:33 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2013-07-22 at 00:44 +0100, Grant Likely wrote:
>>> BTW, it looks like Grant has attempted this already:
>>
>> Yup, things broke badly. Unfortunately the of_platform_device and
>> platform_device history doesn't treat resources in the same way. I
>> would like to merge the code, but I haven't been able to figure out a
>> clean way to do it. Looks like we do need the unpopulate function.
> 
> What is the exact problem Grant ? Care to give me an example ?
> 

See this thread:

http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg63678.html

Rob
