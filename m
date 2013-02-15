From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/RFT PATCH 2/2] SERIAL: OMAP: Remove the idle handling from
 the driver
Date: Fri, 15 Feb 2013 15:34:39 +0200
Message-ID: <20130215133439.GF16558@arwen.pp.htv.fi>
References: <1360930135-32092-1-git-send-email-santosh.shilimkar@ti.com>
 <20130215125740.GB16558@arwen.pp.htv.fi>
 <511E35D8.1030109@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41575 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753967Ab3BONey (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 08:34:54 -0500
Content-Disposition: inline
In-Reply-To: <511E35D8.1030109@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Rajendra nayak <rnayak@ti.com>

--/QKKmeG/X/bPShih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 15, 2013 at 06:49:20PM +0530, Santosh Shilimkar wrote:
> >>@@ -279,8 +259,6 @@ static void serial_omap_stop_tx(struct uart_port *p=
ort)
> >>  		serial_out(up, UART_IER, up->ier);
> >>  	}
> >>
> >>-	serial_omap_set_forceidle(up);
> >>-
> >>  	pm_runtime_mark_last_busy(up->dev);
> >>  	pm_runtime_put_autosuspend(up->dev);
> >>  }
> >>@@ -348,7 +326,6 @@ static void serial_omap_start_tx(struct uart_port *=
port)
> >>
> >>  	pm_runtime_get_sync(up->dev);
> >>  	serial_omap_enable_ier_thri(up);
> >>-	serial_omap_set_noidle(up);
> >
> >this patch is changing behavior. Currently driver has:
> >
> >start_tx()
> >get_sync()
> >set_noidle()
> >put_autosuspend()
> >
> >....
> >
> >stop_tx()
> >get_sync()
> >set_force_idle()
> >put_autosuspend()
> >
> >with this change, you will have:
> >
> >start_tx()
> >get_sync()
> >set_noidle()
> >put_autosuspend()
> >set_force_idle()
> >
> >this in itself might be enough to go back to corrupted serial if
> >put_autosuspend is so quick that set_force_idle() is called before all
> >data has been shifted out of FIFO and through the UART lines.
> >
> Really. Infact the old sequence was buggy because you are setting
> force_idle even before suspending the device. And that force idle

then that bug has to be fixed first and patch needs to be sent to stable
before we change that part of the code, wouldn't you agree ?

> isn't really force idle but setting ip to smart idle. Just look at
> what serial.c

indeed.

> >Before doing this, you should at least test that removing
> >pm_runtime_mark_last_busy() and pm_runtime_put_autosuspend() from
> >start_tx() and removing pm_runtime_get_sync() from stop_tx() works fine.
> >
> Seems to work for me with above changes as well. Can you please
> try out and see if you see any issue. I doubt you will...

what I'm saying is that current code, as you put it yourself, is buggy,
so we ought to fix the bugs first before changing behavior. If not for
anything else, at least to have a clean tree which we can bisect.

> >Also, $SUBJECT isn't improving the situation regarding UART Wakeup,
> >there is still the regression of UART never being wakeup capable.
> >
> You are mixing the stuff here. The subject is correct.

->enable_wakeup() sets the IP to smart_idle_wakeup, which is done on
SYSC register. If $SUBJECT wants to fix SYSC usage, it ought to fix them
all.

> >I wonder what are your ideas to sort that part out, I mean, how do you
> >plan to implement ->set_wake() for the tty port ?
> >
> That is not related to module idle modes. It is for ioring and that
> needs pin control support. As you can see the patch doesn't touch
> omap_uart_enable_wakeup(). Thats needs pincontrol support so that

see above.

--=20
balbi

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHjlvAAoJEIaOsuA1yqRE+7sP+wW0ACdvvLbCCTNKBl0QSX9k
mSDB2vVnlvks1brILEe49wB0RjDgRCNOSm1li+evj5t05NiFB8Q0GiS00DsX8OWC
0QYitpNwGYYehBNiu5+wKXCZsyRB9BnQjEqhbI1759I0nWbjmIA6vDO64++nDDTl
3OIZR90s5lMQxs32aVu6oQp5sfnKggyf1CsMw6j36yh/lZqUKxJp7n6lBVqDP4qV
i4M7xX3hUGy5VZB6Td/3U5g5d4Qk6Z6iMZyK8+KI7o8YzJxakSEBxjMiijpWA6QA
ZxOi3oeBkke4Qu5j8q3Lvk/3xJAIbrEGvMPIgGxSN7yXPSerDLv2EXhznKvHCOvK
Vd5V3noDhkaC8R2ZZIZVoWG9Oew2wFsltcDcubfYxeN8JeIVDjZkvf6xygElyZdG
XiIc0cztYE8mgANWt5aAADlpU5wtg0RRGvYBwk8S0XfecBStXXL4dlKfx1nXDWJ7
MWf+y74tPX/h5wMI5FJzH0nM0/QCapRRm/eDU9gAbtC7nH3dmLLIEOFAQLoVDqp+
hffPtuRDxFxjNxzKeNn2+89Rcy060bNSohUizKLvbGDlNkNChyKpKDJToYE4+DT4
oBI8B4K/gNYVKtYLnb7BjWxfgYqHhZD4k9M7n5OYAvF22cghxTFPGbxo+nTfnFpq
hobI5nsQjgA5nxOxXHh7
=j0j3
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--
