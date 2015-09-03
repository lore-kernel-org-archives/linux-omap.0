From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 8/9] usb: dwc3: core: Prevent otg events from disabling
 themselves
Date: Thu, 3 Sep 2015 16:54:47 +0300
Message-ID: <55E85127.9020704@ti.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
 <1441203864-15786-9-git-send-email-rogerq@ti.com>
 <20150902144705.GI8299@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150902144705.GI8299@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 02/09/15 17:47, Felipe Balbi wrote:
> On Wed, Sep 02, 2015 at 05:24:23PM +0300, Roger Quadros wrote:
>> There is a race happening during dwc3_drd_init() that causes
>> otg events to get disabled. This is what happens.
>>
>> dwc3_otg_irq() happens immediately when PRTCAP is set to OTG,
>> even though OEVTEN is 0. This is because BIT 31 IRQ of
>> OEVT can't be disabled by OEVTEN.
>> We configure OEVTEN in dwc3_otg_init() but dwc3_otg_irq() has
>> already saved OEVTEN as 0 into dwc->oevten. So finally when
>> dwc3_irq_thread_irq() is called we save 0 into OEVTEN
>> thus disabling OTG irqs forever.
>>
>> We fix this by disabling IRQs when configuring OEVTEN in
>> dwc3_otg_init().
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> can't you just merge this patch into the one which introduced the bug to
> start with ?

Yes, I'll do that.

> 
>> ---
>>  drivers/usb/dwc3/core.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 684010c..654aebf 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -921,6 +921,7 @@ static int dwc3_drd_init(struct dwc3 *dwc)
>>  	int ret, id, vbus;
>>  	struct usb_otg_caps *otgcaps = &dwc->otg_config.otg_caps;
>>  	u32 reg;
>> +	unsigned long flags;
>>  
>>  	otgcaps->otg_rev = 0;
>>  	otgcaps->hnp_support = false;
>> @@ -993,6 +994,8 @@ try_otg_core:
>>  		goto error;
>>  	}
>>  
>> +	spin_lock_irqsave(&dwc->lock, flags);
>> +
>>  	/* we need to set OTG to get events from OTG core */
>>  	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
>>  	/* GUSB2PHYCFG0.SusPHY=0 */
>> @@ -1018,6 +1021,8 @@ try_otg_core:
>>  	/* OCTL.PeriMode = 1 */
>>  	dwc3_writel(dwc->regs, DWC3_OCTL, DWC3_OCTL_PERIMODE);
>>  
>> +	spin_unlock_irqrestore(&dwc->lock, flags);
>> +
>>  	dwc3_otg_fsm_sync(dwc);
>>  	usb_otg_sync_inputs(dwc->fsm);
>>  
>> -- 
>> 2.1.4
>>
> 
- --
cheers,
- -roger
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV6FEnAAoJENJaa9O+djCTSjgQALL73OtdfKAWte2JFxsw1PVT
Xeh+ec7FJqNCKb2TwTSgnnWp6BxapbAlkK3kSwhsbgZvZLGtf3IC+xPHWNCs4dZs
uCs9oDPC/oAiYBnN3gYZxBFuhe1fsFEuS7aFIzrvKD/+tnXmd0IQ5Yu3k06VDXIM
jf/034Wep9AK44fyPy0sLKET1J6/UMvjxvUpEyxj9elbvs+GqzD9qR/GF6Ob8q6d
5f7y4ajMBCgyoC/wpIXDIJi7yqH1MUZq8bdC+7BKyc8Fz7kzVSpU2SL0BSRMU7Jn
Mzyx25WbWy1mXkfdgOjXtxx6MH5gV6jIIvqobyXXrK/e0z3kU6OeFprbubsOAvmC
fcgRkOrfr1O7/G5Gm7mhU5kLSZF6kvf6MoDPGCd/TbP4OgfYcPiTj5O020qDbRxZ
Hfuy/5Xk1oxR2aui1q9ycCWrpSA4L+B4fSpDXUznZw755BhhPnVeoYlXUfcb2sI+
YPNs6cLeX95I27AoMpK0wjMptmswaKcDmwv50mjK0kXgUcnVGs6z7YxSIJ2eAxPV
OpYLwVTfJiqoeJMscHvqoipwjlHqq4xS780SbzgZTDFOk2Ik7l0B6mNoL9CgaaXa
LVCBEywdWo+9os4b3JRrjDSqqdOMhBVaO0GvtiZZqfF7mOTmJHF/yFAODBw/CLXi
jAmBC/nM3M32CJphQQ1J
=z7cJ
-----END PGP SIGNATURE-----
