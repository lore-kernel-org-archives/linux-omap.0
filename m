From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/33] OMAPDSS: platform_enable/disable callback removal
 from panel drivers
Date: Mon, 15 Apr 2013 12:29:59 +0300
Message-ID: <516BC897.5020802@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <20130213164647.GF7144@atomide.com> <515C2058.8030402@ti.com> <20130403154645.GV10155@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCB0B3C95A048B0EEEE3962F0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36555 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932601Ab3DOJaD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Apr 2013 05:30:03 -0400
In-Reply-To: <20130403154645.GV10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enigCB0B3C95A048B0EEEE3962F0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 2013-04-03 18:46, Tony Lindgren wrote:

>> Tony, I've split these patches as follows:
>>
>> Platform data header file changes:
>> git://gitorious.org/linux-omap-dss2/linux.git 3.10/0-dss-headers
>>
>> Board file changes (based on header changes):
>> git://gitorious.org/linux-omap-dss2/linux.git 3.10-lo/board-cleanup
>>
>> DSS panel changes (based on header changes):
>> git://gitorious.org/linux-omap-dss2/linux.git 3.10/1-panel-cleanup
>>
>> Removing unused fields from header files (based on panel changes):
>> git://gitorious.org/linux-omap-dss2/linux.git 3.10/2-late-panel-cleanu=
p
>>
>> The 2-late-panel-cleanup breaks compilation if the arch changes are no=
t
>> merged, so I'll leave that until they have been merged.
>>
>> Do you mind if I add the board-cleanup branch temporarily to omapdss's=

>> for-next, to simplify testing? When everything looks ok, I'll remove i=
t
>> and pass the branch to you to be handled through l-o.
>=20
> Sure please go ahead. There are still some board-*.c related patches
> that I have not merged, but we'll see those merge conflicts before
> next as I usually do a merge with next before sending out pull reqs.

The code seems to work ok, so I think we can declare the branches
stable. I've pushed new for-next branch that does not contain the arch
files anymore. In fact, I removed all omapdss patches also, as omapdss
should be merged through the drm tree, and I don't want to have
conflicts with drm's for-next branch.

So, to recap, the common header changes are located in:

git://gitorious.org/linux-omap-dss2/linux.git 3.10/0-dss-headers

And the branch for linux-omap is:

git://gitorious.org/linux-omap-dss2/linux.git 3.10-lo/board-cleanup

After merging those, some displays won't start anymore until the omapdss
changes are in, but things should still compile.

 Tomi



--------------enigCB0B3C95A048B0EEEE3962F0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRa8iXAAoJEPo9qoy8lh71ra4P/AuXzv1x9ITZe42OYdj8qdLF
vfmgKn6NTPJtdATAcL9iyqakyUpm4pEalWw4XF71COV4Q246g0FbsNpkT3SwGBJG
bTqoC1UTdWMRTqejAbZPuG+Bu9+QeB+oktiR3KDjc8SrkNmUzCiawky9whx2/GN+
Ex6+sm6ksL33nufu54OOItZah/YdJTaPaBr9d65j39a15ptEL3I5VsL0YFWb24aA
sryrN2nxaWJXR09ZfdnpWuagU71ULQduqLI1VIzBNjpxrv75xwBrJYjb+GJMpmBI
hV+HC4wFehQsk6UbmTQTOE5RalgUg8NQjWCI7pwEem1N1VBOHKivrFGrgmtWrZ8e
XIGDBeAl8FT452yZHGWSXDHe9Xa8Wfcs92pg5Btw+gqCvoW3gkqG3hkLBFzVN6BI
cPYBSG13jW21db+fSPpZ256L86B4PGSpaP+Hw0cTtXqz8z5PJRNCPesYPP9PR4WK
nMz/NHxdOQqF80UIa2txZ8AwV+FqsBgJ9N3r/0foOmXSud0OgVTaxsbxmRwqj8aX
Q6670Yu5Q2yCv/vhRini4VSuCgURAH5i6OXOK/jZLNk4uxVgdfiFizJn0+4Z52dB
fGkruC4ZgIij6fcc5MI0HbNofMyB5BpvX3OsFVaeGJBMCNDa6yM/FejgDEQr6Uy1
azFxrQPCUJBvKkj0aIza
=aaOH
-----END PGP SIGNATURE-----

--------------enigCB0B3C95A048B0EEEE3962F0--
