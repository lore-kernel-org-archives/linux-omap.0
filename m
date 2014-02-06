From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/3] ARM: dts: Add support for both OMAP35xx and OMAP36xx
 Overo/Tobi
Date: Thu, 6 Feb 2014 09:18:21 -0600
Message-ID: <52F3A7BD.70805@ti.com>
References: <1391677818-21154-1-git-send-email-florian.vaussard@epfl.ch>
 <1391677818-21154-4-git-send-email-florian.vaussard@epfl.ch>
 <52F39DCC.8000006@ti.com> <52F3A681.9050300@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52F3A681.9050300@epfl.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: florian.vaussard@epfl.ch, Tony Lindgren <tony@atomide.com>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <bcousson@baylibre.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Mike Turquette <mturquette@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/06/2014 09:13 AM, Florian Vaussard wrote:
[...]
>>> +#include "omap34xx.dtsi"
>>> +#include "omap3-overo-tobi-common.dtsi"
>>> +
>>> +/ {
>>> +	model = "OMAP35xx Gumstix Overo on Tobi";
>>> +	compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3";
>> To reduce any future problems, I suggest:
>> compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo",
>> "ti,omap3430", "ti,omap3";
>>
> 
> This was also my first thought, but "ti,omap3430" is not documented in
> Documentation/devicetree/bindings/arm/omap/omap.txt. It is said that
> "ti,omap3" defaults to OMAP3430. I do not know if omap35xx would be more
> accurate, as these Overo are using OMAP3503 and OMAP3530.
3430 should have been now documented with commit
89b6eef0d859bad4bcf7ad64560aa2891d6a37a0

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/arm/omap/omap.txt#n64

We have not pulled out 3730 or 3530 separately out in linux as of
today as they are nothing but a packaging difference for larger board
community - there should be no internal differences - the only
functional variation has been am3517 - which got it's own compatible
property.

-- 
Regards,
Nishanth Menon
