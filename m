From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [PATCH v6 0/7] ARM: dts: DRA7: Add dt nodes for PWMSS
Date: Tue, 26 Apr 2016 08:22:07 -0500
Message-ID: <571F6B7F.8090008@ti.com>
References: <1461343238-29274-1-git-send-email-fcooper@ti.com>
 <alpine.DEB.2.02.1604251610170.22464@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1604251610170.22464@utopia.booyaka.com>
Sender: linux-clk-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: thierry.reding@gmail.com, tony@atomide.com, t-kristo@ti.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org



On 04/25/2016 11:18 AM, Paul Walmsley wrote:
> On Fri, 22 Apr 2016, Franklin S Cooper Jr wrote:
> 
>> This patch series adds support for PWM for DRA7. The IP is the same as the
>> one present in AM33XX and AM437XX.
>>
>> However, before doing so remove unnecessary hwmod entries for eCAP, ePWM
>> and eQEP.
> 
> Just took a quick look (nothing indepth).  Looks OK.  
> 
> Once Rob's issues have been addressed, please feel free to add an 
> Acked-by: from me.  Thanks for playing along, Franklin, I think this final 
> product makes the most sense from a device architecture point of view.


Thanks Paul. Just to be clear I can add your Acked-by to all 7 patches?
> 
> 
> - Paul
> 
