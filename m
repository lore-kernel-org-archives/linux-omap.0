From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH v3 5/7] net: cpsw: Add am33xx MACID readout
Date: Tue, 19 Aug 2014 22:07:06 +0530
Message-ID: <53F37D32.3080301@ti.com>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
 <1408202315-20006-6-git-send-email-mpa@pengutronix.de>
 <53F244DA.3070803@ti.com> <20140818154112.6601cbff@gandalf.local.home>
 <53F25AD1.8040504@ti.com>
 <CABxcv=npv6bRq=VF8RT5trNxUzDj3bAm-PkvDEhcLVJ+uf8hCg@mail.gmail.com>
 <20140819085002.GE12930@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140819085002.GE12930@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markus Pargmann <mpa@pengutronix.de>, Javier Martinez Canillas <javier@dowhile0.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, kernel@pengutronix.de, Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, Steven Rostedt <rostedt@goodmis.org>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <bcousson@baylibre.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 19 August 2014 02:20 PM, Markus Pargmann wrote:
> Hi,
>
> On Tue, Aug 19, 2014 at 12:50:59AM +0200, Javier Martinez Canillas wrote:
>> Hello Mugunthan,
>>
>> On Mon, Aug 18, 2014 at 9:58 PM, Mugunthan V N <mugunthanvnm@ti.com> wrote:
>>>> Thus, for this patchset, as is:
>>>>
>>>> Tested-by: Steven Rostedt <rostedt@goodmis.org>
>>> This will fail for DRA7xx not in AM33xx
>>>
>> cpsw_am33xx_cm_get_macid() checks for
>> of_machine_is_compatible("ti,am33xx") and returns 0 if the machine is
>> not an am33xx. cpsw_probe_dt() only propagates the return value if is
>> not 0 so this patch does not change the semantics for other SoCs
>> besides am33xx.
> Yes, this patch is only about the am33xx. I don't have the DRA7xx
> hardware so I am not able to test on that hardware. Mugunthan, perhaps
> you can supply some followup patches for DRA7xx.
>
>

I will check on this thursday and update.

Regards
Mugunthan V N
