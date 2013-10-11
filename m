From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
Date: Fri, 11 Oct 2013 11:49:16 +0300
Message-ID: <5257BB8C.5080001@ti.com>
References: <20131003054104.8941.88857.stgit@localhost>
 <20131003054221.8941.87801.stgit@localhost> <5256AA7F.8030005@ti.com>
 <20131010160018.GA29913@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131010160018.GA29913@atomide.com>
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

On 10/10/2013 07:00 PM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [131010 06:32]:
>>
>> I tried testing this with the USB EHCI driver, but I'm not getting wake up interrupts
>> while the system is still running and only the EHCI controller is runtime suspended.
>>
>> It seems we need to somehow call _reconfigure_io_chain() to update the daisy chain
>> whenever the pad wakeup_enable bit is changed.
> 
> Sounds like this is on omap3? Have you tried calling pcs_soc->rearm() in the
> pcs_irq_handle() like the comments there suggest? At least for me that keeps
> the wake-up interrupts continuously running on omap3 instead of just idle modes.

Yes it is on OMAP3. I haven't tried with pcs_soc->rearm(). I will give it a try and
let you know.
> 
> Now on omap4, I've noticed the wake up interrupts are on all the time based on tests
> with the serial driver.
>  
>> I think pcs_irq_set_wake() is where need to control system wakeup behaviour for the irq.
>> This is where we should be able to change WAKEUP_EN bit of the pad
>> to enable/disable system wakeup for that pad and also call _reconfigure_io_chain().
> 
> Well the irq_set_wake() should only be needed for suspend and resume. For runtime PM
> the wake-events should be always enabled by default as pointed out by Alan Stern
> a while back.

Right, but we need to update the WAKEUP_EN bit in the pad control register for that
to work, no?. This is something we are not doing in the driver.
>  
>> This would mean that we don't really need to set WAKEUP_EN for the pads in the DTS file.
> 
> Well for runtime PM, we should also do the automatic handling if configured.
> But how to do that best is still open..

I didn't get this part. I was thinking that irq_set_wake() should map directly to WAKEUP_EN
bit for the pin.

cheers,
-roger
