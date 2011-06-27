From: Jaswinder Singh <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] OMAP4: PANDA, SDP: Fix EHCI regulator supply
Date: Mon, 27 Jun 2011 13:38:54 +0530
Message-ID: <BANLkTinVdWjoS-qdGnSxGnmrPKHSDNV7hw@mail.gmail.com>
References: <1308926240-13888-1-git-send-email-jaswinder.singh@linaro.org>
	<BANLkTin=-cRC_ax8AakMD1UZtU+AQ0H==w@mail.gmail.com>
	<20110627080036.GB2508@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110627080036.GB2508@legolas.emea.dhcp.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: patches@linaro.org, tony@atomide.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On 27 June 2011 13:30, Felipe Balbi <balbi@ti.com> wrote:

>> >
>> > +static struct regulator_consumer_supply sdp4430_vusb_supply =3D
>> > + =A0 =A0 =A0 REGULATOR_SUPPLY("hsusb0", "ehci-omap.0");
>
> this should be an array.
Ok, I can make it an array of _one_ element.
Though I am not sure why is that a good thing, or are we to use another
possible VUSB supply on Panda/SDP boards ?  Please suggest so that
I can add that too.

>> > =A0static struct regulator_init_data sdp4430_vusb =3D {
>> > =A0 =A0 =A0 =A0.constraints =3D {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 3300000,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 3300000,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .apply_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D true,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_modes_mask =A0 =A0 =A0 =3D REGUL=
ATOR_MODE_NORMAL
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| REGULATOR_MODE_STANDBY,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.valid_ops_mask =A0=3D =A0 =A0 =A0REGUL=
ATOR_CHANGE_MODE
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| REGULATOR_CHANGE_STATUS,
>> > =A0 =A0 =A0 =A0},
>> > + =A0 =A0 =A0 .num_consumer_supplies =A0=3D 1,
>
> ARRAY_SIZE()
Yes, of course if we are to switch to single-element array.

Thanks,
Jassi
