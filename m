From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2 1/9] ASoC: omap: rx51: Use static const char * const
 arrays
Date: Tue, 29 Apr 2014 15:22:46 -0700
Message-ID: <20140429222246.GP15125@sirena.org.uk>
References: <1398694047-28596-1-git-send-email-sre@kernel.org>
 <1398694047-28596-2-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+NfgObvpQT1Q9Yq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1398694047-28596-2-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Sebastian Reichel <sre@ring0.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org


--U+NfgObvpQT1Q9Yq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 28, 2014 at 04:07:19PM +0200, Sebastian Reichel wrote:
> Mark the array and the string const by using "static const char * const
> foo[]" instead of "static const char* foo[]".

Applied, thanks.

--U+NfgObvpQT1Q9Yq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYCYzAAoJELSic+t+oim9h+MP/jfm2/mAEUyhGm9ZNpF8maQB
8AbfyBZmRwmBvdf8RS9d9tywsTluRlBlOjzjUEbSU39y7fScOejhsxfnwAwaW6/B
Wk9MICUtCM/Dxrf8TgOMdY6IT9kNZbjsRmOfmda5P5YYA2UOinPcDoV7x/JeZ+pF
bSO10AjJ9mKeKBp7YCO5DA6fHpK7V7v4ICP+8Ue+wuhaAlLWgUV4p8tAgel8hgES
ndRwQeSmSMVbzoB5VxBogj5BtJ23NoKDYXqZPdaqk90K3clKUsF4SjcpnDFhuxpU
wUkPjwB2gsiwDnlQYQtn32asyjPbS9dQR64Ehw1qRPD5cCwTDFmYYV8hK3CPMqWM
vnUOtPPoq08RoAp9dexm0ukS9DyWpu+X5026vAijRncsAsfcxt/DoS2CmdtZe1Ey
RlcXuwaMgCM7z0g/JS5MJZ09n1t1hPWaTvIclAjuN9HhTNheXOt7+7pSWVfFZJ3h
m/S+OL4AN/0pNAncOsvb9/MYNgwubCZCTQfDzIjQ/M5Mh7GqqqVDd+kNV9FyvqmV
EwUyy4Oppc4hhVk4aSlmkNb/O372KLgysg/W6ubcKUOwRG/t8v/z+ny64+Pg4Xy4
40SQ4gHMe8xXxLP8xl5Pi6q1GgCkge7pOi5VI7lFdoTpj1rO2HAEJtVFFFy6DWTE
Vkca6Qqn4F85w16jJvKV
=832Z
-----END PGP SIGNATURE-----

--U+NfgObvpQT1Q9Yq--
