From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 11/20] OMAPDSS: HDMI: split power_on/off to two parts
Date: Mon, 29 Oct 2012 12:30:41 +0200
Message-ID: <508E5AD1.8090109@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com> <1351070951-18616-12-git-send-email-tomi.valkeinen@ti.com> <508E570D.1000101@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig51787648F477121AED4F5855"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58178 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758546Ab2J2Kao (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Oct 2012 06:30:44 -0400
In-Reply-To: <508E570D.1000101@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

--------------enig51787648F477121AED4F5855
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-29 12:14, Archit Taneja wrote:
> On Wednesday 24 October 2012 02:59 PM, Tomi Valkeinen wrote:
>> There's currently just one power-on function for HDMI, which enables t=
he
>> IP and the video output. When reading EDID or detecting if a monitor i=
s
>> connected, we don't need the video output.
>>
>> Enabling the video output for these operations is not a big problem in=

>> itself, but the quick enable/disable cycles caused by the operations
>> seem to cause sync lost errors from time to time. Also, this makes it
>> possible to read the EDID before the full video path has been set up.
>>
>> This patch splits the hdmi_power_on into two parts, hdmi_power_on_core=

>> and hdmi_power_on_full. The "full" version does what hdmi_power_on doe=
s
>> currently, and hdmi_power_on_core only enables the core IP. Similar
>> changes are made for power_off.
>>
>> Note that these don't allow the HDMI IP to be first enabled, and later=

>> enable the video output, but the HDMI IP will first need to be powered=

>> off before calling the full version. So this is rather limited
>> implementation, but it fills the needs for reading EDID.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: Ricardo Neri <ricardo.neri@ti.com>
>> ---
>>   drivers/video/omap2/dss/hdmi.c |   75
>> ++++++++++++++++++++++++----------------
>>   1 file changed, 46 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/hdmi.c
>> b/drivers/video/omap2/dss/hdmi.c
>> index c1c5488..50d5a10 100644
>> --- a/drivers/video/omap2/dss/hdmi.c
>> +++ b/drivers/video/omap2/dss/hdmi.c
>> @@ -500,12 +500,9 @@ static void hdmi_compute_pll(struct
>> omap_dss_device *dssdev, int phy,
>>       DSSDBG("range =3D %d sd =3D %d\n", pi->dcofreq, pi->regsd);
>>   }
>>
>> -static int hdmi_power_on(struct omap_dss_device *dssdev)
>> +static int hdmi_power_on_core(struct omap_dss_device *dssdev)
>>   {
>>       int r;
>> -    struct omap_video_timings *p;
>> -    struct omap_overlay_manager *mgr =3D dssdev->output->manager;
>> -    unsigned long phy;
>>
>>       gpio_set_value(hdmi.ct_cp_hpd_gpio, 1);
>>       gpio_set_value(hdmi.ls_oe_gpio, 1);
>> @@ -521,6 +518,46 @@ static int hdmi_power_on(struct omap_dss_device
>> *dssdev)
>>       if (r)
>>           goto err_runtime_get;
>>
>> +    /* Make selection of HDMI in DSS */
>> +    dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
>> +
>> +    /* Select the dispc clock source as PRCM clock, to ensure that it=

>> is not
>> +     * DSI PLL source as the clock selected by DSI PLL might not be
>> +     * sufficient for the resolution selected / that can be changed
>> +     * dynamically by user. This can be moved to single location , sa=
y
>> +     * Boardfile.
>> +     */
>> +    dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);=

>> +
>> +    return 0;
>> +
>> +err_runtime_get:
>> +    regulator_disable(hdmi.vdda_hdmi_dac_reg);
>> +err_vdac_enable:
>> +    gpio_set_value(hdmi.ct_cp_hpd_gpio, 0);
>> +    gpio_set_value(hdmi.ls_oe_gpio, 0);
>> +    return r;
>> +}
>> +
>> +static void hdmi_power_off_core(struct omap_dss_device *dssdev)
>> +{
>> +    hdmi_runtime_put();
>> +    regulator_disable(hdmi.vdda_hdmi_dac_reg);
>> +    gpio_set_value(hdmi.ct_cp_hpd_gpio, 0);
>> +    gpio_set_value(hdmi.ls_oe_gpio, 0);
>=20
> We might want to set the DISPC clock source back to DSS_FCK here. Just
> in case it was using something else. Having this still won't make thing=
s
> full proof, but probably slightly better.

In this patch I only split the code, keeping the current behavior. But
true, setting the clk src back to DSS_FCK makes sense. Although I'd
rather remove the whole dispc clk src call, as the output drivers
calling it can easily mess things up.

 Tomi



--------------enig51787648F477121AED4F5855
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQjlrRAAoJEPo9qoy8lh71j1oQAJ+MvgJVep03fn1I8A7pnPgB
AuXOka7Aen1JQXp9DzVVrbC7jUvqW94BPOOxaglEwQmJUv60y5hMYOicmxzsEJYV
+skoa0xELUFCVq4EUYVCql/REmXmusgw9W84tVUNgxDp4rVcjM165+1kGllHs5Ex
9WCoFr0A/z1wfxgWaNY8UIjPbBkTDi6pjafRevn8l8KS5KqLqN9ncajQPGilc1VC
44licOD00Kz8j5jXw1IrLuFpnSSojrdZ5et4FPbw3psRRjDBywqCvV2P2LNMQB4k
rMPHd8jtA6TQiiUOQ8Z50Sk4awpAFTrhmoCUcpOZyyrh1/l3NiPKSO9RJBAOFp/G
OdPn1hgc1XadFPCJUSfIPsHVoeDgxyikuqKtfmW0FUkLSCN3cyRdUYzno4sNZ1OV
jl0L4NnrgwWvZdKXKe6ani5gJf43CcII8YYv82AMZH93z1vMeA+t7wxU5jl2tpYS
aOSQ7c5ZJ3srnp/4rLPmTPHy+51fauPNavz/cpr34WxIxpa+whn9Z72AFIqbH6U7
wAl/4aaCdCNLNMDVIxuwqDEvAdFSs+Q5ckc3DrScSSTKUiM6/YlMB0fUcBd+6uMt
SEbXUKMWShCF2KyCJgLrzRSbkDE1kY9oGtlIFJ0ubIwTnqej4DiMAUpb6q2EHiDG
O/VrBo5UwCpNd83TXj6G
=g77c
-----END PGP SIGNATURE-----

--------------enig51787648F477121AED4F5855--
