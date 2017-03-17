From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 8/9] ARM: dts: omap4: add clkctrl nodes
Date: Fri, 17 Mar 2017 23:41:24 +0200
Message-ID: <9456caee-4f45-044a-0b2e-305fa2d0d274@ti.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
 <1489741781-12816-9-git-send-email-t-kristo@ti.com>
 <20170317154333.GW20572@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170317154333.GW20572@atomide.com>
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
Cc: mturquette@baylibre.com, linux-omap@vger.kernel.org, sboyd@codeaurora.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 17/03/17 17:43, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [170317 02:12]:
>> Add clkctrl nodes for OMAP4 SoC. These are going to be acting as
>> replacement for part of the existing clock data and the existing
>> clkctrl hooks under hwmod data.
>
> It seems to be actually this patch in the series that breaks booting
> if the last patch in this series is not applied.

Yea I guess we need to squash this and patch #9, I'll double check next 
week. Sorry about not catching this one.

-Tero
