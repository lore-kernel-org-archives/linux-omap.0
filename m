From: "Patel, Satish" <satish.patel@ti.com>
Subject: RE: [PATCH v9 0/8] Generic PHY Framework
Date: Tue, 9 Jul 2013 12:33:58 +0000
Message-ID: <780E789C2E067A4BB8F69D0BB9EC4F253E97670D@DBDE04.ent.ti.com>
References: <1372247257-30186-1-git-send-email-kishon@ti.com>
 <780E789C2E067A4BB8F69D0BB9EC4F253E975B5E@DBDE04.ent.ti.com>
 <51D3F773.9000209@ti.com> <20130703132038.GI15056@arwen.pp.htv.fi>
 <780E789C2E067A4BB8F69D0BB9EC4F253E975D6E@DBDE04.ent.ti.com>
 <51D54694.20203@ti.com> <20130704101216.GD4830@arwen.pp.htv.fi>
 <780E789C2E067A4BB8F69D0BB9EC4F253E9764D5@DBDE04.ent.ti.com>
 <51DAADD1.3060302@ti.com>
 <780E789C2E067A4BB8F69D0BB9EC4F253E976575@DBDE04.ent.ti.com>
 <20130709114416.GL5552@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130709114416.GL5552@arwen.pp.htv.fi>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "mchehab@redhat.com" <mchehab@redhat.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Mankad, Maulik Ojas" <maulik@ti.com>, "swarren@nvidia.com" <swarren@nvidia.com>, "ABRAHAM,
 KISHON VIJAY" <kishon@ti.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "cesarb@cesarb.net" <cesarb@cesarb.net>, "Cherian,
 George" <george.cherian@ti.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "Nayak, Rajendra" <rnayak@ti.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "sylvester.nawrocki@gmail.com" <sylvester.nawrocki@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> -----Original Message-----
> From: Balbi, Felipe
> Sent: Tuesday, July 09, 2013 5:14 PM
> To: Patel, Satish
> Cc: ABRAHAM, KISHON VIJAY; Balbi, Felipe; grant.likely@linaro.org;
> tony@atomide.com; arnd@arndb.de; swarren@nvidia.com;
> sylvester.nawrocki@gmail.com; linux-kernel@vger.kernel.org; linux-
> omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> usb@vger.kernel.org; gregkh@linuxfoundation.org; akpm@linux-
> foundation.org; rob.herring@calxeda.com; rob@landley.net;
> linux@arm.linux.org.uk; benoit.cousson@linaro.org; mchehab@redhat.com;
> cesarb@cesarb.net; davem@davemloft.net; Nayak, Rajendra;
> shawn.guo@linaro.org; Shilimkar, Santosh; devicetree-
> discuss@lists.ozlabs.org; linux-doc@vger.kernel.org; Nori, Sekhar;
> Krishnamoorthy, Balaji T; Cherian, George; Mankad, Maulik Ojas;
> Srinivasan, Nageswari; Sundareson, Prabindh
> Subject: Re: [PATCH v9 0/8] Generic PHY Framework
> =

> Hi,
> =

> On Tue, Jul 09, 2013 at 04:23:29AM +0200, Patel, Satish wrote:
> > > > We have two options over here
> > > >
> > > > Option 1:
> > > >
> > > > Defining generic api to which can be mapped over multiple phys
> > > > For smartcard case, I have can thought of following mapping with
> new
> > > > generic apis as suggested.
> > > >
> > > > Smartcard_poweron -> power_on
> > > > Smartcard_powerdown -> power_off
> > > > Smartcard_set_voltage -> phy_set_voltage
> > > > Smartcard_activate_card -> phy_activate_slot
> > > > Smartcard_deactivate_card -> phy_deactivate_slot
> > >
> > > how is activate/deactivate different from poweron/poweroff in this
> > > use case?
> >
> > power on/off normal power sequence. While activate/de-activate will
> be
> > called during card transaction.
> =

> why can't you implement activate/deactivate with suspend/resume ?
> =

