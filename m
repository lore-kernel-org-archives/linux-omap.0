From: "Govindarajan, Sriramakrishnan" <srk@ti.com>
Subject: RE: [PATCHv2 0/3] Add support for TCA6416 based Keypad driver.
Date: Fri, 12 Mar 2010 17:12:45 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087030445C4A7@dbde02.ent.ti.com>
References: <1268385499-7075-1-git-send-email-srk@ti.com>
 <6ed0b2681003120323r2a1b72a9m344d71431ebcd7c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <6ed0b2681003120323r2a1b72a9m344d71431ebcd7c4@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Grazvydas Ignotas [mailto:notasas@gmail.com]
> Sent: Friday, March 12, 2010 4:54 PM
> To: Govindarajan, Sriramakrishnan
> Cc: linux-omap@vger.kernel.org; linux-input@vger.kernel.org
> Subject: Re: [PATCHv2 0/3] Add support for TCA6416 based Keypad drive=
r.
>=20
> On Fri, Mar 12, 2010 at 11:18 AM, Sriramakrishnan <srk@ti.com> wrote:
> > AM3517 EVM with APPS board includes keys interfaced to TCA6416 IO
> expander
> > User keys are connected as GPIO lines to TCA6416 IO expander. Unlik=
e the
> > case with generic gpio-keypad driver individual keys do not generat=
e an
> > interrupt event. Hence we implement a simple keypad driver, that
> > registers as direct I2C client.
> >
> > The implementation has been tested on AM3517 EVM with the driver te=
sted
> > in polling mode.
> >
> > Version2 of the patch series addresses review comments from the ear=
lier
> > posting - specifically redesigned to eliminate overhead of using
> gpio_keys
> > data structures.
> >
> > Sriramakrishnan (3):
> > =A0TCA6416 keypad : Implement keypad driver for keys interfaced to
> > =A0 =A0TCA6416
> > =A0AM3517: Board hookup for TCA6416 keypad driver.
> > =A0AM3517 EVM : Enable TCA6416 keypad.
> >
> > =A0arch/arm/configs/am3517_evm_defconfig =A0 | =A0 16 ++-
> > =A0arch/arm/mach-omap2/board-am3517evm.c =A0 | =A0 47 ++++-
> > =A0drivers/input/keyboard/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 16 ++
> > =A0drivers/input/keyboard/Makefile =A0 =A0 =A0 =A0 | =A0 =A01 +
> > =A0drivers/input/keyboard/tca6416-keypad.c | =A0354
> +++++++++++++++++++++++++++++++
> > =A0include/linux/tca6416_keypad.h =A0 =A0 =A0 =A0 =A0| =A0 34 +++
> > =A06 files changed, 462 insertions(+), 6 deletions(-)
> > =A0mode change 100644 =3D> 100755 arch/arm/mach-omap2/board-am3517e=
vm.c
> > =A0create mode 100755 drivers/input/keyboard/tca6416-keypad.c
> > =A0create mode 100755 include/linux/tca6416_keypad.h
>=20
> Please fix mode - remove +x flags.
[Sriram] Thanks for pointing out. I will await further review comments
And post the updated version thereafter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
