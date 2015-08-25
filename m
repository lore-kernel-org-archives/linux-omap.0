From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 1/2] regulator: pbias: use untranslated address to program
 pbias regulator
Date: Tue, 25 Aug 2015 13:03:04 +0300
Message-ID: <55DC3D58.4030409@ti.com>
References: <1437996250-2913-1-git-send-email-kishon@ti.com> <1437996250-2913-2-git-send-email-kishon@ti.com> <20150814180006.GB10748@sirena.org.uk> <55D2C872.9000400@ti.com> <20150819181149.GZ10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150819181149.GZ10748@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

On 08/19/2015 09:11 PM, Mark Brown wrote:
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
> offset?  Or provide a wrapper function in the resource code which does
> that.  

I'd be very appreciated if you have and can share any thought on
How can we get this absolute base address to substract?

Below is what we have in DT:

	l4_cfg: l4@4a000000 {
			compatible = "ti,dra7-l4-cfg", "simple-bus";
			#address-cells = <1>;
			#size-cells = <1>;
			ranges = <0 0x4a000000 0x22c000>;

	[GS] <=== 0x4a000000 is our top level l4 base address

			scm: scm@2000 {
				compatible = "ti,dra7-scm-core", "simple-bus";
				reg = <0x2000 0x2000>;
				#address-cells = <1>;
				#size-cells = <1>;
				ranges = <0 0x2000 0x2000>;

	[GS] <=== 0x4a002000 is our scm-core base address
	IORESOURCE_MEM: 0x4a002000 : 4A003FFF

				scm_conf: scm_conf@0 {
					compatible = "syscon", "simple-bus";
					reg = <0x0 0x1400>;
					#address-cells = <1>;
					#size-cells = <1>;

	[GS] <=== 0x4a002000 is our syscon base address
	IORESOURCE_MEM: 0x4a002000 : 4A0033FF

					pbias_regulator: pbias_regulator {
						compatible = "ti,pbias-omap";
						reg = <0xe00 0x4>;

	[GS] <=== 0x4a002E00 is our pbias base address
	IORESOURCE_MEM: 0x4a002E00 : 4A002E03
	Here we should use reg_offset=0xE00 as input parameter for regmap APIs.

						syscon = <&scm_conf>;
						pbias_mmc_reg: pbias_mmc_omap5 {
							regulator-name = "pbias_mmc_omap5";
							regulator-min-microvolt = <1800000>;
							regulator-max-microvolt = <3000000>;
						};
					};

					scm_conf_clocks: clocks {
						#address-cells = <1>;
						#size-cells = <0>;
					};
				};

As I understood, all of_address APIs/code is designed to parse/translate
addresses in top-bottom direction, and it looks nontrivial to get any kind
of base addresses from driver's side (except of its own address), because
it will require reverse DT parsing in bottom-top direction.
Maybe I missed smth?

-- 
regards,
-grygorii
