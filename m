From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
Date: Wed, 6 Feb 2019 17:04:29 +0200
Message-ID: <5C5AF77D.8020007@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <20190204163312.GI5720@atomide.com> <5C5959DB.2090608@ti.com>
 <f1b689cc-5d1b-0333-7a1c-cb6d58169e12@ti.com> <5C59AEA3.1080400@ti.com>
 <124e9f09-fb60-071d-e2ba-ec6f7fb3955c@ti.com>
 <20190205161945.GS5720@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205161945.GS5720@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Murali Karicheri <m-karicheri2@ti.com>
Cc: s-anna@ti.com, ohad@wizery.com, bjorn.andersson@linaro.org, david@lechnology.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 05/02/19 18:19, Tony Lindgren wrote:
> * Murali Karicheri <m-karicheri2@ti.com> [190205 16:13]:
>> On 02/05/2019 10:41 AM, Roger Quadros wrote:
>>> What I'm suggesting here is that kernel remoteproc driver should have nothing to do
>>> with the other PRU's data RAM.
>>>
>>> The application driver if needs both PRUs then it can obviously access both DRAMs
>>> as it has a phandle to both PRUs.
>>>
>> That should be fine.
> 
> That sounds good to me too.
> 
> For dts, yeah please allocate the resources for the modules
> where the resources belong to on the PRUSS internal interconnect :)
> Devices can move around on the interconnect between SoCs and the
> modules can get swapped or added.

If you take a look at "Figure 30-1. PRU-ICSS Overview" in 
http://www.tij.co.jp/jp/lit/ug/spruhz7h/spruhz7h.pdf

You can see that DRAM0 and DRAM1 are not part of PRU. That means
they shouldn't be in the PRU node then.

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
