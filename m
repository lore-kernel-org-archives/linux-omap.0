From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/2] regulator: pbias: use untranslated address to program
 pbias regulator
Date: Thu, 20 Aug 2015 11:21:06 +0530
Message-ID: <55D56ACA.1030309@ti.com>
References: <1437996250-2913-1-git-send-email-kishon@ti.com> <1437996250-2913-2-git-send-email-kishon@ti.com> <20150814180006.GB10748@sirena.org.uk> <55D2C872.9000400@ti.com> <20150819181149.GZ10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150819181149.GZ10748@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, grygorii.strashko@ti.com, nsekhar@ti.com, stable@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Mark Brown,

On Wednesday 19 August 2015 11:41 PM, Mark Brown wrote:
> On Tue, Aug 18, 2015 at 11:23:54AM +0530, Kishon Vijay Abraham I wrote:
>> On Friday 14 August 2015 11:30 PM, Mark Brown wrote:
>>> On Mon, Jul 27, 2015 at 04:54:09PM +0530, Kishon Vijay Abraham I wrote:
> 
>>>> is moved as a child node of syscon, vsel_reg and enable_reg has the
>>>> absolute address because of the address translation that happens while
>>>> creating device from device tree node.
>>>> So avoid using platform_get_resource and use of_get_address in order to
>>>> get only the offset (untranslated address) and populate these in
>>>> vsel_reg and enable_reg.
> 
>>> This sounds like we're going in the wrong direction, we're moving from a
>>> more generic API to a firmware specific one.  Why is this a good fix?
> 
>> platform_get_resource can be used if we need the absolute address but here we
>> need only the offset.
> 
> So substract this address from the start of the resource to get the

That would mean from the offset (provided in dt) get the absolute address and
then again from the absolute address get the offset.
> offset?  Or provide a wrapper function in the resource code which does

Why not use 'of_get_address' which does the same thing? Moreover it's not a
resource we are dealing with here. It's a resource only for the syscon driver.
> that.  What you're saying above is pretty much "this happens to work"
> but my concern is that the solution that happens to work isn't really
> what we want to do.

Not just makes this work, this is also the most reasonable solution available IMHO.

The most ideal way would have been to use something like what Grygorii
mentioned to use syscon = <&scm_conf 0xe00> and then use the phandle to get the
offset. But then with this we'll be breaking older dtbs.

Thanks
Kishon
