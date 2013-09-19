From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 01/11] ASoC: davinci-evm: Move sysclk
 logic away from evm_hw_params
Date: Thu, 19 Sep 2013 14:23:16 +0100
Message-ID: <20130919132316.GR21013@sirena.org.uk>
References: <cover.1379590035.git.jsarha@ti.com>
 <dad0f7eb787d3f65848425a67d668e3935033195.1379590036.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3374363470222491925=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <dad0f7eb787d3f65848425a67d668e3935033195.1379590036.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, joelf@ti.com, rob.herring@calxeda.com, peter.ujfalusi@ti.com, grant.likely@linaro.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============3374363470222491925==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xYza636WGbju2Spp"
Content-Disposition: inline


--xYza636WGbju2Spp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2013 at 02:29:34PM +0300, Jyri Sarha wrote:
> The sysclk rate does not change runtime so it should be initialized at
> init time.

Are there any updates from the version already applied (I only dropped
the patch to allow the extra builds, not this one).

--xYza636WGbju2Spp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOvrBAAoJELSic+t+oim9sIMP/1OJJWxWj23iC6/R2mNmQTEP
pYjTan2t7VHKehEzpyyjZKUFVTHf1TzEZxcScymv5IO5nHl1BF3dqTA9vDy0TdIL
1lG0X/OmKAESMdI2JoWv9mW8I8tpsF++CwmNxd41Ww7+6c3/BJFt1YUD26PQE+BM
cWsymodjDjiVdB73GqsalsRCPCh8O5ngqPZDRlKF5PcgQtLn19CyFGttlVtF6yA5
Yh4G+tIsZwAAUPxnE2NM3WS3Pomu/FM07slPh+CtPDO+DfwqdXwx21XVa4p5SVvd
ec3M8QTa3jpmuE4WPg9sSKXbT+VEbONRxlbpN9ot6iouMpvFnIQYsDhwdyltoY22
7fnpGgIC8Eo1uli4VmXhMhTDPuGbVkWgpHgVGMa2zUX3cfJsmVESJA0MVk8pM7tW
+uualifrXN6MPemltbl2Gxub4qctYcj4i2XVvVvKX952NxSkRKbs7r+zxhdOAcT1
+qxO+am9ng2n/LLpmaMwp1VmXAlkoDAbtyfr2P2zcRc3wCrBZNxdNAhBk66TBCFo
pSJklnjDBLmal1N1FiUnSO6nceZwJ5RbP3SOeS/zvys9of8WzYoSslQ3EG3wKI9q
RqXyWfqE2Ku5HMJ+X6MPwyYwKvpIMf2a824LK17VEvfJZvoKS+LbgmYu+Bs5FmHp
VBzT4FJ7QDOLTq5ife1v
=cwIE
-----END PGP SIGNATURE-----

--xYza636WGbju2Spp--

--===============3374363470222491925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3374363470222491925==--
