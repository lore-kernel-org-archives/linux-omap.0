From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v5 00/11] ARM: OMAP2+: AM43x PRCM basic support
Date: Thu, 10 Oct 2013 10:55:38 +0530
Message-ID: <52563A52.7020209@ti.com>
References: <cover.1380608719.git.afzal@ti.com> <524E6346.2080208@ti.com>
 <20131008181535.GF8313@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131008181535.GF8313@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Afzal Mohammed <afzal@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 08 October 2013 11:45 PM, Tony Lindgren wrote:
> * Rajendra Nayak <rnayak@ti.com> [131003 23:50]:
>> On Tuesday 01 October 2013 12:34 PM, Afzal Mohammed wrote:
>>> Hi Paul, Benoit, Tony,
>>>
>>> This series adds PRCM support (except clock tree) for AM43x SoC's.
>>> Please consider this for inclusion in the coming merge window.
>>>
>>> Patch 02/11 "ARM: OMAP2+: hwmod: AM335x/AM43x: move common data" may
>>> not reach mailing lists due to bigger size, this series is also present
>>> @git://gitorious.org/x0148406-public/linux-kernel.git tags/am43x-prcm-v5
>>>
>>> Compared to v4, only change is in fixing the powerdomain data.
>>>
>>> Major changes compared to rfc v3:
>>> 1. All register offsets properly taken care for AM43x (with rfc v3, a
>>>    couple of issues was detected while testing on pre-silicon)
>>> 2. There were two patches for common hwmod data movement (one for
>>>    interconnect and other for ip block data), both were combined to have
>>>    a cleaner series that is bisectable.
>>> 3. Cleaner seperation of common data
>>>
>>> Major changes compared to v2 (v3 was only an rfc for current approach):
>>> 1. omap_hwmod_33xx_43xx_interconnect_data.c has the common interconnect
>>>    ocp's structs shared between AM335x and AM43x
>>> 2. omap_hwmod_33xx_43xx_ipblock_data.c has the common hwmod structs
>>>    shared between AM335x and AM43x
>>
>> This split and reuse looks much better and readable now.
>>
>> For the complete series,
>> Acked-by: Rajendra Nayak <rnayak@ti.com>
> 
> Looks good to me too. I'm assuming that Paul will queue this.
> 
> And let's everybody make note that this will be the _last_ set of
> hwmod data we'll _ever_ merge as this all should be replaced with
> device tree + bus driver based approach for future SoCs.
> 
> But let's get the common clock framework conversion done first, so
> this can wait until after that.

Tony, I hope you meant the 'hwmod replaced with device tree + bus driver
based approach' is what can wait until after the common clock framework DT
conversion and not the $subject series itself :)

regards,
Rajendra

> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
