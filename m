From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: linux-next: manual merge of the usb tree with the omap tree
Date: Thu, 6 Jan 2011 23:02:00 +0800
Message-ID: <AANLkTi=pTNg2iWN+=uEv=CyZHHCoddF51pmmCMjPeMUF@mail.gmail.com>
References: <20101223171859.f6842045.sfr@canb.auug.org.au>
	<4D139517.3010608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <4D139517.3010608@ti.com>
Sender: linux-next-owner@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Walmsley <paul@pwsan.com>, Greg KH <greg@kroah.com>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>, "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

2010/12/24 Cousson, Benoit <b-cousson@ti.com>:
> + Paul "the omap clock guru".
>
> At first glance, that seems almost good.
> Except for a couple of nodes that seems to lose their 3630 support.
>
> I'm just wondering why the original usb clock node is
> kept after the introduction of the "ehci-omap.0" clock
> node. But this is anyway harmless.
>
> What commits are generating this conflict?
>
> On 12/23/2010 7:18 AM, Stephen Rothwell wrote:
>> Hi Greg,
>>
>> Today's linux-next merge of the usb tree got a conflict in
>> arch/arm/mach-omap2/clock3xxx_data.c and
>> arch/arm/mach-omap2/clock44xx_data.c between various commits from th=
e omap
>> tree and various commits from the usb tree.
>>
>> I did a quick fix (which may be completely wrong - see below).
>
>> diff --cc arch/arm/mach-omap2/clock3xxx_data.c
>> index 9ab817e,0579604..0000000
>> --- a/arch/arm/mach-omap2/clock3xxx_data.c
>> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
>> @@@ -3275,17 -3267,18 +3275,18 @@@ static struct omap_clk omap3xxx_c=
lks[]
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gfx_l3_ick", =A0 &gfx_l3_ick, =A0=
 =A0CK_3430ES1),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gfx_cg1_ck", =A0 &gfx_cg1_ck, =A0=
 =A0CK_3430ES1),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gfx_cg2_ck", =A0 &gfx_cg2_ck, =A0=
 =A0CK_3430ES1),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "sgx_fck", =A0 =A0 =A0&sgx_fck, =A0=
 =A0 =A0 CK_3430ES2 | CK_3517),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "sgx_ick", =A0 =A0 =A0&sgx_ick, =A0=
 =A0 =A0 CK_3430ES2 | CK_3517),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "sgx_fck", =A0 =A0 =A0&sgx_fck, =A0=
 =A0 =A0 CK_3430ES2PLUS | CK_3517 | CK_36XX),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "sgx_ick", =A0 =A0 =A0&sgx_ick, =A0=
 =A0 =A0 CK_3430ES2PLUS | CK_3517 | CK_36XX),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "d2d_26m_fck", =A0&d2d_26m_fck, =A0=
 CK_3430ES1),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "modem_fck", =A0 =A0&modem_fck, =A0=
 =A0 CK_343X),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "sad2d_ick", =A0 =A0&sad2d_ick, =A0=
 =A0 CK_343X),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "mad2d_ick", =A0 =A0&mad2d_ick, =A0=
 =A0 CK_343X),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "modem_fck", =A0 =A0&modem_fck, =A0=
 =A0 CK_34XX | CK_36XX),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "sad2d_ick", =A0 =A0&sad2d_ick, =A0=
 =A0 CK_34XX | CK_36XX),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "mad2d_ick", =A0 =A0&mad2d_ick, =A0=
 =A0 CK_34XX | CK_36XX),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gpt10_fck", =A0 =A0&gpt10_fck, =A0=
 =A0 CK_3XXX),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gpt11_fck", =A0 =A0&gpt11_fck, =A0=
 =A0 CK_3XXX),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "cpefuse_fck", =A0&cpefuse_fck, =A0=
 CK_3430ES2 | CK_AM35XX),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "ts_fck", =A0 =A0 =A0 &ts_fck, =A0=
 =A0 =A0 =A0CK_3430ES2 | CK_AM35XX),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "usbtll_fck", =A0 &usbtll_fck, =A0=
 =A0CK_3430ES2 | CK_AM35XX),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "cpefuse_fck", =A0&cpefuse_fck, =A0=
 CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "ts_fck", =A0 =A0 =A0 &ts_fck, =A0=
 =A0 =A0 =A0CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "usbtll_fck", =A0 &usbtll_fck, =A0=
 =A0CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
>
> That one could be removed after the introduction of the following one=
 if the
