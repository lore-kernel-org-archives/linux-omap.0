From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 00/10] staging:ti dspbridge: Remove DSP_FAILED and
	DSP_SUCCEEDED macros
Date: Fri, 30 Jul 2010 18:16:30 +0300
Message-ID: <AANLkTinhr8KhmJ9QMKeUHpPWsXuiBjZaFzHuwdrwww6=@mail.gmail.com>
References: <1280328333-31336-1-git-send-email-ernesto@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1280328333-31336-1-git-send-email-ernesto@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ernesto Ramos <ernesto@ti.com>
Cc: gregkh@suse.de, omar.ramirez@ti.com, ameya.palande@nokia.com, felipe.contreras@nokia.com, fernando.lugo@ti.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, nm@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Ernesto,

On Wed, Jul 28, 2010 at 5:45 PM, Ernesto Ramos <ernesto@ti.com> wrote:
> This series of patches is targetted to remove macros DSP_FAILED
> and DSP_SUCCEEDED since bridge driver currently uses standard kernel
> error codes.

These macros were often used to test for success, instead for errors.

This often leads to dspbridge code being highly nested, and hard to
read. The excessive indentation sometimes even lead to longer lines,
which were broken to meet the 80-chars recommendation, where the real
problem is actually the redundant indentation (e.g. check out this
patch http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26700.h=
tml).

E.g. the following error testing is very common in the bridge code:

do_something1();
if (success) {
    do_something2();
    if (success) {
        do_something3();
        ....
    }
}

The kernel alternative would be to check for errors, and take error
paths out of the code flow, e.g.:

do_something1();
if (error)
    leave;

do_something2();
if (error)
    leave;

do_something3();
if (error)
    leave;

This leads to code which is much more easier to read.

If you could hunt some of those highly nested areas and make them test
for error instead of success, it can be really great.

Thanks,
Ohad.

>
> Ernesto Ramos (10):
> =A0staging:ti dspbridge: remove DSP_SUCCEEDED macro from core
> =A0staging:ti dspbridge: remove DSP_SUCCEEDED macro from pmgr
> =A0staging:ti dspbridge: remove DSP_SUCCEEDED macro from rmgr
> =A0staging:ti dspbridge: remove DSP_SUCCEEDED macro from services
> =A0staging:ti dspbridge: remove DSP_SUCCEEDED macro definition
> =A0staging:ti dspbridge: remove DSP_FAILED macro from core
> =A0staging:ti dspbridge: remove DSP_FAILED macro from pmgr
> =A0staging:ti dspbridge: remove DSP_FAILED macro from rmgr
> =A0staging:ti dspbridge: remove DSP_FAILED macro from services
> =A0staging:ti dspbridge: remove DSP_FAILED macro definition
>
> =A0drivers/staging/tidspbridge/core/chnl_sm.c =A0 =A0 =A0 =A0 | =A0 4=
2 ++--
> =A0drivers/staging/tidspbridge/core/dsp-clock.c =A0 =A0 =A0 | =A0 =A0=
4 +-
> =A0drivers/staging/tidspbridge/core/io_sm.c =A0 =A0 =A0 =A0 =A0 | =A0=
111 +++++-----
> =A0drivers/staging/tidspbridge/core/msg_sm.c =A0 =A0 =A0 =A0 =A0| =A0=
 26 ++--
> =A0drivers/staging/tidspbridge/core/tiomap3430.c =A0 =A0 =A0| =A0 61 =
+++---
> =A0drivers/staging/tidspbridge/core/tiomap3430_pwr.c =A0| =A0 =A08 +-
> =A0drivers/staging/tidspbridge/core/tiomap_io.c =A0 =A0 =A0 | =A0 41 =
++--
> =A0.../staging/tidspbridge/include/dspbridge/dbdefs.h | =A0 =A04 -
> =A0drivers/staging/tidspbridge/pmgr/chnl.c =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 10 +-
> =A0drivers/staging/tidspbridge/pmgr/cmm.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
137 ++++++-------
> =A0drivers/staging/tidspbridge/pmgr/cod.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 18 +-
> =A0drivers/staging/tidspbridge/pmgr/dbll.c =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 32 ++--
> =A0drivers/staging/tidspbridge/pmgr/dev.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 79 +++----
> =A0drivers/staging/tidspbridge/pmgr/dmm.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 12 +-
> =A0drivers/staging/tidspbridge/pmgr/dspapi.c =A0 =A0 =A0 =A0 =A0| =A0=
 82 ++++----
> =A0drivers/staging/tidspbridge/pmgr/io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A04 +-
> =A0drivers/staging/tidspbridge/pmgr/msg.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +-
> =A0drivers/staging/tidspbridge/rmgr/dbdcd.c =A0 =A0 =A0 =A0 =A0 | =A0=
 48 ++--
> =A0drivers/staging/tidspbridge/rmgr/disp.c =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 62 +++---
> =A0drivers/staging/tidspbridge/rmgr/drv.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 39 ++--
> =A0drivers/staging/tidspbridge/rmgr/drv_interface.c =A0 | =A0 10 +-
> =A0drivers/staging/tidspbridge/rmgr/dspdrv.c =A0 =A0 =A0 =A0 =A0| =A0=
 16 +-
> =A0drivers/staging/tidspbridge/rmgr/mgr.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 32 ++--
> =A0drivers/staging/tidspbridge/rmgr/nldr.c =A0 =A0 =A0 =A0 =A0 =A0| =A0=
106 +++++-----
> =A0drivers/staging/tidspbridge/rmgr/node.c =A0 =A0 =A0 =A0 =A0 =A0| =A0=
224 ++++++++++----------
> =A0drivers/staging/tidspbridge/rmgr/proc.c =A0 =A0 =A0 =A0 =A0 =A0| =A0=
137 ++++++------
> =A0drivers/staging/tidspbridge/rmgr/pwr.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 26 +--
> =A0drivers/staging/tidspbridge/rmgr/rmm.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 12 +-
> =A0drivers/staging/tidspbridge/rmgr/strm.c =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 75 ++++----
> =A0drivers/staging/tidspbridge/services/cfg.c =A0 =A0 =A0 =A0 | =A0 2=
1 +-
> =A030 files changed, 710 insertions(+), 771 deletions(-)
>
>
