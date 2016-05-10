From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v7 4/5] usb: dwc3: omap: Pass VBUS and ID events
 transparently
Date: Tue, 10 May 2016 13:00:53 +0300
Message-ID: <5731B155.6010109@ti.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com>
 <1462873919-20532-5-git-send-email-rogerq@ti.com>
 <87d1oui6eh.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87d1oui6eh.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, b-liu@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/05/16 12:55, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq@ti.com> writes:
>> Don't make any decisions regarding VBUS session based on ID
>> status. That is best left to the OTG core.
>>
>> Pass ID and VBUS events independent of each other so that OTG
>> core knows exactly what to do.
>>
>> This makes dual-role with extcon work with OTG irq on OMAP platforms.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> I have a feeling this will regress OMAP5432 uEVM. Did you test with that
> board ?
> 

Yes. Any specific test case you would like me to test?
For now I'm just doing enumeration with g_zero.

cheers,
-roger
