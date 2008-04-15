From: David Brownell <david-b@pacbell.net>
Subject: Re: GPIO issue
Date: Tue, 15 Apr 2008 15:55:15 -0700
Message-ID: <200804151555.15722.david-b@pacbell.net>
References: <ae36f8040804151529s4787856ci5d3dbd7f539a6525@mail.gmail.com> <ae36f8040804151539t50ecece8v867977c7fe7f7578@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:20422 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752637AbYDOWzT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Apr 2008 18:55:19 -0400
In-Reply-To: <ae36f8040804151539t50ecece8v867977c7fe7f7578@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lvcargnini@gmail.com
Cc: linux-omap@vger.kernel.org

On Tuesday 15 April 2008, Lu=EDs Vit=F3rio Cargnini wrote:
>=20
> excuse me now I saw I just put the wrong value in =A0set_direction
> =A0 omap_set_gpio_direction(8,1);
>=20
> must be
> =A0 omap_set_gpio_direction(8,0);

This is one of *many* reasons to avoid using those
legacy GPIO calls.  If you had written

	gpio_direction_input(8)

instead of that first call, the issue would have been obvious.  :)

	if (gpio_request(8, "signal_name") =3D=3D 0)
		gpio_direction_output(8, 1 /* initial value */);
	else
		/* ERROR */ ;

Note that /sys/kernel/debug/gpio shows GPIO status,
assuming you have debugfs mounted in the normal way.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