> clk_get(dev, "usbtll_fck") API is used.
>
>> + =A0 =A0 CLK("ehci-omap.0", =A0 =A0 =A0"usbtll_fck", =A0 &usbtll_fc=
k, =A0 =A0CK_3430ES2 | CK_AM35XX),
>
> If only that one is kept it should be:
> + =A0 =A0 =A0 CLK("ehci-omap.0", =A0 =A0 =A0"usbtll_fck", =A0 &usbtll=
_fck, =A0 =A0CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
>
> Assuming that one of the conflicting commits was trying to add the 36=
30 support.
>
>> =A0 =A0 =A0 CLK("omap-mcbsp.1", =A0 =A0 "prcm_fck", =A0 =A0 &core_96=
m_fck, =A0CK_3XXX),
>> =A0 =A0 =A0 CLK("omap-mcbsp.5", =A0 =A0 "prcm_fck", =A0 =A0 &core_96=
m_fck, =A0CK_3XXX),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "core_96m_fck", &core_96m_fck, =A0=
CK_3XXX),
>> @@@ -3309,26 -3302,27 +3310,27 @@@
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "core_12m_fck", &core_12m_fck, =A0=
CK_3XXX),
>> =A0 =A0 =A0 CLK("omap_hdq.0", "fck", =A0 =A0 =A0 =A0&hdq_fck, =A0 =A0=
 =A0 CK_3XXX),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "ssi_ssr_fck", =A0&ssi_ssr_fck_343=
0es1, =A0 CK_3430ES1),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "ssi_ssr_fck", =A0&ssi_ssr_fck_343=
0es2, =A0 CK_3430ES2),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "ssi_ssr_fck", =A0&ssi_ssr_fck_343=
0es2, =A0 CK_3430ES2PLUS | CK_36XX),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "ssi_sst_fck", =A0&ssi_sst_fck_343=
0es1, =A0 CK_3430ES1),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "ssi_sst_fck", =A0&ssi_sst_fck_343=
0es2, =A0 CK_3430ES2),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "ssi_sst_fck", =A0&ssi_sst_fck_343=
0es2, =A0 CK_3430ES2PLUS | CK_36XX),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "core_l3_ick", =A0&core_l3_ick, =A0=
 CK_3XXX),
>> - =A0 =A0 CLK("musb_hdrc", =A0 =A0 =A0 =A0"ick", =A0&hsotgusb_ick_34=
30es1, =A0CK_3430ES1),
>> - =A0 =A0 CLK("musb_hdrc", =A0 =A0 =A0 =A0"ick", =A0&hsotgusb_ick_34=
30es2, =A0CK_3430ES2PLUS | CK_36XX),
>> + =A0 =A0 CLK("musb-omap2430", =A0 =A0"ick", =A0&hsotgusb_ick_3430es=
1, =A0CK_3430ES1),
>> =A0- =A0 =A0CLK("musb-omap2430", =A0 =A0"ick", =A0&hsotgusb_ick_3430=
es2, =A0CK_3430ES2),
>> ++ =A0 =A0CLK("musb-omap2430", =A0 =A0"ick", =A0&hsotgusb_ick_3430es=
2, =A0CK_3430ES2PLUS | CK_36XX),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "sdrc_ick", =A0 =A0 &sdrc_ick, =A0=
 =A0 =A0CK_3XXX),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gpmc_fck", =A0 =A0 &gpmc_fck, =A0=
 =A0 =A0CK_3XXX),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "security_l3_ick", &security_l3_ic=
k, CK_343X),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "pka_ick", =A0 =A0 =A0&pka_ick, =A0=
 =A0 =A0 CK_343X),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "security_l3_ick", &security_l3_ic=
k, CK_34XX | CK_36XX),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "pka_ick", =A0 =A0 =A0&pka_ick, =A0=
 =A0 =A0 CK_34XX | CK_36XX),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "core_l4_ick", =A0&core_l4_ick, =A0=
 CK_3XXX),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "usbtll_ick", =A0 &usbtll_ick, =A0=
 =A0CK_3430ES2 | CK_AM35XX),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "usbtll_ick", =A0 &usbtll_ick, =A0=
 =A0CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
>> + =A0 =A0 CLK("ehci-omap.0", =A0 =A0 =A0"usbtll_ick", =A0 &usbtll_ic=
k, =A0 =A0CK_3430ES2 | CK_AM35XX),
>
> ditto, should probably be:
> =A0+ =A0 =A0 =A0CLK("ehci-omap.0", =A0 =A0 =A0"usbtll_ick", =A0 &usbt=
ll_ick, =A0 =A0CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
>
>> =A0- =A0 =A0CLK("mmci-omap-hs.2", =A0 "ick", =A0&mmchs3_ick, =A0 =A0=
CK_3430ES2 | CK_AM35XX),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "icr_ick", =A0 =A0 =A0&icr_ick, =A0=
 =A0 =A0 CK_343X),
