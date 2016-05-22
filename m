From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC PATCH 1/2] Input: rotary-encoder- Add support for absolute
 encoder
Date: Sun, 22 May 2016 12:26:06 +0200
Message-ID: <20160522102606.GB23704@pengutronix.de>
References: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
 <1463648641-6931-2-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463648641-6931-2-git-send-email-vigneshr@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jonathan Corbet <corbet@lwn.net>, Johan Hovold <johan@kernel.org>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Masanari Iida <standby24x7@gmail.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, S Twiss <stwiss.opensource@diasemi.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Moritz Fischer <moritz.fischer@ettus.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Timo Teras <timo.teras@iki.fi>, Guido Martinez <guido@vanguardiasur.com.ar>, Clifton Barnes <clifton.a.barnes@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello,

On Thu, May 19, 2016 at 02:34:00PM +0530, Vignesh R wrote:
> There are rotary-encoders where GPIO lines reflect the actual positio=
n
> of the rotary encoder dial. For example, if dial points to 9, then fo=
ur
> GPIO lines connected to the rotary encoder will read HLLH(1001b =3D 9=
).
> Add support for such rotary-encoder.
> The driver relies on rotary-encoder,absolute-encoder DT property to
> detect such encoders.
> Since, GPIO IRQs are not necessary to work with
> such encoders, optional polling mode support is added using

I don't understand this. It's necessary in the same way as with the
already supported devices. I.e. you want to trigger an irq when the
encoder is moved and then check for it's position in the handler.

> diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.t=
xt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> index 6c9f0c8a846c..9c928dbd1500 100644
> --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> @@ -12,6 +12,10 @@ Optional properties:
>  - rotary-encoder,relative-axis: register a relative axis rather than=
 an
>    absolute one. Relative axis will only generate +1/-1 events on the=
 input
>    device, hence no steps need to be passed.
> +- rotary-encoder,absolute-encoder: support encoders where GPIO lines
> +  reflect the actual position of the rotary encoder dial. For exampl=
e,
> +  if dial points to 9, then four GPIO lines read HLLH(1001b =3D 9).
> +  In this case, rotary-encoder,steps-per-period needed not be define=
d.

IMHO this is wrong, I'd formalize this device as:

	{
		compatible =3D "rotary-encoder";
		gpios =3D <&gpio 19 1>, <&gpio 20 0>, <...>, <...>;
		rotary-encoder,encoding =3D "binary";
		rotary-encoder,steps =3D <16>;
		rotary-encoder,steps-per-period =3D <16>;
		rotary-encoder,rollover;
	}

and support this with a v4 of

	http://thread.gmane.org/gmane.linux.kernel.input/48892

=2E

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
