From: Khem Raj <kraj@mvista.com>
Subject: Re: [PATCH 01/14] MMC: OMAP: Introduce new structs for mmc multislot
 support
Date: Wed, 31 Oct 2007 00:17:53 -0700
Message-ID: <47282C21.20604@mvista.com>
References: <46F28BA8.9060409@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46F28BA8.9060409@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Carlos Aguiar wrote:

> +
> +	mmc->caps = MMC_CAP_BYTEBLOCK | MMC_CAP_MULTIWRITE |
> +		    MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;


MMC_CAP_BYTEBLOCK is new define which is used here but not defined.
Probably it should be defined in ./include/linux/mmc/host.h  ? or is it
in one of remaining patches.

- -Khem
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHKCwhUjbQJxVzeZQRAgnbAJ47j0l/SltOksJ4N5Vnx0carF227wCff/WC
Z5LkVb5Pgw92K7csJw9yIC8=
=PnlW
-----END PGP SIGNATURE-----
