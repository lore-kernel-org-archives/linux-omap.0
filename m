From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/2] regulator: pbias: use untranslated address to program
 pbias regulator
Date: Mon, 31 Aug 2015 16:14:07 +0530
Message-ID: <55E42FF7.9010706@ti.com>
References: <1437996250-2913-1-git-send-email-kishon@ti.com> <1437996250-2913-2-git-send-email-kishon@ti.com> <20150814180006.GB10748@sirena.org.uk> <55D2C872.9000400@ti.com> <20150819181149.GZ10748@sirena.org.uk> <55DC3D58.4030409@ti.com> <20150825135044.GJ27431@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150825135044.GJ27431@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

On Tuesday 25 August 2015 07:20 PM, Mark Brown wrote:
> On Tue, Aug 25, 2015 at 01:03:04PM +0300, Grygorii Strashko wrote:
>> On 08/19/2015 09:11 PM, Mark Brown wrote:
> 
>>> So substract this address from the start of the resource to get the
>>> offset?  Or provide a wrapper function in the resource code which does
>>> that.  
> 
>> I'd be very appreciated if you have and can share any thought on
>> How can we get this absolute base address to substract?
> 
> Ask the syscon device for its resource?  Or have it provide an absolute

Even if we get the absolute address of syscon, we have to do the
subtraction only for the newer dtbs (previous dtbs already have only the
offset). Do you recommend adding a new property to differentiate between
older dtbs and newer dtbs? Any other suggestions here?

> address based interface for that matter?

Syscon doesn't directly expose any API's to write to it's register.
Rather it uses regmap APIs to read/write to it's register. I'm not sure
if it's possible to add regmap APIs to write to a register with absolute
address. Any hints?

Thanks
Kishon