>> =A0- =A0 =A0CLK("omap-aes", "ick", =A0&aes2_ick, =A0 =A0 =A0CK_343X)=
,
>> =A0- =A0 =A0CLK("omap-sham", =A0 =A0 =A0 =A0"ick", =A0&sha12_ick, =A0=
 =A0 CK_343X),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "des2_ick", =A0 =A0 &des2_ick, =A0=
 =A0 =A0CK_343X),
>> =A0+ =A0 =A0CLK("mmci-omap-hs.2", =A0 "ick", =A0&mmchs3_ick, =A0 =A0=
CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "icr_ick", =A0 =A0 =A0&icr_ick, =A0=
 =A0 =A0 CK_34XX | CK_36XX),
>> =A0+ =A0 =A0CLK("omap-aes", "ick", =A0&aes2_ick, =A0 =A0 =A0CK_34XX =
| CK_36XX),
>> =A0+ =A0 =A0CLK("omap-sham", =A0 =A0 =A0 =A0"ick", =A0&sha12_ick, =A0=
 =A0 CK_34XX | CK_36XX),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "des2_ick", =A0 =A0 &des2_ick, =A0=
 =A0 =A0CK_34XX | CK_36XX),
>> =A0 =A0 =A0 CLK("mmci-omap-hs.1", =A0 "ick", =A0&mmchs2_ick, =A0 =A0=
CK_3XXX),
>> =A0 =A0 =A0 CLK("mmci-omap-hs.0", =A0 "ick", =A0&mmchs1_ick, =A0 =A0=
CK_3XXX),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "mspro_ick", =A0 =A0&mspro_ick, =A0=
 =A0 CK_343X),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "mspro_ick", =A0 =A0&mspro_ick, =A0=
 =A0 CK_34XX | CK_36XX),
>> =A0 =A0 =A0 CLK("omap_hdq.0", "ick", =A0 =A0 =A0 =A0&hdq_ick, =A0 =A0=
 =A0 CK_3XXX),
>> =A0 =A0 =A0 CLK("omap2_mcspi.4", "ick", =A0 =A0 &mcspi4_ick, =A0 =A0=
CK_3XXX),
>> =A0 =A0 =A0 CLK("omap2_mcspi.3", "ick", =A0 =A0 &mcspi3_ick, =A0 =A0=
CK_3XXX),
>> @@@ -3361,14 -3355,17 +3363,17 @@@
>> =A0 =A0 =A0 CLK("omapdss", =A0"video_fck", =A0 =A0&dss_96m_fck, =A0 =
CK_3XXX),
>> =A0 =A0 =A0 CLK("omapdss", =A0"dss2_fck", =A0 =A0 &dss2_alwon_fck, C=
K_3XXX),
>> =A0 =A0 =A0 CLK("omapdss", =A0"ick", =A0 =A0 =A0 =A0 =A0&dss_ick_343=
0es1, =A0 =A0 =A0 CK_3430ES1),
>> =A0- =A0 =A0CLK("omapdss", =A0"ick", =A0 =A0 =A0 =A0 =A0&dss_ick_343=
0es2, =A0 =A0 =A0 CK_3430ES2 | CK_AM35XX),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "cam_mclk", =A0 =A0 &cam_mclk, =A0=
 =A0 =A0CK_343X),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "cam_ick", =A0 =A0 =A0&cam_ick, =A0=
 =A0 =A0 CK_343X),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "csi2_96m_fck", &csi2_96m_fck, =A0=
CK_343X),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "usbhost_120m_fck", &usbhost_120m_=
fck, CK_3430ES2 | CK_AM35XX),
>> =A0+ =A0 =A0CLK("omapdss", =A0"ick", =A0 =A0 =A0 =A0 =A0&dss_ick_343=
0es2, =A0 =A0 =A0 CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "cam_mclk", =A0 =A0 &cam_mclk, =A0=
 =A0 =A0CK_34XX | CK_36XX),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "cam_ick", =A0 =A0 =A0&cam_ick, =A0=
 =A0 =A0 CK_34XX | CK_36XX),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "csi2_96m_fck", &csi2_96m_fck, =A0=
CK_34XX | CK_36XX),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "usbhost_120m_fck", &usbhost_120m_=
fck, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
>> + =A0 =A0 CLK("ehci-omap.0", =A0 =A0 =A0"hs_fck", &usbhost_120m_fck,=
 CK_3430ES2 | CK_AM35XX),
