From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 07/13] OMAPDSS: HDMI: Add a get_timing function for
 HDMI interface
Date: Tue, 14 Aug 2012 16:02:28 +0300
Message-ID: <1344949348.4845.46.camel@lappyti>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
	 <1344512989-4071-1-git-send-email-archit@ti.com>
	 <1344512989-4071-8-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-zzZWEabsRIeQGa2fTdkt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:36243 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755359Ab2HNNCg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Aug 2012 09:02:36 -0400
Received: by lbon10 with SMTP id n10so212032lbo.11
        for <linux-omap@vger.kernel.org>; Tue, 14 Aug 2012 06:02:31 -0700 (PDT)
In-Reply-To: <1344512989-4071-8-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org


--=-zzZWEabsRIeQGa2fTdkt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2012-08-09 at 17:19 +0530, Archit Taneja wrote:
> Add function omapdss_hdmi_display_get_timing() which returns the timings
> maintained by the HDMI interface driver in it's hdmi_config field. This
> prevents the need for the panel driver to configure default timings in it=
's
> probe.
>=20
> This function is just intended to be used once during the panel driver's =
probe.
> It makes sense for those interfaces which can be configured to a default =
timing.

I'm not sure about this patch. So I think the basic idea here is that
HDMI will use VGA video mode if, for whatever reason, no better mode is
found out.

After this change, the panel driver doesn't seem to do that. Instead it
uses whatever mode was used previously by the hdmi output driver.

Is the only reason for this patch to clean up the hdmi_panel driver? We
could have a dss helper function which returns the timings for VGA
(well, just a public const variable would be enough), and the panel
driver could use that to initialize the timings struct.

 Tomi


--=-zzZWEabsRIeQGa2fTdkt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQKkxkAAoJEPo9qoy8lh71khcP/j12s1dA6ZjQp9icWvEhJCN6
8nWr4oZ+gatqMTqNUK5HPavRh5ndzvzde3GdK99j/9b8aiPVbFTctOezGoWxbyW1
u/HWdoDBgS+WYKBM2J9RpdJ1sSxibJ7suVN7SKHa59TtgM3nT5mj5roAoEsgk96e
8bpitdFfHkiNyPAtV4uH1m908+Pz53fLOXdyv+jKs4UPcW3FCgkLbW/2G/wn1dvg
pgNAhXfdtXsc1+I36bOxG7nFGbXBdNKILrGeQhOUVQ4SA53fpG2Rn3qu9WuJekh9
9b0j+OdL4KbcV4JRcAdGY02yBf1TG1mfsOdBXZAdDt7lrZF8t6cFDJEUEgZyJ+5l
nDD0djvc2yOfjb93Db/cMFdvxybNtVqwYLgYFxxJcKe0fCoKVGyfVgov6dNwqCW+
CcLlxLewWRwOc1eVEi3i2r8J73cMFOdZ5tj/glv46vDcdYJcixE5+f3l2KKNwmye
fVXcAcCPf5bF/W1/sycAjWLK7mloZvfa5he7lrumKNcNgHJxZXjUrssJP0c/Pj3l
Lkefw2E+xQZouWoVYHlAPUiyymI0RP/4lY0qB18Bk9gLlONlQHl5AmhT9ccJlGsu
H6hKXqlFtGR28+kjN9d3yc5rMiqLDe/VWdfuT4jHx+E+Iu/h1qM0v9JgFNnC6mVp
A9Ml7nFWWhKv20cnwWL4
=MeHT
-----END PGP SIGNATURE-----

--=-zzZWEabsRIeQGa2fTdkt--