> > Brief on how it works:
> > - when system start, execute power on for phy
> > - smartcard controller and phy is connected through i2c, clock lines
> and
> > i/o lines
> > - clock will be supplied by controller to phy to get data sync on
> i/o lines
> =

> fair enough.
> =

> > Operation:
> >
> > Once the card gets inserted into the slot, user application can
> > initiate activate sequence anytime, it is not mandatory that
> > activation has to be called Immediately. It all depends whether
> other
> > connections ( network, printer) are proper.  User application can do
> > some checks and then dynamically activate the card
> =

> The card or the phy ? Who actually activates ? Is the activation
> handling part of the PHY or part of the smartcard controller ?
> =


It=92s a activation of smart card which is inserted into the phy slot. =

Smart card activation will by done phy but initiated by user application
Handling of activation should be done at both the side - controller as well
As phy. Phy will raise certain signals and check timeout while activation
, while controller will store data coming from smart card to FIFO. Its
Controller which will give command to phy to initiate activation sequence w=
hen it
is ready. =


Which means, both controller and phy has role to play while activation.
Also it is applicable while deactivation.


> > There are 2 sequence of activation - normal activation and warm
> reset.
> > If first fails then warm reset should be executed, if card does not
> > response to both then deactivation will be carried out
> =

> ret =3D phy_resume(phy);
> if (ret =3D=3D -EINVAL) { /* perhaps there's a better error code */
> 	ret =3D phy_reset(phy);
> 	if (ret)
> 		phy_suspend(phy);
> }
>

Its not like this. There are the cases, when during normal activation card =
respond
With some characters, but they might not be valid or error prone - This che=
ck will be =

done by user application as only application knows how to decode characters=
 as per protocol.

It there is any error in characters/timeout paratmeters, user application w=
ill ask to initiate
Warm reset.
 =

> ????
> =

> > - For activation there are some timing parameters ( called ATR -
> > Answer to reset timings) Has to be set to the phy
> =

> does that change in runtime or is it something which is set during
> probe
> and never touched again ?
> =

> > - on activation card will respond with some initial characters
> (ATR),
> > which will be verified by application, in case of error user
> > application will de-activate the card not the phy module
> >
> > - After activation, use application initiate normal tx/rx
> >
> > - Once tx/rx is done, it will initiate deactivation of card not the
> > phy module.
> =

> then that has nothing to do with the PHY framework, right ?

But all such sequence will be initiated by PHY by raising certain signals
and only controller can give the push when to start.
> =

> > > > Smartcard_set_c4/c8/rst/io -> phy_set_pin
> > >
> > > Whats should be exactly done here? Looks to me like it should be
> > > part of init. Does these pin settings need to be changed
> dynamically?
> >
> > These are all phy pins which will be physically come in contact with
> > smart card When inserted. In case of synchronous card, these pins
> will
> > be toggled manually by s/w bit bang algorithm
> =

> is that a requirement or just something that everybody does ?
>

Its requirement for synchronous card. At present there is no open driver
Which does this thing.
 =

> In any case, you can hide that under some gpio calls, or something
> similar.

Can't be done using GPIO as pin can be toggled only which i2c read/write
to the phy.
> =

> > > Why? Is it like the detection of an external event? Then the PHY
> > > driver should use *extcon* for event detection and passing.
> > >
> >
> > Smartcard controller need a way to ready isr status ( like card
> presence,
> > Card inserted in to which slot, removed from which slot ) to
> maintain its
> > Internal state machine.
> =

> register an interrupt handler with devm_request_threaded_irq(), what's
> the problem ?
> =

> > > > Smartcard_get_version -> phy_get_version
> > >
> > > Again why? Why would the smartcard need the version of the PHY?
> > >
> >
> > Can be omitted. This is for the test suite reference.
> =

> if it's for testsuite, it sounds like something that should be done
> through userland and, as such, should be implemented by a set of
> debugfs
> files which expose the necessary information. That has nothing to do
> with the PHY framework.
> =

Agree.. can be omitted.


I am ok to give internal webex presentation (TI team) to brief =

on phy and smart card controller interface.


> --
> balbi