>
> ditto
>
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "usbhost_48m_fck", &usbhost_48m_fc=
k, CK_3430ES2 | CK_AM35XX),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "usbhost_48m_fck", &usbhost_48m_fc=
k, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
>> + =A0 =A0 CLK("ehci-omap.0", =A0 =A0 =A0"fs_fck", &usbhost_48m_fck, =
CK_3430ES2 | CK_AM35XX),
>
> ditto
>
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "usbhost_ick", =A0&usbhost_ick, =A0=
 CK_3430ES2 | CK_AM35XX),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "usbhost_ick", =A0&usbhost_ick, =A0=
 CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
>> + =A0 =A0 CLK("ehci-omap.0", =A0 =A0 =A0"usbhost_ick", =A0&usbhost_i=
ck, =A0 CK_3430ES2 | CK_AM35XX),
>
> ditto
>
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "usim_fck", =A0 =A0 &usim_fck, =A0=
 =A0 =A0CK_3430ES2),
>> =A0+ =A0 =A0CLK(NULL, =A0 =A0 =A0 "usim_fck", =A0 =A0 &usim_fck, =A0=
 =A0 =A0CK_3430ES2PLUS | CK_36XX),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gpt1_fck", =A0 =A0 &gpt1_fck, =A0=
 =A0 =A0CK_3XXX),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "wkup_32k_fck", &wkup_32k_fck, =A0=
CK_3XXX),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "gpio1_dbck", =A0 &gpio1_dbck, =A0=
 =A0CK_3XXX),
>> diff --cc arch/arm/mach-omap2/clock44xx_data.c
>> index c426adc,bfcd19f..0000000
>> --- a/arch/arm/mach-omap2/clock44xx_data.c
>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
>> @@@ -3198,6 -2937,10 +3198,7 @@@ static struct omap_clk omap44xx_clk=
s[]
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "uart3_fck", =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0&uart3_fck, =A0 =A0 CK_443X),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "uart4_fck", =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0&uart4_fck, =A0 =A0 CK_443X),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "usb_host_fs_fck", =A0 =A0 =A0 =A0=
 =A0 =A0 =A0&usb_host_fs_fck, =A0 =A0 =A0 CK_443X),
>> + =A0 =A0 CLK("ehci-omap.0", =A0 =A0 =A0"fs_fck", =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &usb_host_fs_fck, =A0 =A0 =A0 CK_443X),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "usb_host_hs_utmi_p3_clk", =A0 =A0=
 =A0&usb_host_hs_utmi_p3_clk, =A0 =A0 =A0 CK_443X),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "usb_host_hs_hsic60m_p1_clk", =A0 =
&usb_host_hs_hsic60m_p1_clk, =A0 =A0CK_443X),
>> =A0- =A0 =A0CLK(NULL, =A0 =A0 =A0 "usb_host_hs_hsic60m_p2_clk", =A0 =
&usb_host_hs_hsic60m_p2_clk, =A0 =A0CK_443X),
>
> I'm not sure these 3 nodes should be removed. AFAIR, they were just s=
lightly moved in lo branch.

Even with the fixes above, ehci on my beagle xM/Panda still doesn't wor=
k
with 2.6.37-next-20110106+, follows the failure messages:

[   57.918182] bus: 'platform': really_probe: probing driver ehci-omap
with device ehci-omap.0
[   57.918243] ehci-omap ehci-omap.0: failed to get ehci port0 regulato=
r
[   57.918273] ehci-omap ehci-omap.0: failed to get ehci port1 regulato=
r
[   57.918304] ehci-omap ehci-omap.0: starting TI EHCI USB Controller
[   57.918457] ehci-omap ehci-omap.0: OMAP UHH_REVISION 0x10
[   57.918487] ehci-omap ehci-omap.0: TLL RESET DONE
[   57.918487] ehci-omap ehci-omap.0: OMAP3 ES version > ES2.1
[   57.918518] ehci-omap ehci-omap.0: UHH setup done, uhh_hostconfig=3D=
31c
[   58.922302] ehci-omap ehci-omap.0: phy reset operation timed out
[   59.930114] ehci-omap ehci-omap.0: phy reset operation timed out
[   59.930145] ehci-omap ehci-omap.0: reset hcs_params 0x1313 dbg=3D0
cc=3D1 pcc=3D3 ordered ports=3D3
[   59.930175] ehci-omap ehci-omap.0: reset hcc_params 0016 thresh 1
uframes 256/512/1024 park
[   59.930206] ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
[   59.936218] drivers/usb/core/inode.c: creating file 'devices'
[   59.936279] drivers/usb/core/inode.c: creating file '001'

Any ideas?

thanks,
--=20
Lei Ming
