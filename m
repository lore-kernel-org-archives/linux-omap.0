From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH] RFC: interrupt consistency check for OF GPIO IRQs
Date: Sat, 03 Aug 2013 09:23:39 +0200
Message-ID: <51FCAFFB.4000005@ahsoftware.de>
References: <1375101368-17645-1-git-send-email-linus.walleij@linaro.org>
 <CACxGe6uNJNMdZ1HYGgCtLM2t2TWGCR6btjOHVmP=vDXXvvFfRg@mail.gmail.com>
 <CACRpkdYjJL6FZwEbB7XLnb9QtjB=3LeE9Ny6KQ4PkM3zpdNqqg@mail.gmail.com>
 <51F8CC35.1070704@collabora.co.uk> <51FB8292.9090000@ahsoftware.de>
 <51FBD1CA.1000202@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51FBD1CA.1000202@ahsoftware.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Balaji T K <balajitk@ti.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Grant Likely <grant.likely@linaro.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Jon Hunter <jgchunter@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Am 02.08.2013 17:35, schrieb Alexander Holler:
> Am 02.08.2013 11:57, schrieb Alexander Holler:
> 
>> There must have been a bug in the patch too. I've also added that
>> iinterrupt-parent stuff (with the same flags as used by the driver) and
>> just have let the driver call
>>
>> request_threaded_irq(gpio_to_irq(gpio), flags);
>>
>> without the gpio_request()/input() before. And request_threaded_irq()

Thinking again about what I've tried, I might have make the failure to
add the interrupt-parent line to the mmc-section (where the gpio was
specified) and not to the gpio(-controller) section where it might have
belong too (again, there was no example and no documentation).

But why I again bother you all with another mail, is that I don't like
the fact that the irq-flags might have to be specified in the DT and the
source (and they have to match).

A solution might be to use the flags specified in the DT for the
particular irq and ignore the flags specified as parameter to
request_irq(). At least as long as DT isn't mandatory. And in the
future, the flags could just be removed from the call to request_irq()
depending (then visible too) only on the flags as specified in the DT.

Regards,

Alexander Holler
