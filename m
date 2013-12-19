From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv11 07/49] clk: divider: add support for low level ops
Date: Thu, 19 Dec 2013 21:02:42 +0200
Message-ID: <52B342D2.1010301@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
 <1387452260-23276-8-git-send-email-t-kristo@ti.com>
 <20131219182620.GQ27438@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131219182620.GQ27438@atomide.com>
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
Cc: nm@ti.com, devicetree@vger.kernel.org, paul@pwsan.com, mturquette@linaro.org, rnayak@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 12/19/2013 08:26 PM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [131219 03:26]:
>> Divider clock can now be registered to use low level register access ops.
>> Preferred initialization method is via clock description.
>
> This seems to make omap2 not boot for me. No output whatsoever even with
> DEBUG_LL and earlyprintk.

Thats weird... I was kind of afraid something like this might happen 
though as these patches touch the clock low level routines globally, but 
I can't see what could be broken...

-Tero
