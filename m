From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
Date: Fri, 11 Oct 2013 11:45:39 +0300
Message-ID: <5257BAB3.50100@ti.com>
References: <20131003054104.8941.88857.stgit@localhost>
 <20131003054221.8941.87801.stgit@localhost> <5256AA7F.8030005@ti.com>
 <20131010160018.GA29913@atomide.com> <20131010162314.GD29913@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131010162314.GD29913@atomide.com>
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
Cc: devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Prakash Manjunathappa <prakash.pm@ti.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 10/10/2013 07:23 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [131010 09:09]:
>> * Roger Quadros <rogerq@ti.com> [131010 06:32]:
>>>
>>> I tried testing this with the USB EHCI driver, but I'm not getting wake up interrupts
>>> while the system is still running and only the EHCI controller is runtime suspended.
>>>
>>> It seems we need to somehow call _reconfigure_io_chain() to update the daisy chain
>>> whenever the pad wakeup_enable bit is changed.
>>
>> Sounds like this is on omap3? Have you tried calling pcs_soc->rearm() in the
>> pcs_irq_handle() like the comments there suggest? At least for me that keeps
>> the wake-up interrupts continuously running on omap3 instead of just idle modes.
>>
>> Now on omap4, I've noticed the wake up interrupts are on all the time based on tests
>> with the serial driver.
> 
> Oh, and if you're runtime suspending EHCI only, and if the EHCI module has
> wake-up registers, it should be able to wake EHCI from retention on it's own
> without a need for the io chain at all.
> 

The problem is that the asynchronous wake up mechanism for USB Host module is broken
in the design so we have to rely on IO daisy chain every time. :(

cheers,
-roger
