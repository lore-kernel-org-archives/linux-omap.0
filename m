From: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Tue, 05 Apr 2016 17:18:50 +0200
Message-ID: <xa1t4mbgxew5.fsf@mina86.com>
References: <Pine.LNX.4.44L0.1603311255560.1516-100000@iolanthe.rowland.org> <xa1tmvpdz2h4.fsf@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <xa1tmvpdz2h4.fsf-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 01 2016, Michal Nazarewicz wrote:
> For legacy/nokia setting no_configfs should be a valid solution:
>
> ---- >8 -------------------------------------------------------------=
---
> diff --git a/drivers/usb/gadget/legacy/nokia.c b/drivers/usb/gadget/l=
egacy/nokia.c
> index 0997504..e4bc607 100644
> --- a/drivers/usb/gadget/legacy/nokia.c
> +++ b/drivers/usb/gadget/legacy/nokia.c
> @@ -223,6 +223,7 @@ static int nokia_bind_config(struct usb_configura=
tion *c)
>         }
> =20
>         fsg_opts =3D fsg_opts_from_func_inst(fi_msg);
> +       fsg_opts->no_configfs =3D true;
> =20
>         status =3D fsg_common_run_thread(fsg_opts->common);
>         if (status)
> ---- >8 -------------------------------------------------------------=
---
>
> This is what other legacy gadgets do after all.

Scratch that.  legacy/nokia sets no_configfs in nokia_bind so
legacy/nokia appears to be a different issue all together.

--=20
Best regards
=E3=83=9F=E3=83=8F=E3=82=A6 =E2=80=9C=F0=9D=93=B6=F0=9D=93=B2=F0=9D=93=B7=
=F0=9D=93=AA86=E2=80=9D =E3=83=8A=E3=82=B6=E3=83=AC=E3=83=B4=E3=82=A4=E3=
=83=84
=C2=ABIf at first you don=E2=80=99t succeed, give up skydiving=C2=BB
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
