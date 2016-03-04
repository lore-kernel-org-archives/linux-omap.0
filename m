From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [PATCH v3 2/5] ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS
Date: Thu, 3 Mar 2016 20:07:48 -0600
Message-ID: <56D8EDF4.9070904@ti.com>
References: <1456439796-28546-1-git-send-email-fcooper@ti.com>
 <1456439796-28546-3-git-send-email-fcooper@ti.com>
 <20160301181109.GB13417@atomide.com>
 <alpine.DEB.2.02.1603011858510.14948@utopia.booyaka.com>
 <20160301205043.GA4469@atomide.com> <56D71331.5020702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56D71331.5020702@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: t-kristo@ti.com, vigneshr@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On 03/02/2016 10:22 AM, Franklin S Cooper Jr. wrote:
> Hi Paul
>
> On 03/01/2016 02:50 PM, Tony Lindgren wrote:
>> * Paul Walmsley <paul@pwsan.com> [160301 10:59]:
>>> On Tue, 1 Mar 2016, Tony Lindgren wrote:
>>>
>>>> * Franklin S Cooper Jr <fcooper@ti.com> [160225 14:37]:
>>>>> From: Vignesh R <vigneshr@ti.com>
>>>>>
>>>>> Add hwmod entries for the PWMSS on DRA7.
>>>>>
>>>>> Set l4_root_clk_div as the main_clk of PWMSS. It is fixed-factored clock
>>>>> equal to L4PER2_L3_GICLK/2(l3_iclk_div/2).
>>>>> As per AM57x TRM SPRUHZ6[1], October 2014, Section 29.1.3 Table 29-4,
>>>>> clock source to PWMSS is L4PER2_L3_GICLK. But it is actually
>>>>> L4PER2_L3_GICLK/2. The TRM does not show the division by 2.
>>>>>
>>>>> [1] www.ti.com/lit/ug/spruhz6/spruhz6.pdf
>>>> Looks OK to me, assuming Paul will pick this one or ack it.
>>> Well I've already sent comments on it, it doesn't look quite ready for me 
>>> yet.  I would hold off on the whole series because the hwmod comments also 
>>> impact the DT files.
>> OK will drop the dt related patches then.
> Sorry you previously asked this question about why hwmod is
> used for eCap, ePWM and eQEP before and it wasn't addressed.
> I'll take a look at this and I will get back to you.

So I looked into this more and verified that the eCAP and
ePWM doesn't have their own unique clock. The PWMSS receives
a clock L4PER2_L3_GICLK/2 which is passed through to its
sub-devices (ePWM, eCAP and eQEP). The PWMSS is responsible
for handling its clock internally while the subdevices have
no role in managing this clock. So this explains why we have
hwmod entries for PWMSS and why we are planning on removing
it from the various subdevices.

Since ePWM, eCAP and eQEP are subdevices of PWMSS they
shouldn't have their own concept of their "own" clock. The
ePWM , eCAP and eQEP clocks are all shared and managed by
their parent PWMSS. Once the PWMSS is enabled and has its
clock running then ePWM, eCAP and eQEP from their main clock
perspective have everything they need.

So my plan is to strip all references of clocks (including
hwmod entries) for ePWM, eCAP and eQEP. The devm_clk_get
calls made in the ePWM and eCAP will simply point to their
parent's dev (PWMSS). I did a couple of quick test using
this approach and it works. I have more testing to do but if
that checks out are you ok with the above approach?

Also I'm not sure how simple-bus fits in this picture. The
eCAP, eQEP and ePWM are all separate devices. The only thing
that they share is a single clock from their parent. So it
doesn't seem like the right approach. I'm basing this on the
info in this thread
https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg27979.html
that talks about the usage of simple-bus. So if its outdated
or I"m misinterpreting it incorrectly please let me know.
>
>> Regards,
>>
>> Tony
