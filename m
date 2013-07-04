From: Mark Brown <broonie@kernel.org>
Subject: Re: Query on Audio DMA using DMAEngine
Date: Thu, 4 Jul 2013 11:49:28 +0100
Message-ID: <20130704104928.GV27646@sirena.org.uk>
References: <51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl>
 <51D24A01.2050709@ti.com> <51D26A18.8040903@topic.nl>
 <20130702121345.GL27646@sirena.org.uk>
 <51D3EA42.3040205@metafoo.de>
 <20130703094307.GE27646@sirena.org.uk> <51D46598.6070005@ti.com>
 <20130703181226.GY27646@sirena.org.uk> <51D50E89.5090503@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8222121650864099068=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <51D50E89.5090503@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Joel Fernandes <joelf@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============8222121650864099068==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wndbo1Ahui+0IyF1"
Content-Disposition: inline


--Wndbo1Ahui+0IyF1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 04, 2013 at 07:56:25AM +0200, Mike Looijmans wrote:
> On 07/03/2013 08:12 PM, Mark Brown wrote:

> >This is an application issue not a driver issue.  An application that
> >wants low latency may need high resolution information about what
> >exactly the hardware is doing.

> To get low-latency, the best thing from userspace is to mmap the
> audio buffer, and monitor the position of the DMA transfers. If the
> driver reports the DMA position accurately, you can get latencies of
> only a few samples. I must admit that I know next to nothing about
> how ALSA works in userspace, but that's how DirectSound works, for
> example. And from what I've seen, this is also possible with ALSA.

There are often hardware limitations that mean that it is not possible
to know the actual position of the DMA with anything less than period
accuracy - either the hardware just doesn't report the current status
during a transfer or it reports something that's not quite what's needed
to usefully interact with it.  The former is depressingly common.  The
APIs can support peering at the current position but it's not something
that a portable application should be relying on.

> Even without that - I tried with small periods of only 40 samples,
> this invariably fails on the current driver, with or without the
> ping-ping. Using the cyclic DMA I had no problem using such small
> periods.

The period size is generally orthogonal to decisions about using cyclic
DMA.

--Wndbo1Ahui+0IyF1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1VM1AAoJELSic+t+oim9iQIP+wYzRVsu+xlcU7oN3lgWw/Lc
lu8GpU+0G4J02tVOyCqcYyXkvc6P3hx56oTNN6Aba1aM8FknG1Pg2Nuqya4Hv6OD
IusKMnuT/eCj0YmzG3Hd/tCYNZwowSLk4YBSa3R6eAJk3uCplJqyI2zV2yKWGhtE
4JFcL9FNbdIc2bR8B4ORMzZmDV54QreSxdHBzxO94JUPanfsm9MUD3vCZwyzdHEy
KINuu2KFyzygvAnPpzXt7doxvB2e3R6ASzniwepk0zjqlJusBhLcKACjuYeInOXJ
HA8rwCLM1Eh1wikJtBa1WCtLL1xAECXDOS6DAVBIglkjovLh+JPwwADPsna61WMk
+rvpnn5qhoWJnMb1R0hkNDGfnEEZWyyrPp49c9EdEPFMNhmAfsnRCfe+CbJHD3eP
sHc+qPljtEATg9mukWRDA0T+k4OFb18KcsrHUK996ueDx1yQKX7IH+9v/Rfbs1X9
jOy16S1DZC1/rQ+yQ10QlBYiBb3X8UnPvp5R+9Mtioan/zKSSLQt67Q5+wOvVTG2
WklMCPM2aXhSeAGymX7HB/icRBpjvWs5PU+DhCDe1VmklyY9H+iQbS7a7NfwL7aL
u4AK/edg8kwpZKjjrgDEKF6099NgeEbko0c9HDCPbwq1DuQc6gi+M6n7Qxoxvv0G
CatROFynBN5G0oZx0tPv
=pNVz
-----END PGP SIGNATURE-----

--Wndbo1Ahui+0IyF1--

--===============8222121650864099068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8222121650864099068==--
