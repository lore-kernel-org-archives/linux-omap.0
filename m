From: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: [RFC 1/2] MMC/SD Controller driver for OMAP2430
Date: Wed, 1 Aug 2007 14:52:22 +0200
Message-ID: <20070801145222.245112f6@poseidon.drzeus.cx>
References: <9C23CDD79DA20A479D4615857B2E2C47016A3480@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0074782497=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47016A3480@dlee13.ent.ti.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Mime-version: 1.0
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============0074782497==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1;
	boundary="=_hera.drzeus.cx-8522-1185972747-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-8522-1185972747-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Jul 2007 19:17:06 -0500
"Syed Mohammed, Khasim" <x0khasim@ti.com> wrote:

> Hello:
>=20
> I am hereby presenting MMC/SD controller driver for OMAP 2430. It has
> been validated for SD/MMC (3v) cards on 2430 (ES 2.1) SDP V4.0.
>=20

I agree with everything Russell pointed out. I also have some more
concerns:

> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/sd.h>

Including these two is a definite sign you've done some layering
violation somewhere.

> +
> +	switch (mmc_resp_type(cmd)) {
> +	case MMC_RSP_R1:
> +	case MMC_RSP_R3:
> +	case MMC_RSP_R1B:
> +		/* resp 1, 1b, 3 */
> +		resptype =3D 2;
> +		break;
> +	case MMC_RSP_R2:
> +		resptype =3D 1;
> +		break;
> +	default:
> +		break;
> +	}
> +

This looks broken. It would seem like what you really are interested in
is if the response is a long or short response. So test for that
instead of that redundant list.

> +	cmdreg =3D (cmd->opcode << 24) | (resptype << 16) | (cmdtype
> << 22);

You never compute cmdtype.

> +	OMAP_HSMMC_WRITE(host->base, HCTL,
> +			OMAP_HSMMC_READ(host->base,HCTL) &
> ~FOUR_BIT); +
> +	if (host->mmc->ios.bus_width =3D=3D MMC_BUS_WIDTH_4)
> +		OMAP_HSMMC_WRITE(host->base, HCTL,
> +				OMAP_HSMMC_READ(host->base, HCTL)
> +						| FOUR_BIT);
> +	else if (host->mmc->ios.bus_width =3D=3D MMC_BUS_WIDTH_1)
> +		OMAP_HSMMC_WRITE(host->base, HCTL,
> +				OMAP_HSMMC_READ(host->base, HCTL)
> +						& ~FOUR_BIT);
> +

Why are you poking this on every request, instead of in the ios
function?

> +	if (cmd->opcode =3D=3D MMC_READ_SINGLE_BLOCK ||
> +			cmd->opcode =3D=3D MMC_READ_MULTIPLE_BLOCK ||
> +			cmd->opcode =3D=3D SD_APP_SEND_SCR	||
> +			((cmd->opcode =3D=3D MMC_SEND_EXT_CSD) &&
> cmd->arg =3D=3D 0))
> +		cmdreg |=3D DP_SELECT | DDIR | MSBS | BCE;
> +
> +	else if (cmd->opcode =3D=3D MMC_WRITE_BLOCK ||
> +			cmd->opcode =3D=3D MMC_WRITE_MULTIPLE_BLOCK) {
> +		cmdreg |=3D DP_SELECT | MSBS | BCE;
> +		cmdreg &=3D ~(DDIR);
> +	}
> +
> +	if (host->use_dma)
> +		cmdreg |=3D DMA_EN;
> +
> +	if (cmd->opcode =3D=3D MMC_GO_IDLE_STATE || cmd->opcode =3D=3D
> MMC_SEND_OP_COND
> +		|| cmd->opcode =3D=3D MMC_ALL_SEND_CID)
> +		OMAP_HSMMC_WRITE(host->base, CON,
> +				OMAP_HSMMC_READ(host->base, CON) |
> OD); +
> +	if (cmd->opcode =3D=3D MMC_GO_IDLE_STATE)
> +		if (host->initstr =3D=3D 0) {
> +			send_init_stream(host);
> +			host->initstr =3D 1;
> +		}
> +

Stop doing things based on opcode. Look at relevant attributes.

