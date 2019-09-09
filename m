From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Letux-kernel] [RFC PATCH 0/3] Enable 1GHz support on omap36xx
Date: Mon, 9 Sep 2019 09:32:36 -0700
Message-ID: <20190909163236.GP52127@atomide.com>
References: <C04F49BA-1229-4E96-9FCF-4FC662D1DB11@goldelico.com>
 <CAHCN7x+Ye6sB_YqO0sAX1OJDw64B-qGS3pL545v3Xk5z914cwQ@mail.gmail.com>
 <0C1EF64E-B33C-4BFA-A7D3-471DD1B9EE86@goldelico.com>
 <515048DE-138D-4400-8168-F2B7D61F1005@goldelico.com>
 <CAHCN7xLPCX9rZ0+7KVBiA_bgZ6tg6VeCXqD-UXu+6iwpFMPVrA@mail.gmail.com>
 <7B3D1D77-3E8C-444F-90B9-6DF2641178B8@goldelico.com>
 <CAHCN7xLW58ggx3CpVL=HdCVHWo6D-MCTB91A_9rtSRoZQ+xJuQ@mail.gmail.com>
 <FA2920FE-B76A-4D44-A264-862A1CCBF7FC@goldelico.com>
 <CAHCN7xJsPa0i+Z+qpCkWcdAh9+udmGT0RPNchdDsfB=8ptd3Nw@mail.gmail.com>
 <87420DBD-770F-4C32-9499-A3AEA5876E8A@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87420DBD-770F-4C32-9499-A3AEA5876E8A@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Adam Ford <aford173@gmail.com>, =?utf-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andreas Kemnade <andreas@kemnade.info>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* H. Nikolaus Schaller <hns@goldelico.com> [190909 14:57]:
> Another question that came up by private mail from André was if we
> should better disable the turbo OPPs of omap34xx and 36xx by default
> (status = "disabled";) because there are concerns about overheating
> the chips and we have no thermal regulation like for omap4 & 5.
> 
> But this would mean that every board DTS would have to set it explicitly
> to "enabled".

Yes I started thinking about that too. I think there is a requirement
to do the scaling via the voltage processor for the higher modes.
And there needs to be some way to automatically change to a lower
OPP in some cases.

For normal OPPs, using the twl regulator directly should be OK.

For the higher modes, maybe we could pass the callback functions
from arch/arm/mach-omap2/voltage.c for the twl regulator so the
voltage processor hardware can handle them directly. Or add a
separate regulator driver operating the voltages like Nishanth
posted patches for earlier.

Regards,

Tony
