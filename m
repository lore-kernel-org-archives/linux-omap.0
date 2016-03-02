From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [PATCH v3 2/5] ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS
Date: Wed, 2 Mar 2016 10:22:09 -0600
Message-ID: <56D71331.5020702@ti.com>
References: <1456439796-28546-1-git-send-email-fcooper@ti.com>
 <1456439796-28546-3-git-send-email-fcooper@ti.com>
 <20160301181109.GB13417@atomide.com>
 <alpine.DEB.2.02.1603011858510.14948@utopia.booyaka.com>
 <20160301205043.GA4469@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160301205043.GA4469@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: t-kristo@ti.com, vigneshr@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Paul

On 03/01/2016 02:50 PM, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [160301 10:59]:
>> On Tue, 1 Mar 2016, Tony Lindgren wrote:
>>
>>> * Franklin S Cooper Jr <fcooper@ti.com> [160225 14:37]:
>>>> From: Vignesh R <vigneshr@ti.com>
>>>>
>>>> Add hwmod entries for the PWMSS on DRA7.
>>>>
>>>> Set l4_root_clk_div as the main_clk of PWMSS. It is fixed-factored clock
>>>> equal to L4PER2_L3_GICLK/2(l3_iclk_div/2).
>>>> As per AM57x TRM SPRUHZ6[1], October 2014, Section 29.1.3 Table 29-4,
>>>> clock source to PWMSS is L4PER2_L3_GICLK. But it is actually
>>>> L4PER2_L3_GICLK/2. The TRM does not show the division by 2.
>>>>
>>>> [1] www.ti.com/lit/ug/spruhz6/spruhz6.pdf
>>> Looks OK to me, assuming Paul will pick this one or ack it.
>> Well I've already sent comments on it, it doesn't look quite ready for me 
>> yet.  I would hold off on the whole series because the hwmod comments also 
>> impact the DT files.
> OK will drop the dt related patches then.

Sorry you previously asked this question about why hwmod is
used for eCap, ePWM and eQEP before and it wasn't addressed.
I'll take a look at this and I will get back to you.

>
> Regards,
>
> Tony

