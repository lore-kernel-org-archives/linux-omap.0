From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: OMAP2430sdp MMC driver for 2.6.21
Date: Mon, 23 Jul 2007 23:11:56 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470163A9F2@dlee13.ent.ti.com>
References: <80f873930707231901k540f1c31o299a90cf007e8d64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <80f873930707231901k540f1c31o299a90cf007e8d64@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: sree <sreesamb@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


>and I have to clean the driver and also I am having problem with the =
card
>insertion and removal with the IRQ handling
>the kernel crashes whenever I remove the card or Insert the card.I am
>digging the problem
>As soon as I do that I will get back again
>
This is because of INIT_WORK in mmc driver,

In MMC detect function or where ever you are referring to schedule work =
use container_of, also note the parameter has changed to work_struct.

static void mmc_omap_detect(struct work_struct *work)
{
        u16 vdd =3D 0;
        struct mmc_omap_host *host =3D container_of(work, struct 								=
mmc_omap_host, mmc_carddetect_work);


Otherwise you will be referring to wrong base address and so the crash.

Hope this helps.

Regards,
Khasim
