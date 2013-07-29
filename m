From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/9] ARM: dts: omap5-uevm: fixup wrong regulator
 configuration
Date: Mon, 29 Jul 2013 08:17:25 -0500
Message-ID: <51F66B65.4030702@ti.com>
References: <1374079538-19548-1-git-send-email-nm@ti.com>
 <51F63C74.6070503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F63C74.6070503@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <benoit.cousson@linaro.org>, Tony Lindgren <tony@atomide.com>, benoit.cousson@gmail.com
Cc: J Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/29/2013 04:57 AM, Keerthy wrote:
> Hi Nishanth,
>
> On Wednesday 17 July 2013 10:15 PM, Nishanth Menon wrote:
>> Due to wrong older revision of documentation used as reference, we
>> seem to have a bunch of LDOs wrongly configured on OMAP5 uEVM. This
>> series is based power tree on production board 750-2628-XXX platform.
>> Unfortunately, the wrong voltages may be detrimental to OMAP5 as they
>> supply hardware blocks at voltages that are out of specification.
>
> This series looks good to me.
>
> Acked-by:  J Keerthy <j-keerthy@ti.com>

Tony, Benoit - this series could prevent OMAP5 from being damaged on 
uEVMs with current 3.11 rc - could you suggest what we need to do to get 
it in?


-- 
Regards,
Nishanth Menon
