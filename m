From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [RFC] Correct registration of multiple gpmc smsc911x
 devices.
Date: Wed, 21 Mar 2012 18:13:00 +0000
Message-ID: <20120321181259.GJ3226@opensource.wolfsonmicro.com>
References: <4F6324D5.9010106@uni-dortmund.de>
 <1332352554-6417-1-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="utPK4TBebyzZxMrE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42467 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759820Ab2CUSNC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 14:13:02 -0400
Content-Disposition: inline
In-Reply-To: <1332352554-6417-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org, mporter@ti.com, tony@atomide.com, robert.marklund@stericsson.com, linus.walleij@linaro.org


--utPK4TBebyzZxMrE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 21, 2012 at 10:55:54AM -0700, Russ Dill wrote:

> unwieldy this would become if it were done for every device. Either the
> functionality needs to be moved to Snowball board init code, or a generic
> framework needs to be made for attaching regulators to arbitrary devices.

Hrm?  Adding regulator supply mappings anywhere other than the
initialisation for a specific board would be extremely unusual and
rather suspicious.

> +	supplies = kcalloc(ARRAY_SIZE(smsc911x_refs) * num,
> +			sizeof(struct regulator_consumer_supply), GFP_KERNEL);
> +	if (!supplies) {
> +		pr_err("Failed to allocate memory\n");
> +		return;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(smsc911x_refs) * num; i++) {
> +		int id;
> +		char *name;
> +
> +		id = board_data[i / num].id;
> +		if (id != -1)
> +			name = kasprintf(GFP_KERNEL, "smsc911x.%d", id);
> +		else
> +			name = kstrdup("smsc911x", GFP_KERNEL);

This seems pretty much insane, it's costing a lot more to faff around
like this than it's worth.  Just do the setup in the individual boards,
if you really have no idea what's supplying the device (which seems a
bit unusual, more boards like this have things coming off the PMIC than
don't) there's now regulator_register_fixed() which cuts down on the
boilerplate a little.

I'd have complained about the original code if I'd noticed it wasn't a
patch for a particular board as the breakage you've found is obvious.
The regulation constraints it adds are bogus too, it's setting
REGULATOR_CHANGE_MODE on a regulator that doesn't support modes and
REGULATOR_CHANGE_STATUS without supplying the enable GPIO.

--utPK4TBebyzZxMrE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPahokAAoJEBus8iNuMP3d0OYP/jLkmOvRvagU7VoVnvxsGEYB
WPzfkbgnhmtxMnH6QBtzJZaNWj6eUGmXmtmUAWRNf3yyZNB/ZyRtKAn5t495Xi0R
r5kSNrxd+AZH2ArQU928g5ia1qpaIfVT6k499Zo6z3lQyWq/tEuIZ8XLyZM76emY
65VDh2exonnTJdBKUNhUlqa7tpcZArgwqxEpYAF3ZAhDdnKkUmdeIzPS9jf6Ya+r
YkGSQKWqaq/YtIlzIJ/BagtJQeBJ8XbhD0e2/c5U64WGODw7/TyFMqQnuE8l2hOp
yd2pnM2Vd26x58yF+avek/+1540uRfRWa41UJ6ZXXOL5ce/Gruv+yNjmNRztDHVd
VFrvfu2wlmLmWtzMd3Kcf0AwV6Ag4h7+cVF+5fZVSaxEOvrQZh3j/3+z63DaVJ/3
YIoC+vDr7Kx+Y8UA6xstoc2fVgk8JbAxynwPxqqJkNHINPdc/jNa/csH4zy1KrZc
gWM16x73XmgqYBfFeXw0QW4RJWT3KP8B8awJA3X7Qn+6l7uTYxdc9BrbpaKgs53g
gUqrkO/628l/7VmxBEwTZWrUd66d9BN1NixK1fpnx80tewtdGrKPvXGZtSdF3QaU
vfkPG0Dw4A72kQRVjITrAEtPvNVt4lpdlQgupAQbzfPWLTbcdUI6eDCcde490Xnj
28WdFrkLMiGicrOtxtCT
=dCkG
-----END PGP SIGNATURE-----

--utPK4TBebyzZxMrE--
