From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 0/2] omap: dsp: make the driver actually work
Date: Tue, 5 Oct 2010 15:09:39 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5304681D48D3@dlee03.ent.ti.com>
References: <1286208555-8829-1-git-send-email-felipe.contreras@gmail.com>
	<20101005190741.GC20825@kroah.com>
	<AANLkTikOBWxXh7uVrDxfW3OnwOM58JTXU76KUUoQWBWM@mail.gmail.com>
	<27F9C60D11D683428E133F85D2BB4A5304681D4889@dlee03.ent.ti.com>
 <AANLkTin=k07hUq+cLAOsf0aYw5Ey23UOpbpo=+Eb49w9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTin=k07hUq+cLAOsf0aYw5Ey23UOpbpo=+Eb49w9@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-omap <linux-omap@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>
List-Id: linux-omap@vger.kernel.org

Felipe Contreras wrote:
...
>> 
>> phys_to_virt instead of ioremap should work fine, still need to try
>> it though. 
> 
> I tried that... Didn't work. I guess we need to flush at some points
> (since the memory is cacheable). 

Hmmm, because my other option was to move the reserved memory outside the kernel, but that involves specifying bootargs again and using dma_alloc_coherent with their restrictions.

If you are working on a different method and need any help let me know.

Regards,

Omar