From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 2/2] OMAPDSS: HDMI: Disable DDC internal pull up
Date: Tue, 20 Dec 2011 10:56:53 +0200
Message-ID: <1324371413.2042.11.camel@deskari>
References: <1324370283-11884-1-git-send-email-mythripk@ti.com>
	 <1324370283-11884-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-dLlvYpmo2+03F8vO1gMb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:42455 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750865Ab1LTI47 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Dec 2011 03:56:59 -0500
Received: by lago2 with SMTP id o2so2454084lag.38
        for <linux-omap@vger.kernel.org>; Tue, 20 Dec 2011 00:56:56 -0800 (PST)
In-Reply-To: <1324370283-11884-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org, Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>


--=-dLlvYpmo2+03F8vO1gMb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-12-20 at 14:08 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Disables the internal pull resistor for SDA and SCL which are enabled by
> default, as there are external pull up's in 4460 and 4430 ES2.3
> SDP, Blaze and Panda Boards, It is done to avoid the EDID read failure.
>=20
> Signed-off-by: Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>
> Signed-off-by: Mythri P K <mythripk@ti.com>

<snip>

>  struct rfbi_timings {
> @@ -310,7 +314,7 @@ struct omap_dss_board_info {
>  /* Init with the board info */
>  extern int omap_display_init(struct omap_dss_board_info *board_data);
>  /* HDMI mux init*/
> -extern int  omap_hdmi_init(void);
> +extern int omap_hdmi_init(enum omap_hdmi_flags flags);

These patches you sent are broken. You add the omap_hdmi_init line in
the previous patch, and change it here, but the lines are different
(this one has two spaces between "int" and "omap_hdmi_init", and the
previous doesn't) so the patches cannot be applied.

I guess you hand edited them, or did something else manually. Never do
that. Use git rebase or similar methods to edit the patches, and create
the whole patch set with git-format-patch in one go.

If you absolutely have to edit the patch files, apply them to your git
tree afterwards and use git-format-patch to create the patch series
before sending.

And an introductory email with version history would be nice also.

 Tomi


--=-dLlvYpmo2+03F8vO1gMb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO8E3VAAoJEPo9qoy8lh714SUP/jITvsvRKlwu3Ki2+ymYqfdl
fs3IxtBn77v5a0/ky5b1dV6BU8hxm9xKX/BG83BsYVWh3jxxNqALlxD+GQ0OFeW/
Tswv8FGYADq3FMd8ZmDsReVRwGY06sFt576aRooThF28YBx3vNbmxqfvH7JdbMsN
rg0RTyECInSnNMdeT4Oj5Wy3r8UQbwg55FyKgdRhkHvyKg+QwolCLmp0sTxnkb64
ZHc6jAVcym0b9POcbCEwrculdVS7pAe+IRnsKTD5fLtC7VhppGKBQ8RWmU0dju2g
yeSch+PhKCsS96/Zl1bDP5UNQyMV6t2iFk4ceVkXeAOijfzmaOW86WcO5mSK7Hnf
usqIfT9h22ygZf9KMDYlNrZwPQZzK+gjFjIM85HsbyQPpp3PpfARIYjiwnSy3QSN
LCkEzvh6zfBmYghBph0SEhJenSsO0X7rB6qc+H86p7lmYb7nxz/wGrL77gZ0qkw4
r67ojNVzs+VwuaZuRzgRI763G+Irh9QKVyB8OaJHzkz8SMXgdS7FOpmI7o/jR6O9
EMnqmynPCnOndNjpG/AF8eN06Z3WjWNjsvydQkIAfLW9NBtdC0+sUA1rQB5AygvJ
68dqAeah+84izzBTbjQs7PQHuVDq2a+zn0/bd1Nkcpjqp4d/NyEhaKtQMmG10BgI
S6iLbD2Ph0DsDhGnzVZd
=KqDK
-----END PGP SIGNATURE-----

--=-dLlvYpmo2+03F8vO1gMb--