> +	if (host->data =3D=3D NULL || cmd->error !=3D MMC_ERR_NONE) {
> +		dev_dbg(mmc_dev(host->mmc), "%s: End request, err
> %x\n",
> +				mmc_hostname(host->mmc), cmd->error);
> +		host->mrq =3D NULL;
> +		mmc_request_done(host->mmc, cmd->mrq);
> +	}

Isn't the debug output of the core sufficient? Same thing goes for
several other dev_dbg() in your code.

> +
> +	if (status & (ERR)) {
> +		if (status & (CMD_TIMEOUT) ||
> +			status & (CMD_CRC)) {
> +			if (host->cmd) {
> +				if (status & (CMD_TIMEOUT))
> +					host->cmd->error |=3D
> MMC_ERR_TIMEOUT;
> +				else
> +					host->cmd->error |=3D
> MMC_ERR_BADCRC;
> +				end_cmd =3D 1;
> +			}

"error" is still not a bitfield? This has been pointed out before, and
omap.c currently upstream is still broken.

> +
> +	omap_set_dma_transfer_params(dma_ch, OMAP_DMA_DATA_TYPE_S32,
> +		(data->blksz / 4), data->blocks, OMAP_DMA_SYNC_FRAME,
> +							sync_dev,
> sync_dir);

How do you handle data->blksz % 4 !=3D 0 ?

> +
> +	if (mmc_omap_prepare_data(host, req))
> +		dev_dbg(mmc_dev(host->mmc),
> +			"MMC host %s failed to initiate data
> transfer\n",
> +			mmc_hostname(host->mmc));

Why aren't you failing the request in this case?

> +
> +	if (host->id =3D=3D OMAP_MMC1_DEVID) {
> +		if ((OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET) &&
> +				((ios->vdd =3D=3D 7) || (ios->vdd =3D=3D
> 8))) {

Please use the defines. I know the bit-shifting thing is a bit messy,
but this code will break horribly if we need to change the system.

> +
> +static struct mmc_host_ops mmc_omap_ops =3D {
> +	.request =3D omap_mmc_request,
> +	.set_ios =3D omap_mmc_set_ios,
> +};
> +

No support for read-only switch?

> +	mmc->caps |=3D MMC_CAP_MULTIWRITE | MMC_CAP_BYTEBLOCK;

I don't see you properly updating bytes_xfered in case of failure, so
MULTIWRITE seems wrong.

Also, BYTEBLOCK also seems wrong (see earlier comment).

Third, to use a frequency above 25 MHz, you need to set the appropriate
high-speed capabilities. And don't just go setting them willy-nilly
(testing is rarely conclusive for this as many cards are rather
forgiving). The hardware needs to be designed for the relevant timings.

> +
> +#ifdef CONFIG_PM
> +static int omap_mmc_suspend(struct platform_device *pdev,
> pm_message_t state) +{
> +	int ret =3D 0;
> +	struct mmc_omap_host *host =3D platform_get_drvdata(pdev);
> +
> +	if (host && host->suspended)
> +		return 0;
> +
> +	if (host) {
> +		ret =3D mmc_suspend_host(host->mmc, state);
> +		if (ret =3D=3D 0) {
> +			host->suspended =3D 1;
> +
> +		OMAP_HSMMC_WRITE(host->base, ISE, 0);
> +		OMAP_HSMMC_WRITE(host->base, IE, 0);
> +

Broken indentation.

> +
> +		/* Notify the core to resume the host */
> +		ret =3D mmc_resume_host(host->mmc);
> +		if (ret =3D=3D 0)
> +			host->suspended =3D 0;
> +		msleep_interruptible(1);

What's the point of this sleep? The MMC core can start issuing stuff
before mmc_resume_host() returns, and _interruptable means your sleep
might return instantly.

Rgds
Pierre

--=_hera.drzeus.cx-8522-1185972747-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGsIIH7b8eESbyJLgRAgPvAKCpd3wTwAvtg0LS0+CmSMtx4rvrkwCg0GaB
4Xa4LI85KKCaua/GM3qsviE=
=F5t5
-----END PGP SIGNATURE-----

--=_hera.drzeus.cx-8522-1185972747-0001-2--


--===============0074782497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
--===============0074782497==--
