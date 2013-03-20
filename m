From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V2 8/8] cpufreq: OMAP: donot allow to be used with device
 tree
Date: Wed, 20 Mar 2013 11:47:50 +0530
Message-ID: <5149548E.6030405@ti.com>
References: <1363715590-5131-1-git-send-email-nm@ti.com> <1363715590-5131-9-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1363715590-5131-9-git-send-email-nm@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Jon Hunter <jon-hunter@ti.com>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <b-cousson@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 19 March 2013 11:23 PM, Nishanth Menon wrote:
> We now use Soc generic cpufreq-cpu0 driver using DT entries.
> However to allow cpufreq-cpu0 and omap-cpufreq drivers to co-exist,
> we need to ensure the following using the same image:
> 1. With device tree boot, we use cpufreq-cpu0
> 2. With non device tree boot, we use omap-cpufreq
>=20
> In the case of (1), we will have cpu OPPs and regulator registered
> as part of the DT, to ensure that omap-cpufreq and cpufreq-cpu0 don't
> conflict in managing the frequency of the same cpu, we should not
> permit init to pass in omap-cpufreq.
>=20
> In the case of (2), we will not have the cpufreq-cpu0 device, hence
> only omap-cpufreq will be active.
>=20
> So, to acommodate both these usage conditions, we fail init of
> omap-cpufreq when we boot with device tree.
>=20
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: linux-omap@vger.kernel.org
> Cc: devicetree-discuss@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: cpufreq@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
I haven't followed all the DT binding for opp discussion but
this patch is inline to keep non-DT cpufreq working till we
move to DT only build.
So FWIW,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
