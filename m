From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: [PATCH V3 00/10] PM: Create the AVS(Adaptive Voltage
	Scaling)
Date: Tue, 8 May 2012 20:38:35 +0000
Message-ID: <EF62F09C0797D947AD4180A1043C0DF73C40BCE1@DLEE10.ent.ti.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
	<20120426191159.GA9415@sirena.org.uk>
	<CAJ6a13a6WN9h1QZynpEOf-R6RXwWBZ2eOPkTeNc15JX_YfAz_w@mail.gmail.com>
	<20120427175657.GP18260@opensource.wolfsonmicro.com>	<87397o3n4y.fsf@ti.com>
	<331ABD5ECB02734CA317220B2BBEABC13E9B1A67@DBDE01.ent.ti.com>
	<87mx5jy2li.fsf@ti.com>
	<331ABD5ECB02734CA317220B2BBEABC13E9B6681@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13E9B6681@DBDE01.ent.ti.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>, "Hilman, Kevin" <khilman@ti.com>
Cc: "J, KEERTHY" <j-keerthy@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pihet-XID, Jean" <j-pihet@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


> > >> The only thing the higher-level layers might potentially need to do
> > >> is to enable/disable AVS around transitions (e.g. when changing OPP, > > >> AVS is disabled before changing OPP and only re-enabled when the new > >> >> nominal voltage has been acheived.)

Getting clean baseline in place is huge step but actual production interfaces will need to comprehend some OPP to AVS dependencies beyond on/off.

AVS as used in many OMAP designs (mostly > OMAP4430) do have some per OPP dependent details:

- Multiple PMICs are in use. In some current designs the AVS step size is different per voltage range. At OPP change time you have to reconfigure several AVS parameters before enable.

- ABB-ldo sequencing and parameters in tightly coupled with OPP and AVS enables.

- Good power savings can be had in future 1.5/3.5 by adjusting nominal to calibrated-plus-margin voltage.

Regards,
Richard W.
