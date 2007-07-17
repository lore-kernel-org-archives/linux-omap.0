From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: I2C not working in uboot
Date: Tue, 17 Jul 2007 10:47:00 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D9130274290170DEE3@dlee13.ent.ti.com>
References: <c656a4d20707170409g6f9b294eyec6f9f798c9b25d3@mail.gmail.com><3B6D69C3A9EBCA4BA5DA60D9130274290170DCCC@dlee13.ent.ti.com>
	<c656a4d20707170824r68b3adc4y85f42eb8f94bbd39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <c656a4d20707170824r68b3adc4y85f42eb8f94bbd39@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: arun c <arun.edarath@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Arun,

I just tried on my 243x on an SDP and I have no problem reading/writing =
to either bus.

The bit of configuration you showed below seems fine.  Now there are =
several other spots which may be mis-configured or some hardware issue =
could exist which is stopping you.

I suggest you try the same experiment you are doing on your custom board =
on the SDP2430.  It might be you just need to unlock or enable the T2 =
register set you are interested in before you can write to it.  Some T2 =
internal registers need a key sequence before to allow changes to them.  =
A test on the SDP should resolve this aspect quickly.

Below is some example usage on my 2430SDP.

OMAP243X SDP # imm 49 b9
000000b9: 00 ?
000000ba: ff ?
000000bb: ff ?
000000bc: 03 ?
000000bd: 00 ?
000000be: 00 ?
000000bf: 00 ?
000000c0: 00 ?
000000c1: 00 ?
000000c2: 00 ? .
OMAP243X SDP # imd 49 b9
00b9: 00 ff ff 03 00 00 00 00 00 00 00 00 01 00 00 00    =
................

OMAP243X SDP # help ibus
ibus bus_index speed
    - Selects the bus index and sets the speed =
(0x64(ST),0x190(FS),0xD48(HS))
      (reports success/failure)

OMAP243X SDP # ibus 1 64
Setting bus[1] to Speed[100]: PASS
OMAP243X SDP # iprobe
Valid chip addresses: 48 49 4A 4B
OMAP243X SDP # ibus 0 64
Setting bus[0] to Speed[100]: PASS
OMAP243X SDP # iprobe
Valid chip addresses: 2D
OMAP243X SDP # ibus 1 64
Setting bus[1] to Speed[100]: PASS
OMAP243X SDP #

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com =
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of arun c
> Sent: Tuesday, July 17, 2007 10:24 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: Re: I2C not working in uboot
>=20
> Hi all,
>=20
> Thanks Woodruff for the reply.
> I am able to probe the 4 I2C chips on T2 using iprobe.
> The iprobe is giving me output 48,49,4a,4b.(4 chip addresses)
>=20
> I am able to use the command "imm" and modify the registers(RW).
> But while reading back i am getting only zeros, not the values
> I have written.
>=20
> As i understand oamp2430 is having 2 I2C buses.My I2C device
> is on bus 2.I think that i am not configuring the second I2C bus.
>=20
> The following uboot settings are only for I2C bus 1???
>=20
> #define CFG_I2C_SPEED          100
> #define CFG_I2C_SLAVE          1
> #define CFG_I2C_BUS            0
> #define CFG_I2C_BUS_SELECT     1
> #define CONFIG_DRIVER_OMAP24XX_I2C 1
>=20
> Do i need to configure the second I2C as the same way as given
> above???
>=20
> Best regards
> Arun
>=20
>=20
>=20
>=20
>=20
>=20
> On 7/17/07, Woodruff, Richard <r-woodruff2@ti.com> wrote:
> > > Please somebody tell me the correct way use the
> > > I2C bus for checking the keypad in uboot.
> >
> > - I'll assume you used the u-boot snapshot from the TI download site =
for
> 2430.
> >
> > - I've used the i2c commands in the past with out issues for =
24xx/343x
> targets.  I've not tried this is a while on 24xx but it worked last =
time I
> tried.
> >
> > - T2 shows up as 4 separate i2c chips.  Below is an example =
accessing
> into it.  You should be able to go look at the revision register and
> others.
> >
> > - Below is an example writing to the power section to select a high
> voltage level.  The example was part of some over clocking tests which
> required a higher voltage.
> >
> > OMAP34XX SDP # imm 4b b9
> > 000000b9: 30 ?
> > 000000ba: 00 ?
> > 000000bb: 00 ? 43
> > 000000bc: 00 ? 43
> > 000000bd: 00 ? .
> > OMAP34XX SDP # imm 4b b9
> > 000000b9: 30 ?
> > 000000ba: 00 ? 3
> > 000000bb: 43 ? .
> >
> > Regards,
> > Richard W.
> >
> >
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
