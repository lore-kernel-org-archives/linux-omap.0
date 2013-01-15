From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 00/10] MFD: twl-core: Cleanup part 2 for 3.9
Date: Tue, 15 Jan 2013 09:20:50 +0100
Message-ID: <50F51162.1080606@ti.com>
References: <1356952171-6109-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1356952171-6109-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Samuel,

On 12/31/2012 12:09 PM, Peter Ujfalusi wrote:
> Hello,
>=20
> Second part of the cleanup of twl-core which aims to make the code a =
bit more
> readable.
> It has been tested on: OMAP4 PandaBoard, OMAP4 Blaze, OMAP3 BeagleBoa=
rd, OMAP3
> Zoom2.

I will resend the series since I need to add two more patches to avoid =
build
breakage in zoom2.

>=20
> Regards,
> Peter
> ---
> Peter Ujfalusi (10):
>   mfd: twl-core: Clean up module id lookup and definitions
>   mfd: twl-core: No need to check for invalid subchip ID
>   mfd: twl-core: Use the lookup table to find the correct subchip for
>     the modules
>   mfd: twl-core: Allocate twl_modules dynamically
>   mfd: twl-core: Do not try to call legacy mfd add_children() when
>     booted with DT
>   mfd: twl-core: Do not create dummy pdata when booted with DT
>   mfd: twl-core: Move 'inuse' check early at probe time
>   mfd: twl-core: Collect global variables behind one private structur=
e
>     (global)
>   mfd: twl-core: Remove no longer valid comment regarding to write
>     buffer size
>   mfd: twl-core: Move twl_i2c_read/write_u8 to header as inline funct=
ion
>  drivers/mfd/twl-core.c  | 362 +++++++++++++++++++++-----------------=
----------
>  include/linux/i2c/twl.h |  84 +++++------
>  2 files changed, 205 insertions(+), 241 deletions(-)
>=20


--=20
P=E9ter
