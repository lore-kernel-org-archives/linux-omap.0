From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC] [PATCH v3 2/4] OMAP4: Keyboard device registration
Date: Tue, 1 Jun 2010 21:53:58 +0300
Message-ID: <20100601185358.GE23818@nokia.com>
References: <27F9C60D11D683428E133F85D2BB4A53043E537F74@dlee03.ent.ti.com>
 <20100601094358.GJ841@atomide.com>
 <27F9C60D11D683428E133F85D2BB4A53043E538286@dlee03.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043E538286@dlee03.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: "ext Arce, Abraham" <x0066660@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 01, 2010 at 05:14:09PM +0200, ext Arce, Abraham wrote:
>I am using #ifdef CONFIG_ARCH_OMAP4 for this portion of code, what you 
>are suggesting is to check at runtime?

you need to add both checks. If you build omap3-only or omap2-only you 
don't want that code to be compiled, but if you build omap1-2-3-4 
kernel, you want it to work correctly on all cases.

-- 
balbi

DefectiveByDesign.org
