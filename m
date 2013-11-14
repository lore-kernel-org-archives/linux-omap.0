From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V3] ARM: OMAP2+: omap_device: maintain sane runtime pm
 status around suspend/resume
Date: Thu, 14 Nov 2013 12:55:58 -0600
Message-ID: <20131114185558.GB16529@saruman.home>
References: <1384297710-29694-1-git-send-email-nm@ti.com>
 <1384448716-3186-1-git-send-email-nm@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1244643936763653475=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1384448716-3186-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: paul@pwsan.com, khilman@linaro.org, Tony Lindgren <tony@atomide.com>, rnayak@ti.com, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============1244643936763653475==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Content-Disposition: inline

--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 14, 2013 at 11:05:16AM -0600, Nishanth Menon wrote:
> OMAP device hooks around suspend|resume_noirq ensures that hwmod
> devices are forced to idle using omap_device_idle/enable as part of
> the last stage of suspend activity.
>=20
> For a device such as i2c who uses autosuspend, it is possible to enter
> the suspend path with dev->power.runtime_status =3D RPM_ACTIVE.
>=20
> As part of the suspend flow, the generic runtime logic would increment
> it's dev->power.disable_depth to 1. This should prevent further
> pm_runtime_get_sync from succeeding once the runtime_status has been
> set to RPM_SUSPENDED.
>=20
> Now, as part of the suspend_noirq handler in omap_device, we force the
> following: if the device status is !suspended, we force the device
> to idle using omap_device_idle (clocks are cut etc..). This ensures
> that from a hardware perspective, the device is "suspended". However,
> runtime_status is left to be active.
>=20
> *if* an operation is attempted after this point to
> pm_runtime_get_sync, runtime framework depends on runtime_status to
> indicate accurately the device status, and since it sees it to be
> ACTIVE, it assumes the module is functional and returns a non-error
> value. As a result the user will see pm_runtime_get succeed, however a
> register access will crash due to the lack of clocks.
>=20
> To prevent this from happening, we should ensure that runtime_status
> exactly indicates the device status. As a result of this change
> any further calls to pm_runtime_get* would return -EACCES (since
> disable_depth is 1). On resume, we restore the clocks and runtime
> status exactly as we suspended with. These operations are not expected
> to fail as we update the states after the core runtime framework has
> suspended itself and restore before the core runtime framework has
> resumed.
>=20
> Reported-by: J Keerthy <j-keerthy@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Acked-by: Rajendra Nayak <rnayak@ti.com>
> Acked-by: Kevin Hilman <khilman@linaro.org>
> ---
> Changes in V3:
> 	- Added WARN in case of unexpected failure of runtime pm status restore
> v2: https://patchwork.kernel.org/patch/3176501/
> v1: https://patchwork.kernel.org/patch/3154501/
>=20
> patch baseline: V3.12 tag (also applies on linux-next next-20131107 tag)
>=20
>  arch/arm/mach-omap2/omap_device.c |   13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap=
_device.c
> index b69dd9a..53f0735 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -621,6 +621,7 @@ static int _od_suspend_noirq(struct device *dev)
> =20
>  	if (!ret && !pm_runtime_status_suspended(dev)) {
>  		if (pm_generic_runtime_suspend(dev) =3D=3D 0) {
> +			pm_runtime_set_suspended(dev);
>  			omap_device_idle(pdev);
>  			od->flags |=3D OMAP_DEVICE_SUSPENDED;
>  		}
> @@ -634,10 +635,18 @@ static int _od_resume_noirq(struct device *dev)
>  	struct platform_device *pdev =3D to_platform_device(dev);
>  	struct omap_device *od =3D to_omap_device(pdev);
> =20
> -	if ((od->flags & OMAP_DEVICE_SUSPENDED) &&
> -	    !pm_runtime_status_suspended(dev)) {
> +	if (od->flags & OMAP_DEVICE_SUSPENDED) {
>  		od->flags &=3D ~OMAP_DEVICE_SUSPENDED;
>  		omap_device_enable(pdev);
> +		/*
> +		 * XXX: we run before core runtime pm has resumed itself. At
> +		 * this point in time, we just restore the runtime pm state and
> +		 * considering symmetric operations in resume, we donot expect
> +		 * to fail. If we failed, something changed in core runtime_pm
> +		 * framework OR some device driver messed things up, hence, WARN
> +		 */
> +		WARN(pm_runtime_set_active(dev),
> +		     "Could not set %s runtime state active\n", dev_name(dev));

if you want to print the device name, how about dev_WARN() ?

no strong feelings though:

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJShRy+AAoJEIaOsuA1yqREPxoP/Az/LC4WkJYImMadVQStvqGu
zjVmJVowHNLh1S7v0WuRdtUfVwuQu1U5QnQnSX9sRQPaKyqqOtHO7p0rjjo/YmD6
DGFAHhY9FYJAx2EexMt9HMDZWFha79WhtbQLpPR0/8tdNQGqB8VPirKY/rJs8AJl
DhYdv82l2LsUox8+QxMXssDnfIzlYsgwCUYus7TkpQAQWOhA6oK39veQSJCLWTF7
JHr+M845+9U+FsdNZ2LVnVmtFMg9sTbnMYA1fTA+LBBTaH86CX+bBlsllpPphK4k
+UT3ll/kNIUbIuMDvU7valdTpttI/i6cqGRkQoDN6ABro+cqE7aazz4HCdsGUCnq
uFJitaVv6PT9OdT1j9VRjcGC+NKaJq8jMvrpASVL1vm0k2ZV9ve0IM0tuht9WddX
OLqdV1ebRJtJyXmwR+Mvaj07CD5ZHPIlMKPE5MqdGeLwTUQq1oj91MQystybYujy
PVtS2KoSoMbqLAsnnRrDPpxiwM+R/lT55G2Dl57xwuI7fML0EdK5OhruPDjkbKT+
FTjpBZo+N4whY+IsxO3TIdqY8oxG45TEAjewKHpCXn2xoMjKjSlM5PEoPXdrzOoh
ucu6X3zz1saMhI43DB6ulDfdA3dViSgt4f4Rn+o7jpx3RkIVLsmNitGho4kvMYbK
zE3/oDGTmDJ7Eiz247Xv
=UfxI
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--


--===============1244643936763653475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1244643936763653475==--
