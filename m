From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 0/2] omap: dsp: make the driver actually work
Date: Tue, 5 Oct 2010 14:52:30 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5304681D4889@dlee03.ent.ti.com>
References: <1286208555-8829-1-git-send-email-felipe.contreras@gmail.com>
	<20101005190741.GC20825@kroah.com>
 <AANLkTikOBWxXh7uVrDxfW3OnwOM58JTXU76KUUoQWBWM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTikOBWxXh7uVrDxfW3OnwOM58JTXU76KUUoQWBWM@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, Greg KH <greg@kroah.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>
List-Id: linux-omap@vger.kernel.org

Felipe Contreras wrote:
...
> 
> Well, I thought it would be nice if the driver actually worked on
> .36, but anyway, I'll rebase the rest of my cleanup patches and send
> them. Hopefully I find a way to get rid of the ioremap() issue. 
> 

phys_to_virt instead of ioremap should work fine, still need to try it though.

Regards,

omar
