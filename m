From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: dts: dra72-evm: Add i2c1 and tps65917 nodes
Date: Mon, 8 Sep 2014 16:12:01 -0700
Message-ID: <20140908231200.GR3238@atomide.com>
References: <1406528334-4415-1-git-send-email-j-keerthy@ti.com>
 <53D5EE21.1040000@ti.com>
 <53D61643.4070005@ti.com>
 <53EA0A26.1050301@ti.com>
 <20140908200443.GA24258@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140908200443.GA24258@kahuna>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Keerthy <a0393675@ti.com>, Keerthy <j-keerthy@ti.com>, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, galak@codeaurora.org, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [140908 13:05]:
> On 18:05-20140812, Keerthy wrote:
> > On Monday 28 July 2014 02:52 PM, Keerthy wrote:
> > >On Monday 28 July 2014 12:00 PM, Lokesh Vutla wrote:
> > >>On Monday 28 July 2014 11:48 AM, Keerthy wrote:
> > >>>The patch series adds i2c1 and tps65917 and related nodes.
> > >>>The patch series is boot tested on DRA72-EVM.
> > >>>
> > >>>Thanks to Lokesh <lokeshvutla@ti.com> for testing the series.
> > >
> > >Correcting the 'to' list.
> > 
> > Hi Tony,
> > 
> > If there are no comments could you please pull these two patches?
> 
> With 3.17-rc4, I tested this series:
> dra72-evm-before: http://paste.ubuntu.org.cn/1496342
> dra72-evm-after: http://paste.ubuntu.org.cn/1496341
> 
> Patches:
> https://patchwork.kernel.org/patch/4632391/
> https://patchwork.kernel.org/patch/4632421/
> 
> Could we pick these with 3.18?
> 
> Please free to add:
> 
> Tested-by: Nishanth Menon <nm@ti.com>

OK applying into omap-for-v3.18/dt thanks.

Regards,

Tony
