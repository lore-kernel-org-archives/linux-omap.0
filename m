From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 02/10] clk: ti: Add few dm814x clock aliases
Date: Wed, 9 Dec 2015 09:51:19 +0200
Message-ID: <5667DD77.2000900@ti.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
 <1449013103-23238-3-git-send-email-tony@atomide.com>
 <20151208165732.GY23396@atomide.com> <56672ED0.4050405@ti.com>
 <20151208201136.GZ23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151208201136.GZ23396@atomide.com>
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
Cc: Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Delio Brignoli <dbrignoli@audioscience.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Philipp Rosenberger <ilu@linutronix.de>, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 12/08/2015 10:11 PM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [151208 11:25]:
>> On 12/08/2015 06:57 PM, Tony Lindgren wrote:
>>>
>>> Anybody from the clock department care to ack this one?
>>
>> Sorry been rather busy lately...
>>
>>> I'd like to
>>> get this series into Linux next as it fixes some some issues.
>>
>> Yeah looks good to me, don't have access to dm814x so can't test.
>>
>> Acked-by: Tero Kristo <t-kristo@ti.com>
>
> Thanks.
>
>> Are you planning to push this via omap tree if this is critical for you?
>
> Yes this series needs to be merged in certain order to keep t410
> booting. Should not conflict with anything else AFAIK.

Ok at least I am fine with that. The dm81xx clock alias file is pretty 
independent of anything else.

-Tero
